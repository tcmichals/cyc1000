#include "altera_byte_dev_spi.h"

#define BYTESIDLECHAR 0x4a
#define BYTESESCCHAR  0x4d


int alt_spi_bytestream_init (
    byte_channel_handle* alt_bytestream_handle_out,
    int (*send_and_get_bytes)(alt_u8*, alt_u8*, int, void*), 
    spi_device_handle context )
{
    //Allocate a memory space for s_byte_channel (Byte Channel Handle)
    s_byte_channel * inst_dev = (s_byte_channel *)malloc(sizeof(s_byte_channel));

    //Initialize the Queue device
    queue_init(&inst_dev->spi_q);
 
    inst_dev->use_idle = 1;
    inst_dev->tick_count = 0;
    inst_dev->device = context;
    
    //Link up appropriate SPI send and get routine
    inst_dev->send_and_get_bytes = send_and_get_bytes;
    
    //Cross link the allocated s_byte_channel (Byte Channel Handle)
    *alt_bytestream_handle_out = inst_dev;
    
   return (int)inst_dev;
}

int alt_spi_bytestream_kill (byte_channel_handle alt_bytestream_handle)
{
    queue_clear(&((s_byte_channel*)alt_bytestream_handle)->spi_q, 1);
    
    free((s_byte_channel*)alt_bytestream_handle);
    return 0;
}

int alt_spi_bytestream_clear (byte_channel_handle alt_bytestream_handle)
{
    queue_clear(&((s_byte_channel*)alt_bytestream_handle)->spi_q, 1);

    return 0;
}

int alt_bytestream_tick(
    void* alt_bytestream_handle)
{
    s_byte_channel * inst_dev = alt_bytestream_handle;
    inst_dev->tick_count ++;
    return 0;
}


int alt_bytestream_send (
    void* alt_bytestream_handle, 
    alt_u8* txbuf, 
    int buffer_len,
    int timeout) 
{
    s_byte_channel * inst_dev = alt_bytestream_handle;

    int idle_in_desert_flag = inst_dev->use_idle ; //idle insertion flag AKA Kent, will be use to determine if idle detection and removal is needed this implementation
    alt_u8* idle_rx_char;

    int ret_val = 0;
    int i_cnt = 0;
    alt_u8* output_ptr;
    alt_u8* write_ptr = txbuf;
    alt_u8 temp_write_chr;
    
    alt_u8 esc_chr = BYTESESCCHAR;
        
    for(i_cnt = 0; i_cnt< buffer_len; i_cnt++)
    {
        // Reset Timeout Counter
        inst_dev->tick_count = 0;
    
        if (idle_in_desert_flag)
        {       
            if (((alt_u8)write_ptr[i_cnt] == BYTESESCCHAR) || ((alt_u8)write_ptr[i_cnt] == BYTESIDLECHAR))
            {
                idle_rx_char = malloc(sizeof(alt_u8)*2);
                
                ret_val +=  (*inst_dev->send_and_get_bytes)(&((alt_u8)esc_chr), &((alt_u8)idle_rx_char[0]), 1, inst_dev->device);
                queue_push(&inst_dev->spi_q, &((alt_u8)idle_rx_char[0]));
                
                temp_write_chr = xor_20((alt_u8)write_ptr[i_cnt]);
        
                ret_val +=  (*inst_dev->send_and_get_bytes)(&temp_write_chr, &((alt_u8)idle_rx_char[1]), 1, inst_dev->device);
                queue_push(&inst_dev->spi_q, &((alt_u8)idle_rx_char[1]));
         
            }
            else
            {
                output_ptr = (void *) malloc (sizeof(alt_u8));
                ret_val +=  (*inst_dev->send_and_get_bytes)(&((alt_u8)write_ptr[i_cnt]), output_ptr, 1, inst_dev->device);
                queue_push(&inst_dev->spi_q, output_ptr);
            }
        }
        else
        {
            output_ptr = (void *) malloc (sizeof(alt_u8));
            ret_val +=  (*inst_dev->send_and_get_bytes)(&((alt_u8)write_ptr[i_cnt]), output_ptr, 1, inst_dev->device);
            queue_push(&inst_dev->spi_q, output_ptr);
        }
        
//      Check timeout and break out of loop if it happens
        if ((timeout != -1) && (inst_dev->tick_count >= timeout))    
            break;
    }
    return ret_val;
}

int alt_bytestream_get (
    void* alt_bytestream_handle, 
    alt_u8* rxbuf,
    int* received_count_out,
    int buffer_len,
    int timeout) // set timeout=0 for non-blocking, -1 for wait forever.
{
    s_byte_channel * inst_dev = alt_bytestream_handle;
    int idle_in_desert_flag = inst_dev->use_idle ; //idle insertion
    
    alt_u8 idle_chr = BYTESIDLECHAR; 
    
    int ret_val = 0;
    int remainding_byte = buffer_len;
    alt_u8* read_bytes = rxbuf;
    
    alt_u8 xor_next_flag = 0; //determine if next character will be xor-ed by 20 when escape character is turned on

    
    while(remainding_byte)    
    {
        // Reset Timeout Counter
        inst_dev->tick_count = 0;
        if (queue_size(&inst_dev->spi_q))
        {
            read_bytes[0] = *(alt_u8*)queue_front(&inst_dev->spi_q);
            queue_pop(&inst_dev->spi_q, 1);

            ret_val ++;
        }
        else
        {
            if (idle_in_desert_flag)
            {
                ret_val +=  (*inst_dev->send_and_get_bytes)(&idle_chr, read_bytes, 1, inst_dev->device);
            }
            else
            {
                ret_val +=  (*inst_dev->send_and_get_bytes)(NULL, read_bytes, 1, inst_dev->device);
            }
            
        }


        if (idle_in_desert_flag)
        {       
            if (xor_next_flag == 1)
            {
                xor_next_flag = 0; //toggle flag so it won't x-ored the next reading
                *read_bytes = xor_20(*read_bytes);
            
            }
            else if (*read_bytes == BYTESIDLECHAR)   //the next character if x-ored cannot be special character thus it is put in the else if statement
            {
            // Skip this round reading but messing with pointers 
                read_bytes --;  // Rewrite current pointer in next round
                remainding_byte ++; //increase remaining bits by one effectively clearing current read
                
            }
            else if (*read_bytes == BYTESESCCHAR)
            {
            // Skip this round reading but messing with pointers 
                read_bytes --;  // Rewrite current pointer in next round
                remainding_byte ++; //increase remaining bits by one effectively clearing current read
                xor_next_flag = 1; //Toggle flag, so next reading will be xor-ed and be put in current position.
            }
            
        }             
        
        read_bytes ++;
        remainding_byte --;

//      Check timeout and break out of loop if it happens
        if ((timeout != -1) && (inst_dev->tick_count >= timeout))    
            break;
                
    }
    *received_count_out = ret_val;
    return ret_val;
    
}




unsigned char xor_20(unsigned char val)
{
    return val^0x20;
};
