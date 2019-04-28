#include <stdlib.h>
#include "transaction_channel.h"

// ------------------------------------
// Ladies and gents, our transaction opcodes
// ------------------------------------
#define SEQUENTIAL_WRITE 0x04
#define SEQUENTIAL_READ  0x14
#define NON_SEQUENTIAL_WRITE 0x00
#define NON_SEQUENTIAL_READ  0x10


#define HEADER_LEN 8

// ------------------------------------
// Function prototypes
// ------------------------------------
static int do_transaction(unsigned char trans_type, unsigned int size,  unsigned int address, unsigned char* data, transaction_channel_handle TCH);

// ------------------------------------
// Internal structs
// ------------------------------------
typedef struct write_response_struct
{
    unsigned char   trans_type;
    unsigned char   extra;
    unsigned short  size;
} s_write_response;

int transaction_channel_write (transaction_channel_handle TCH,
                               unsigned int               address,
                               unsigned int               burst_length,
                               unsigned char*             data_buffer,
                               unsigned int               sequential)
{
    return sequential?do_transaction(SEQUENTIAL_WRITE, burst_length, address, data_buffer, TCH):do_transaction(NON_SEQUENTIAL_WRITE, burst_length, address, data_buffer, TCH);
}

int transaction_channel_read  (transaction_channel_handle TCH,
                               unsigned int               address,
                               unsigned int               burst_length,
                               unsigned char*             data_buffer,
                               unsigned int               sequential)
{
    return sequential?do_transaction(SEQUENTIAL_READ, burst_length, address, data_buffer, TCH):do_transaction(NON_SEQUENTIAL_READ, burst_length, address, data_buffer, TCH);
}

int transaction_channel_open (transaction_channel_handle* TCH,
                              packet_channel_handle PCH)
{
    *TCH = PCH;
    return 0;
}

int transaction_channel_close (transaction_channel_handle TCH)
{
    return 0;
}

static int do_transaction(unsigned char trans_type,
                            unsigned int size, 
                            unsigned int address, 
                            unsigned char* data, 
                            transaction_channel_handle TCH)
{
    int i;
    int response_length = 0;
    unsigned char header[8];
    unsigned char* transaction;
    unsigned char* p;
    
    s_write_response write_response;
    packet_channel_handle PCH = (packet_channel_handle) TCH;
    
    //------------------------------------------
    // Let's make our transaction header. Some clever folks tend 
    // to get fancy with integers and other large datatypes, 
    // and then the penny drops when they hit endian issues.
    //
    // We'll just avoid all that gas by using plain old bytes.
    // The hardware transactor on the other end of this channel 
    // expects the bytes to be in a certain order as coded
    // below. 
    //------------------------------------------
    header[0] = trans_type;
    header[1] = 0;
    header[2] = (size >> 8) & 0xff;
    header[3] = (size & 0xff);
    header[4] = (address >> 24) & 0xff;
    header[5] = (address >> 16) & 0xff;
    header[6] = (address >> 8)  & 0xff;
    header[7] = (address & 0xff);
    
    switch(trans_type)
    {
        case NON_SEQUENTIAL_WRITE:
        case SEQUENTIAL_WRITE:
        case 0x05:
        case 0x08:
        case 0x09:
        case 0x0A:
                    //------------------------------------------
                    // Build up the transaction
                    //------------------------------------------
                    transaction = (unsigned char *) malloc ((size + HEADER_LEN) * sizeof(unsigned char));
                    p = transaction;
                    
                    for (i = 0; i < HEADER_LEN; i++)
                        *p++ = header[i];
    
                    for (i = 0; i < size; i++)
                        *p++ = *data++;
                        
                    //------------------------------------------
                    // Send the header and data
                    //------------------------------------------
                    packet_channel_send_packet (PCH, 
                                            size + HEADER_LEN, 
                                            transaction);

                    //------------------------------------------
                    // Get the response from the send
                    //------------------------------------------
                    packet_channel_get_packet (PCH,
                                            &response_length,
                                            (unsigned char*) &write_response,
                                            4);
                                            
                    free(transaction);
                    break;
        case NON_SEQUENTIAL_READ:
        case SEQUENTIAL_READ:
        case 0x15:
        case 0x18:
        case 0x19:
        case 0x1A:
                    packet_channel_send_packet (PCH, 8, header); 
                    packet_channel_get_packet  (PCH, &response_length, data, size);

                    break;
        case 0x7F:
        default:
                    packet_channel_send_packet (PCH, 8, header);
                    packet_channel_get_packet  (PCH, &response_length, (unsigned char*) &write_response, 4); 
        
                    break;
    }
    
    return 0;
}
