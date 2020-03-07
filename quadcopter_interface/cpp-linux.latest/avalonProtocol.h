#include <iostream>
#include <cstdint>
#include <boost/asio.hpp>
#include <memory>
#include <vector>
#include <deque>
#include <functional>
#include <vector>
#include <deque>
#include <atomic>
#include <condition_variable>
#include <atomic>
#include <tuple>

#include "transport.h"

#define SOP         0x7A
#define EOP         0x7B
#define CHANNEL     0x7C
#define ESC         0x7D

enum class Avalon_Trans_Type
{

    WRITE_NON_INCREMENTING=0x00,
    WRITE_INCREMENTING=0x04,
    READ_NON_INCREMENTING=0x10,
    READ_INCREMENTING =0x14,
    LOOP_BACK=0x7F
};
#define HEADER_LEN               8

inline
static uint8_t xor_20(uint8_t val)
{
    return val ^ 0x20;
}
#pragma once 

class avalonProtocol
{

public:
    typedef std::vector<uint8_t> array_t;
    enum { max_length = 1024 };

    enum class parserState
    {
        WaitingForSOP,
        WaitingForDataorESCorEOP,
        WaitingForLastByte,
        WaitingForDataESC,
        Done,
    };

protected:

    bool do_transaction( avalonProtocol::array_t &tx_packet,
                        Avalon_Trans_Type trans_type, 
                        uint32_t address, 
                        int channel_number= -1, 
                        const array_t &data = array_t(),
                        int burst_length=-1);

    bool packet_channel_send_packet(  avalonProtocol::array_t &tx_packet,int channel_number);                      

    

public:
    avalonProtocol();
    virtual ~avalonProtocol();
    bool transaction_channel_read(  avalonProtocol::array_t &tx_packet,
                                    uint32_t addr, 
                                    int channel_number=-1, 
                                    int burst_length=4, 
                                    Avalon_Trans_Type transaction=Avalon_Trans_Type::LOOP_BACK);

    bool transaction_channel_write( avalonProtocol::array_t &tx_packet, 
                                    uint32_t addr,  
                                    int channel_number=-1, 
                                    const array_t &data_buffer=array_t(), 
                                    Avalon_Trans_Type transaction=Avalon_Trans_Type::LOOP_BACK, 
                                    int burst_length=-1);

    static bool read(avalonProtocol::array_t &tx_packet,
                    size_t &bytesProcessed,
                    avalonProtocol::parserState &state,
                    const uint8_t *pRx, size_t bytesInRx);

};

/**
 * @brief Construct a new avalon Protocol::avalon Protocol object
 * 
 */
inline 
avalonProtocol::avalonProtocol()
{


} 

/**
 * @brief Destroy the avalon Protocol::avalon Protocol object
 * 
 */
inline
avalonProtocol::~avalonProtocol()
{

}



/**
 * @brief 
 * 
 * @param data_buffer 
 * @param channel_number 
 * @return true 
 * @return false 
 */
bool avalonProtocol::packet_channel_send_packet( avalonProtocol::array_t &tx_packet,
                                                 int channel_number)
{
    try
    {
        // ------------------------------------
        // Before we start, let 's figure out what the maximum' \
        // length of the packet is going to be so we can allocate
        // a chunk of memory for it.
        //
        // All packets start with an SOP byte, followed by a channel
        // id (2 bytes) and end with an EOP.That's 4 bytes.
        //
        // However, we have to escape characters that are the same
        // as any of the SOP / EOP / channel bytes.Worst case scenario
        // is that each data byte is escaped, which leads us to the
        // algorithm below.
        // ------------------------------------
    
        array_t packet_to_send;
        uint8_t current_byte;


        if (channel_number != -1)
        {
            packet_to_send.push_back(CHANNEL);
            packet_to_send.push_back(channel_number);
        }

        packet_to_send.push_back(SOP);

        for( size_t offset = 0; offset < tx_packet.size(); ++offset)
        {
            if (offset == tx_packet.size()-1)
            {
                packet_to_send.push_back(EOP);
            }

            current_byte = tx_packet[offset];
            switch(current_byte)
            {
                case SOP:
                case EOP:
                case CHANNEL:
                case ESC:
                    packet_to_send.push_back(ESC);
                    packet_to_send.push_back(xor_20(current_byte));
                break;

                default:
                      packet_to_send.push_back(current_byte);
                break;

            }
        }

        tx_packet = packet_to_send;
        return true;
    }
    catch(std::exception &ex)
    {
        return false;
    }
}


bool avalonProtocol::transaction_channel_write( avalonProtocol::array_t &tx_packet,
                                        uint32_t addr,  
                                        int channel_number, 
                                        const avalonProtocol::array_t &data_buffer, 
                                        Avalon_Trans_Type transaction, 
                                        int burst_length)
{
    return do_transaction(tx_packet,
                        transaction, 
                            addr, 
                            channel_number, 
                            data_buffer, 
                            burst_length);
}

