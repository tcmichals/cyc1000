#ifndef ALTERA_BYTE_DEV_H_
#define ALTERA_BYTE_DEV_H_

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include "system.h"  

#include "altera_avalon_spi_regs.h"
#include "altera_avalon_spi.h"
#include "altera_queue.h"


// -------------------------------
// Byte device struct definition
//
// -------------------------------
typedef struct s_byte_channel_struct
{
        int (*send_and_get_bytes)(alt_u8*, alt_u8*, int, void*); 
        Queue spi_q;
        int use_idle;
        long tick_count;
        void *device;

} s_byte_channel;

//-------------------------------------
// Internal Prototypes
//-------------------------------------

unsigned char xor_20(unsigned char val);

//-------------------------------------
// Public Prototypes
//-------------------------------------

//-------------------------------------
// SPI Specific API
//-------------------------------------

typedef void* byte_channel_handle;

int alt_spi_bytestream_init (
    byte_channel_handle* alt_bytestream_handle_out,
    int (*send_and_get_bytes)(alt_u8* txbuf, alt_u8* rxbuf, int len, void* context), 
    spi_device_handle context );

int alt_spi_bytestream_kill (byte_channel_handle alt_bytestream_handle);

//-------------------------------------
// Byte Stream API
//-------------------------------------

int alt_bytestream_tick(
    void* alt_bytestream_handle);

int alt_bytestream_send (
void* alt_bytestream_handle, 
alt_u8* txbuf, 
int buffer_len,
int timeout); 

int alt_spi_bytestream_clear (byte_channel_handle alt_bytestream_handle);

int alt_bytestream_get (
void* alt_bytestream_handle, 
alt_u8* rxbuf,
int* received_count_out,
int buffer_len,
int timeout );// set timeout=0 for non-blocking, -1 for wait forever. 


#endif /*ALTERA_BYTE_DEV_H_*/
