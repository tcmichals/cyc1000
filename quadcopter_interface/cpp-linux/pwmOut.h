#pragma once
#include <cstdint>
#include <functional>
#include "addressmap.h"
#include "avalonProtocol.h"
#include "transport.h"

#ifdef STANDARD_PWM
    #define MIN_ON (1 * 1000)
    #define MID_ON (1500)
    #define MAX_ON (19 * 100)
    #define MIN_OFF ( 2000)  /* 500us */
    #define MAX_TOTAL ( MAX_ON + MIN_OFF)
#else
    #define MIN_ON (125)
    #define MAX_ON (250)
    #define MID_ON ((MIN_ON/2) + MIN_ON)

#endif

class pwmOutAvalon
{


protected:
	transportAvalon &m_transport;


protected:
	bool rxComplete(int errno, const transportAvalon::array_t &rxBuffer);
	bool txComplete(int errno, size_t bytesSent);

public:
	pwmOutAvalon(transportAvalon &transport);
	virtual ~pwmOutAvalon();
	bool postPWMOut(const uint16_t pwmOut_1 = MIN_ON, 
                    const uint16_t pwmOut_2 = MIN_ON,
                    const uint16_t pwmOut_3 = MIN_ON,
                    const uint16_t pwmOut_4 = MIN_ON);              

};

inline 
pwmOutAvalon::pwmOutAvalon(transportAvalon &transport): m_transport(transport)
{

}

inline
pwmOutAvalon::~pwmOutAvalon()
{
}



inline 
bool pwmOutAvalon::txComplete(int errno, size_t bytesSent)
{
	return true;

}

inline 	
bool pwmOutAvalon::rxComplete(int errno, const transportAvalon::array_t &rxBuffer) 
{				
	return true;
}

inline
bool pwmOutAvalon::postPWMOut(  const uint16_t pwmOut_1, 
                                const uint16_t pwmOut_2,
                                const uint16_t pwmOut_3,
                                const uint16_t pwmOut_4)
{
	avalonProtocol protocol;
	avalonProtocol::array_t tx_packet;
    avalonProtocol::array_t data;

	auto rxCallback = std::bind(&pwmOutAvalon::rxComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);

	auto txCallback = std::bind(&pwmOutAvalon::txComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);
    uint32_t val = pwmOut_1;

    if ( pwmOut_1 > MAX_ON)
        val = MAX_ON;
    else if ( pwmOut_1 < MIN_ON)
        val = MIN_ON;

    val = (val << 16) | (MAX_ON);

    data.push_back(val & 0xFF);
    data.push_back(val >>8 & 0xFF);
    data.push_back(val>>16 & 0xFF);
    data.push_back(val>>24 & 0xFF);



	protocol.transaction_channel_write(tx_packet,
								PWM_OUT_START_ADDRESS, 
								AVALON_CHANNEL, 
                                data,
								Avalon_Trans_Type::WRITE_INCREMENTING);

		m_transport.postTransaction(tx_packet, txCallback, rxCallback);				

}


