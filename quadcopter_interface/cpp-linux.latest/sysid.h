#include <cstdint>
#include <functional>
#include "addressmap.h"
#include "avalonProtocol.h"
#include "transport.h"

#define sysID 0x11223344

class sysIDAvalon
{

protected:
	uint32_t m_sysID;
	transportAvalon &m_transport;


protected:
	bool rxComplete(int errno, const transportAvalon::array_t &rxBuffer);
	bool txComplete(int errno, size_t bytesSent);

public:
	sysIDAvalon(transportAvalon &transport);
	virtual ~sysIDAvalon();
	bool postReadID();
	uint32_t get();
};

inline 
sysIDAvalon::sysIDAvalon(transportAvalon &transport): m_transport(transport)
{

}

inline
sysIDAvalon::~sysIDAvalon()
{
}

inline
uint32_t sysIDAvalon::get()
{
	return m_sysID;
}

inline 
bool sysIDAvalon::txComplete(int errno, size_t bytesSent)
{
	return true;

}

inline 	
bool sysIDAvalon::rxComplete(int errno, const transportAvalon::array_t &rxBuffer) 
							
{

	m_sysID = * reinterpret_cast<const uint32_t *>(rxBuffer.data());

	printf("m_sysID 0x%X\n", m_sysID);
	return true;
}

inline
bool sysIDAvalon::postReadID()
{
	avalonProtocol protocol;
	avalonProtocol::array_t tx_packet;

	auto rxCallback = std::bind(&sysIDAvalon::rxComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);

	auto txCallback = std::bind(&sysIDAvalon::txComplete, this,
							    std::placeholders::_1, 
                                std::placeholders::_2);

	protocol.transaction_channel_read(tx_packet,
								SYSID_START_ADDRESS, 
								AVALON_CHANNEL, 
								4, 
								Avalon_Trans_Type::READ_NON_INCREMENTING);

		m_transport.postTransaction(tx_packet, txCallback, rxCallback);				

}


