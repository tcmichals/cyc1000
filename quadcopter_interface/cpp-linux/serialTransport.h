#include <array>
#include <iostream>
#include <iomanip>      // std::setiosflags, std::resetiosflags
#include <cstdint>
#include <boost/asio.hpp>
#include <memory>
#include <vector>
#include <deque>
#include <atomic>
#include <tuple>
#include <chrono>

#include "transport.h"
#include "avalonProtocol.h"


class transaction_item
{
    public:
        typedef std::chrono::duration<int,std::milli> milliseconds_t;
        enum class state
        {
            idle,
            queued,
            startTx,
            startRx,
            done
        };

    public:
        std::chrono::time_point<std::chrono::high_resolution_clock> m_startTime;
        milliseconds_t m_txComplete;
        milliseconds_t m_rxComplete;

        transportAvalon::array_t rx_packet;
        transportAvalon::array_t tx_packet; 
        
        avalonProtocol::parserState m_rxState;
        transportAvalon::txDone_Callback_t tx_callBack;
        transportAvalon::rxDone_Callback_t rx_callBack;
        size_t m_rxBytesProcessed;

        state m_state;
        size_t  m_majic;

        void updateStartTime();
        void updateTxDoneTime();
        void updateRxDoneTime();
        transaction_item();
        ~transaction_item();
 };

inline 
transaction_item::transaction_item():m_txComplete(0),
                                    m_rxComplete(0),
                                    m_rxBytesProcessed(0),
                                     m_state(transaction_item::state::idle),
                                     m_rxState(avalonProtocol::parserState::WaitingForSOP),
                                     m_majic(0)

{

}

transaction_item::~transaction_item()
{

}

inline
void transaction_item::updateStartTime()
{
       m_startTime =  std::chrono::high_resolution_clock::now();
}

inline
void transaction_item::updateTxDoneTime()
{
    m_txComplete =  std::chrono::duration_cast<std::chrono::milliseconds>(
                                    std::chrono::high_resolution_clock::now() - m_startTime);
}

inline
void transaction_item::updateRxDoneTime()
{
    m_rxComplete =  std::chrono::duration_cast<std::chrono::milliseconds>(
                                    std::chrono::high_resolution_clock::now() - m_startTime);
}

       


class serialTransPort : public transportAvalon
{

protected:
    std::unique_ptr<boost::asio::serial_port>   m_serialPort;
    boost::asio::io_context                     &m_io_context;

    enum buffer_tx 
    { 
        buffer_size =512
    };

    std::array<uint8_t, buffer_size> m_rxBuffer;

    std::mutex                      m_mutex;
    std::size_t                     m_numBytesSent;
    std::deque<transaction_item>  m_queue;
    transaction_item              m_inWork;
    size_t                          m_next;

    transaction_item::milliseconds_t m_txMaxComplete;
    transaction_item::milliseconds_t m_rxMaxComplete;

    void start_read(void);
    void do_write(void);
    void checkForWork(void);
    size_t bytesInTxQueue(void);
    bool send();

public:
        serialTransPort(boost::asio::io_context &io_context);
virtual ~serialTransPort();
bool start(const std::string &deviceName);
 bool dumpTimes();

virtual bool postTransaction(const array_t &,
                            const txDone_Callback_t &,
                            const transportAvalon::rxDone_Callback_t &)  override;

};


inline 
serialTransPort::serialTransPort(boost::asio::io_context &io_context): m_io_context(io_context),
                                                                        m_numBytesSent(0),
                                                                        m_next(0),
                                                                        m_txMaxComplete(0),
                                                                        m_rxMaxComplete(0)
{

} 
/**
 * @brief Destroy the avalon Bus::avalon Bus object
 * 
 */
inline
serialTransPort::~serialTransPort()
{

}

/**
 * @brief 
 * 
 * @param deviceName 
 * @return true 
 * @return false 
 */
inline
bool serialTransPort::start(const std::string &deviceName)
{
	boost::system::error_code ec;
    bool rc = false;

	try
	{
		m_serialPort = std::make_unique<boost::asio::serial_port>(m_io_context);
		m_serialPort->open(deviceName);
        if (!m_serialPort->is_open())
            return false;

        m_serialPort->set_option(boost::asio::serial_port_base::baud_rate(230400));
        m_serialPort->set_option(boost::asio::serial_port_base::flow_control(boost::asio::serial_port_base::flow_control::type::none));
        m_serialPort->set_option(boost::asio::serial_port_base::character_size(8));
        m_serialPort->set_option(boost::asio::serial_port_base::parity(boost::asio::serial_port_base::parity::none));
        m_serialPort->set_option(boost::asio::serial_port_base::stop_bits(boost::asio::serial_port_base::stop_bits::type::one));
  //      int fd = m_serialPort->native_handle();
//ioctl(fd, TIOCGSERIAL, &serial);
//serial.flags |= ASYNC_LOW_LATENCY;
//ioctl(fd, TIOCSSERIAL, &serial);

        start_read();

		rc = true;
	}
	catch(boost::system::error_code &ex)
	{
		rc = false;
	}
	catch(std::exception  &ex)
	{
		std::cerr << __PRETTY_FUNCTION__ << " " << ex.what() << std::endl;
		rc = false;
	}
	catch(...)
	{
		rc = false;
	}

	return rc;
}