inline
bool avalonProtocol::transaction_channel_read(avalonProtocol::array_t &tx_packet,
                                        uint32_t addr, 
                                        int channel_number, 
                                        int burst_length, 
                                        Avalon_Trans_Type transaction)
{
    array_t data;
    return do_transaction(tx_packet,
                            transaction, 
                            addr, 
                            channel_number, 
                            data, 
                            burst_length);
}

inline
bool avalonProtocol::do_transaction(avalonProtocol::array_t &tx_packet,
                                Avalon_Trans_Type trans_type, 
                                uint32_t address, 
                                int channel_number,  
                                const avalonProtocol::array_t &data,
                                int burst_length)
{
    // ------------------------------------------
    // Let's make our transaction header. Some clever folks tend
    // to get fancy with integers and other large datatypes,
    // and then the penny drops when they hit endian issues.
    //
    // We'll just avoid all that gas by using plain old bytes.
    // The hardware transactor on the other end of this channel
    // expects the bytes to be in a certain order as coded
    // below.
    // ------------------------------------------



    //# 0
    tx_packet.push_back(static_cast<uint8_t>(trans_type));
    //# 1
    tx_packet.push_back(0);

    if ((burst_length != -1) || (data.size() == 0))
    {
        //# 2
        tx_packet.push_back((burst_length >> 8) & 0xff);
        //# 3
        tx_packet.push_back(burst_length & 0xff);
    }
    else
    {
        //# 2
        tx_packet.push_back((data.size() >> 8) & 0xff);
        //# 3
        tx_packet.push_back(data.size() & 0xff);
    }

    //# 4
    tx_packet.push_back((address >> 24) & 0xff);
    //# 5
    tx_packet.push_back((address >> 16) & 0xff);
    //# 6
    tx_packet.push_back((address >> 8) & 0xff);
    //# 7
    tx_packet.push_back(address & 0xff);

    if (trans_type == Avalon_Trans_Type::WRITE_NON_INCREMENTING ||
        trans_type == Avalon_Trans_Type::WRITE_INCREMENTING ||
        (static_cast<int>(trans_type) == 0x5) || (static_cast<int>(trans_type) == 0x8) || (static_cast<int>(trans_type) == 0x9) || (static_cast<int>(trans_type) == 0xA))
    {
            for( auto &val : data)
                tx_packet.push_back(val);

            return packet_channel_send_packet(tx_packet, channel_number);
    }

    else if (trans_type == Avalon_Trans_Type::READ_INCREMENTING ||
             trans_type == Avalon_Trans_Type::READ_NON_INCREMENTING ||
            (static_cast<int>(trans_type) == 0x15) || (static_cast<int>(trans_type) == 0x18) || (static_cast<int>(trans_type) == 0x19) || (static_cast<int>(trans_type) == 0x1A) )
    {
            for( auto &val : data)
                tx_packet.push_back(val);

            packet_channel_send_packet(tx_packet, channel_number);
    }
    else
    {
        for( auto &val : data)
            tx_packet.push_back(val);

        return packet_channel_send_packet(tx_packet, channel_number);
    }
}


bool avalonProtocol::read(avalonProtocol::array_t &packet,
                    size_t &bytesProcessed,
                    avalonProtocol::parserState &state,
                    const uint8_t *pRx, size_t bytesInRx)
{

    bool rc = false;
    size_t pktSize = 0;
    for (size_t idx =0; idx < bytesInRx; idx++)
    {
        bytesProcessed++;

        switch(state)
        {
            case parserState::WaitingForSOP:
            {
                switch(pRx[idx])
                {
                    case SOP:
                        packet.clear();
                        state = parserState::WaitingForDataorESCorEOP;
                    break;

                    default:
                     // toss all data;
                    break;
                }
            }
            break;

            case parserState::WaitingForDataorESCorEOP:
            {
                switch(pRx[idx])
                {
                    case SOP:
                         packet.clear();
                        state = parserState::WaitingForDataorESCorEOP;
                    break;

                    case ESC:
                        state = parserState::WaitingForDataESC;
                    break;

                    case EOP:
                        state = parserState::WaitingForLastByte;
                    break;

                    default:
                         packet.push_back(pRx[idx]);
                    break;
                }

            }

            break;
            case parserState::WaitingForDataESC:
            {
                switch(pRx[idx])
                {
                    default:
                       packet.push_back(xor_20(pRx[idx]));
                       state = parserState::WaitingForDataorESCorEOP;
                    break;
                }
            }
            break;

            case parserState::WaitingForLastByte:
            {
                switch(pRx[idx])
                {
                    default:
                       packet.push_back(pRx[idx]);
                       state = parserState::Done;
                       rc = true;
                    break;
                }
            }
            break;

            case parserState::Done:
                return true;
                break;
        }

    }

    return rc;

}

//eof

