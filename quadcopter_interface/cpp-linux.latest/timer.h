
#include <cstdint>
#include "addressmap.h"
#include "avalonProtocol.h"
#include "transport.h"

/* timer is 16 bit values

Byte address    reg address	info
0: 		0		is timer running bit 1
2: 		1		Control
4:		2		Period L
6:		3		Peroid H
8:		4		Snap L (Read)
A:		5		Snap H (Read
	
*/
class avalonTimer
{

protected:
	transportAvalon &m_transport;
	uint16_t m_status;
	uint32_t m_count;

enum class TimerRegisters
{
	status = 0, 	/* 16 bits */
	control = 1,  	/* 16 bits */
	period = 2, 	/* 2 x  16 bits */
	snap = 4,		/* 2 x  16 bits */

};

protected:
	bool rxComplete(int errno, const transportAvalon::array_t &rxBuffer,TimerRegisters reg );
	bool txComplete(int errno, size_t bytesSent);
public:
	avalonTimer(transportAvalon &transport);
	virtual ~avalonTimer();
	bool getCurrentTimerValue();
	bool isTimerRunning();

};

inline 
avalonTimer::avalonTimer(transportAvalon &transport): m_transport(transport)
{

}

inline
avalonTimer::~avalonTimer()
{
}

inline 
bool avalonTimer::txComplete(int errno, size_t bytesSent)
{
	return true;

}
inline 	
bool avalonTimer::rxComplete(int errno, const transportAvalon::array_t &rxBuffer,TimerRegisters reg  )
{
	switch(reg)
	{
		case TimerRegisters::status:
		{
			m_status = * reinterpret_cast<const uint16_t *>(rxBuffer.data());
			printf("m_status 0x%X\n", m_status);
		}
		break;

		case TimerRegisters::snap:
		{
			m_count = * reinterpret_cast<const uint32_t *>(rxBuffer.data());
			printf("m_count 0x%X\n", m_count);
		}
		break;

		default:
		break;
	}
	return true;
}
inline
bool avalonTimer::getCurrentTimerValue()
{
	auto rxCallback = std::bind(&avalonTimer::rxComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2, 
								TimerRegisters::snap);

	auto txCallback = std::bind(&avalonTimer::txComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);								

	avalonProtocol protocol;
	avalonProtocol::array_t tx_packet;

	protocol.transaction_channel_read(tx_packet,
								TIMER_START_ADDRESS + static_cast<int>(TimerRegisters::snap), 
								AVALON_CHANNEL, 
								4,
								Avalon_Trans_Type::READ_INCREMENTING);
	m_transport.postTransaction(tx_packet, txCallback, rxCallback);
}

inline
bool avalonTimer::isTimerRunning()
{
	auto rxCallback = std::bind(&avalonTimer::rxComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2, 
								TimerRegisters::status);

	auto txCallback = std::bind(&avalonTimer::txComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);	


	avalonProtocol protocol;
	avalonProtocol::array_t tx_packet;

	protocol.transaction_channel_read(tx_packet,
								TIMER_START_ADDRESS + static_cast<int>(TimerRegisters::status), 
								AVALON_CHANNEL, 
								2, 
								Avalon_Trans_Type::READ_INCREMENTING);

	m_transport.postTransaction(tx_packet, txCallback, rxCallback);
}


