#pragma once
#include <cstdint>
#include <functional>
#include "addressmap.h"
#include "avalonProtocol.h"
#include "transport.h"


#define DSHOT_OFF 48
#define MIN_ON 1
#define MID_ON (0x7FF/2)
#define MAX_ON (0x7FF)



class dshotAvalon
{


protected:
	transportAvalon &m_transport;


protected:
	bool rxComplete(int errno, const transportAvalon::array_t &rxBuffer);
	bool txComplete(int errno, size_t bytesSent);

public:
	dshotAvalon(transportAvalon &transport);
	virtual ~dshotAvalon();
	bool postDshotOut(const uint16_t out_1 = DSHOT_OFF, 
                    const uint16_t out_2 = DSHOT_OFF,
                    const uint16_t out_3 = DSHOT_OFF,
                    const uint16_t out_4 = DSHOT_OFF);              

};

inline 
dshotAvalon::dshotAvalon(transportAvalon &transport): m_transport(transport)
{

}

inline
dshotAvalon::~dshotAvalon()
{
}



inline 
bool dshotAvalon::txComplete(int errno, size_t bytesSent)
{
	return true;

}

inline 	
bool dshotAvalon::rxComplete(int errno, const transportAvalon::array_t &rxBuffer) 
{				
	return true;
}



 uint16_t prepareDshotPacket(uint16_t value)
{   
    uint16_t packet=  value << 1;

   
    // compute checksum
    unsigned csum = 0; 
    unsigned csum_data = packet;
    for (int i = 0; i < 3; i++) 
    {
        csum ^=  csum_data;   // xor data by nibbles
        csum_data >>= 4;
    }
    // append checksum

    csum &= 0xf;
    packet = (packet << 4) | csum;

    return packet;
}


inline
bool dshotAvalon::postDshotOut(  const uint16_t out_1, 
                                const uint16_t out_2,
                                const uint16_t out_3,
                                const uint16_t out_4)
{
	avalonProtocol protocol;
	avalonProtocol::array_t tx_packet;
    avalonProtocol::array_t data;

	auto rxCallback = std::bind(&dshotAvalon::rxComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);

	auto txCallback = std::bind(&dshotAvalon::txComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);
    uint32_t val = prepareDshotPacket(out_1);
printf("dhsot 0x%X\n", val);

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


