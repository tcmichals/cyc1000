#include <cstdint>
#include <functional>
#include "addressmap.h"
#include "avalonProtocol.h"
#include "transport.h"

#define  PWM_DECODERS_ 7
class pwmDecoderAvalon
{

protected:
	std::array<uint32_t, PWM_DECODERS_> m_pwmDecoder;
	transportAvalon &m_transport;


protected:
	bool rxComplete(int errno, const transportAvalon::array_t &rxBuffer);
	bool txComplete(int errno, size_t bytesSent);

public:
	pwmDecoderAvalon(transportAvalon &transport);
	virtual ~pwmDecoderAvalon();
	bool postRead();
	uint16_t get(size_t index);
};

inline 
pwmDecoderAvalon::pwmDecoderAvalon(transportAvalon &transport): m_transport(transport)
{

}

inline
pwmDecoderAvalon::~pwmDecoderAvalon()
{
}

inline
uint16_t pwmDecoderAvalon::get(size_t index)
{
	return 0;
}

inline 
bool pwmDecoderAvalon::txComplete(int errno, size_t bytesSent)
{
	return true;

}

inline 	
bool pwmDecoderAvalon::rxComplete(int errno, const transportAvalon::array_t &rxBuffer) 
{
    if (rxBuffer.size() == ( sizeof(uint32_t) * PWM_DECODERS_))
    {
		for(size_t indx=0; indx < PWM_DECODERS_; ++indx)
		{
			m_pwmDecoder[indx] = *(reinterpret_cast<const uint32_t *>(rxBuffer.data())+indx);	
			if (m_pwmDecoder[indx] & 0x80000000)
			{
				std::cout << "pwm(" << indx << ") OFF" << std::endl;
			}
			else
			{
				std::cout << "pwm(" << indx << ") ON ";
				printf("%d\n",m_pwmDecoder[indx] & 0xFFFF );
			}
		}
	

	    return true;
    }
    else
    {
        std::cout << __PRETTY_FUNCTION__ << " ERROR wrong size "<< rxBuffer.size()  << std::endl;
        return false;
    }
    
}

inline
bool pwmDecoderAvalon::postRead()
{
	avalonProtocol protocol;
	avalonProtocol::array_t tx_packet;

	auto rxCallback = std::bind(&pwmDecoderAvalon::rxComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);

	auto txCallback = std::bind(&pwmDecoderAvalon::txComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);

	protocol.transaction_channel_read(tx_packet,
								PWM_DECODER_START_ADDRESS, 
								AVALON_CHANNEL, 
								sizeof(uint32_t) * PWM_DECODERS_, 
								Avalon_Trans_Type::READ_INCREMENTING);

		m_transport.postTransaction(tx_packet, txCallback, rxCallback);				

}


