#ifndef TRANSACTION_CHANNEL_H_
#define TRANSACTION_CHANNEL_H_

#include "packet_channel.h"

// -------------------------------
// Transaction channel handle
// -------------------------------
typedef void* transaction_channel_handle;

// -------------------------------
// Perform an Avalon-MM write transaction of burst_length 
// bytes on this channel to the specified address.
// -------------------------------
int transaction_channel_write (transaction_channel_handle TCH,
                               unsigned int               address,
                               unsigned int               burst_length,
                               unsigned char*             data_buffer,
                               unsigned int               sequential);

// -------------------------------
// Perform an Avalon-MM read transaction of burst_length 
// bytes on this channel to the specified address.
// -------------------------------
int transaction_channel_read  (transaction_channel_handle TCH,
                               unsigned int               address,
                               unsigned int               burst_length,
                               unsigned char*             data_buffer,
                               unsigned int               sequential);

// -------------------------------
// Opens a transaction channel, bound to this
// packet channel
// -------------------------------
int transaction_channel_open (transaction_channel_handle* TCH,
                  packet_channel_handle PCH);

// -------------------------------
// Close this transaction channel
// -------------------------------
int transaction_channel_close (transaction_channel_handle TCH);


#endif /*TRANSACTION_CHANNEL_H_*/
