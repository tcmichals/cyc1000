#include <stdlib.h>
#include "packet_channel.h"

//------------------------------------
// Special packet characters
//------------------------------------
#define SOP     0x7a
#define EOP     0x7b
#define CHANNEL 0x7c
#define ESC     0x7d

typedef struct 
{
    int (*send_bytes) (void*, char*, int, int);
    int (*get_bytes)  (void*, char*, int*, int,  int);
    void* byte_channel_handle;
    int timeout;
} s_packet_channel;

//------------------------------------
// Function prototypes
//------------------------------------
static unsigned char xor_20(unsigned char val);

int packet_channel_send_packet (packet_channel_handle PCH,
                unsigned int          packet_length,
                unsigned char*        data_buffer)
{
    int i;
    int result = 0;
    
    //------------------------------------
    // Before we start, let's figure out what the maximum
    // length of the packet is going to be so we can allocate
    // a chunk of memory for it.
    //
    // All packets start with an SOP byte, followed by a channel
    // id (2 bytes) and end with an EOP. That's 4 bytes.
    //
    // However, we have to escape characters that are the same
    // as any of the SOP/EOP/channel bytes. Worst case scenario
    // is that each data byte is escaped, which leads us to the
    // algorithm below.  
    //------------------------------------
    int max_len = 2 * packet_length + 4;
    
    unsigned char *packet = (unsigned char *) malloc (max_len * sizeof(unsigned char));
    unsigned char *p = packet;
    unsigned char current_byte;
    s_packet_channel* pchannel = (s_packet_channel *) PCH;
    void* byte_channel_handle = pchannel->byte_channel_handle;
    
    //------------------------------------
    // SOP
    //------------------------------------
    *p++ = SOP;
    
    //------------------------------------
    // Channel information. For now, only packets
    // on channel 0 are defined.
    //------------------------------------
    *p++ = CHANNEL;
    *p++ = 0x0;

    //------------------------------------
    // Append the data to the packet
    //------------------------------------
    for (i = 0; i < packet_length; i++)
    {
        current_byte = data_buffer[i];
        //------------------------------------
        // EOP must be added before the last byte
        //------------------------------------
        if (i == packet_length-1)
        {
            *p++ = EOP;
        }

        //------------------------------------
        // Escape data bytes which collide with our
        // special characters.
        //------------------------------------
        switch(current_byte)
        {
            case SOP:
                        *p++ = ESC;
                        *p++ = xor_20(current_byte);
                        break;
            case EOP:
                        *p++ = ESC;
                        *p++ = xor_20(current_byte);
                        break;
            case CHANNEL:
                        *p++ = ESC;
                        *p++ = xor_20(current_byte);
                        break;
            case ESC:
                        *p++ = ESC;
                        *p++ = xor_20(current_byte);
                        break;
                        
            default:
                        *p++ = current_byte;
                        break;
        }
        
    }
    result = (*pchannel->send_bytes)(byte_channel_handle, packet, p - packet, pchannel->timeout); 
    
    free(packet);
    
    return result;
}

int packet_channel_get_packet  (packet_channel_handle PCH,
                unsigned int*         packet_length,
                unsigned char*        data_buffer,
                unsigned int          buffer_size)
{
    int i = 0;
    int recv_length;
    unsigned char *p = data_buffer;
    unsigned char current_byte;
  
    s_packet_channel* pchannel = (s_packet_channel *) PCH;
    void* byte_channel_handle = pchannel->byte_channel_handle;

    //------------------------------------ 
    // We want to obtain up to max_len bytes, or until an EOP
    // is received. So we only increment the loop counter
    // whenever a byte is added to the buffer.
    //
    // For EOP, we increment the loop to its penultimate
    // iteration so that it picks up the trailing byte(s)
    // following an EOP, and then exits.
    //------------------------------------
    while (i < buffer_size)
    {
        (*pchannel->get_bytes)(byte_channel_handle, &current_byte, &recv_length, 1, pchannel->timeout); 
        
        switch(current_byte)
        {
            case ESC:
                    (*pchannel->get_bytes)(byte_channel_handle, &current_byte, &recv_length, 1, pchannel->timeout); 
                    *p++ = xor_20(current_byte);
                    
                    i++;
                    break;
                    
            //------------------------------------
            // On SOP, reset the pointer to the start
            // of the data buffer.
            //------------------------------------
            case SOP:
                    p = data_buffer;
                    i = 0;
                    break;
                    
            //------------------------------------
            // We got an EOP! Let us return after getting
            // the trailing byte(s) following the EOP.
            //------------------------------------
            case EOP:
                    i = buffer_size - 1;
                    break;
            
                     
            default:
                    *p++ = current_byte;
                    i++;
                    break;
        }
    }
    
    *packet_length =  p - data_buffer; 
    return 0;
}

static unsigned char xor_20(unsigned char val)
{
    return val^0x20;
}


int packet_channel_open (packet_channel_handle* PCH,
            int (*send_bytes) (void*, char*, int, int),
            int (*get_bytes) (void*, char*, int*, int, int),
            void* byte_channel_handle)
{
    s_packet_channel *channel = (s_packet_channel *) malloc (sizeof(s_packet_channel));
    channel->send_bytes = send_bytes;
    channel->get_bytes = get_bytes;
    channel->byte_channel_handle = byte_channel_handle;
    channel->timeout = -1; //Default to no timeout
    *PCH = channel;
    return 0;
}

int packet_channel_set_timeout(packet_channel_handle* PCH, int timeout)
{
    s_packet_channel *channel = (s_packet_channel *)PCH;
    channel->timeout = timeout;
    return 0;
}

int packet_channel_close (packet_channel_handle PCH)
{
    return 0;
}



