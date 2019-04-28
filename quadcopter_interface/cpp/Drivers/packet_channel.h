#ifndef PACKET_CHANNEL_H_
#define PACKET_CHANNEL_H_

// -------------------------------
// Packet channel handle
// -------------------------------
typedef void* packet_channel_handle;

// -------------------------------
// Opens a packet channel, bound to the specified
// <send_bytes> and <get_bytes> functions.
// -------------------------------
int packet_channel_open (packet_channel_handle* PCH,
                        int (*send_bytes) (void*, char*, int, int),
                        int (*get_bytes)  (void*, char*, int*, int, int),
                        void* byte_channel_handle);

// --------------------------------
// Helper funtion to setup the timeout 
// for the Byte level device
// So that it will not be blocking
// --------------------------------
int packet_channel_set_timeout(packet_channel_handle* PCH, int timeout);


// -------------------------------
// Closes a packet channel
// -------------------------------
int packet_channel_close (packet_channel_handle PCH);


// -------------------------------
// Send a packet of packet_length bytes on 
// this channel
// -------------------------------
int packet_channel_send_packet (packet_channel_handle PCH,
                                unsigned int          packet_length,
                                unsigned char*        data_buffer);

// -------------------------------
// Get a packet of packet_length bytes 
// on this channel
// -------------------------------
int packet_channel_get_packet  (packet_channel_handle PCH,
                                unsigned int*         packet_length,
                                unsigned char*        data_buffer,
                                unsigned int          buffer_size);

#endif /*PACKET_CHANNEL_H_*/