inline 
void dump(const char *pStr, const uint8_t *pRx, size_t len)
{
#ifdef TCM    
    std::cout << pStr;
    for (size_t index=0; index < len; ++index)
    {
        printf(" %02X", pRx[index]);
    }
    std::cout << std::endl;
#endif    
}


bool serialTransPort::postTransaction(const array_t &txPacket,
                            const transportAvalon::txDone_Callback_t &txCallback,
                            const transportAvalon::rxDone_Callback_t &rxCallback)
 
{
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        transaction_item item;
        item.tx_packet = txPacket;
        item.tx_callBack = txCallback;
        item.rx_callBack = rxCallback;
        item.updateStartTime();
        item.m_majic = m_next++;
        if (m_queue.size() < 30)
        {
            m_queue.push_back(item);
        }
        else
        {
            std::cerr << "too much" << std::endl;
        }
    }
    
    send();
}
/**
 * @brief 
 * 
 */
inline 
void serialTransPort::start_read()
{
    m_serialPort->async_read_some(boost::asio::buffer(m_rxBuffer, m_rxBuffer.size()),
    [this](const boost::system::error_code &ec, std::size_t length)
    {
          if (!ec)
          {
            dump("RX:", m_rxBuffer.data(), length);
            if (m_inWork.m_state != transaction_item::state::idle)
            {
                bool isDone = avalonProtocol::read(m_inWork.rx_packet,
                                        m_inWork.m_rxBytesProcessed,
                                        m_inWork.m_rxState,
                                        m_rxBuffer.data(), length);
                if (isDone)
                {
                    m_inWork.updateRxDoneTime();
                    if(m_inWork.rx_callBack)
                         m_inWork.rx_callBack(0,m_inWork.rx_packet);

                    std::lock_guard<std::mutex> lock(m_mutex);
                        if (m_inWork.m_txComplete > m_txMaxComplete)
                        {
                            m_txMaxComplete = m_inWork.m_txComplete;
                        }
                       if (m_inWork.m_rxComplete > m_rxMaxComplete)
                        {
                            m_rxMaxComplete = m_inWork.m_rxComplete;
                        }                        
     
                    m_inWork = transaction_item();
                    if (m_queue.size())
                        m_queue.pop_front();

                     //post back to drain the work queue
                     m_io_context.post([this]() { send(); });
                }

     
                start_read();
            }
            else
            {
                  std::cerr << "trash" << std::endl;
            }
          }
     });
    
}

/**
 * @brief 
 * 
 */
inline
void serialTransPort::do_write()
{

    boost::asio::async_write(*m_serialPort.get(),
		        boost::asio::buffer(m_inWork.tx_packet.data() + m_numBytesSent,m_inWork.tx_packet.size() - m_numBytesSent),
        [this](boost::system::error_code ec, std::size_t length)
        {
          if (ec)
          {
            std::cerr << "Error:" << ec.message() << std::endl;
            m_serialPort->close();
          }
          else
          {
              m_numBytesSent += length;
              if (m_numBytesSent  ==  m_inWork.tx_packet.size())
              {
                m_numBytesSent = 0;
                m_inWork.m_state = transaction_item::state::startRx;
                m_inWork.updateTxDoneTime();
              
                if (m_inWork.tx_callBack)
                    m_inWork.tx_callBack(0, m_numBytesSent);
              }
              else
              {
                  m_numBytesSent += length;
                  m_io_context.post([this]() { do_write(); });
              }              
          }
        });

}

/**
 * @brief 
 * 
 * @param tx 
 * @return true 
 * @return false 
 */
inline
bool serialTransPort::send()
{
    if (m_inWork.m_state == transaction_item::state::idle)
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (m_queue.size())
        {
            m_inWork = m_queue[0];
            m_inWork.updateStartTime();
            m_inWork.m_state = transaction_item::state::startTx;
            dump("TX:",m_inWork.tx_packet.data(), m_inWork.tx_packet.size());
        }
        else
        {
             return false;
        }
    }
    else
    {
        return false;
    }
 
    //reset
    m_numBytesSent = 0;
    do_write();
}

inline
 bool serialTransPort::dumpTimes()
 {
   std::cout << "max TX:" << m_txMaxComplete.count() << std::endl;
   std::cout << "max RX:" << m_rxMaxComplete.count() << std::endl;

 }

//EOF


