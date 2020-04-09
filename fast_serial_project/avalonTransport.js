
/* return a new ArrayBuffer that has been appended 
 *  buffer1 is an ArrayBuffer
 *  buffer2 is an ArrayBuffer
 *  return a new ArrayBuffer that has buffer1 and buffer 2 appended
 */
function appendArray(buffer1, buffer2) {
    var tmp = new Uint8Array(buffer1.byteLength + buffer2.byteLength);
    tmp.set(new Uint8Array(buffer1), 0);
    tmp.set(new Uint8Array(buffer2), buffer1.byteLength);
    return tmp.buffer;
}



class AvalonBus
{


    constructor() 
    {
        this.SOP = 0x7A;
        this.EOP = 0x7B;
        this.CHANNEL = 0x7C;
        this.ESC = 0x7D;
        this.HEADER_LEN = 8

    }

    xor_20(val)
    {
       return val ^ 0x20
    }


    packet_channel_send_packet(data_buffer=Uint8Array(0), channel_number=0)
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
    
            let max_length = (data_buffer.length)?(data_buffer.length * 4):64;
            packet_to_send =  new Uint8Array(max_length);
            //packet_to_send.append(SOP)

            packet_to_send[0] = CHANNEL;
            packet_to_send[1] = channel_number;

            packet_to_send[2] = SOP;
            let index_packet_to_send = 3;
            let current_byte = 0;

            for( let offset = 0; offset < data_buffer.length; ++offset)
            {
                if (offset == data_buffer.length-1)
                    packet_to_send[index_packet_to_send++] = EOP
                current_byte = data_buffer[offset]
            

                if (current_byte == SOP || current_byte == EOP || current_byte == CHANNEL || current_byte == ESC)
                {
                    packet_to_send[index_packet_to_send++] = ESC
                    packet_to_send[index_packet_to_send++]=xor_20(current_byte);
                }
                else
                {
                    packet_to_send[index_packet_to_send++] = current_byte;
                }
            }


            self.writer.write(packet_to_send)
   
            return true
        }
        catch (err)
        {
            console.log("packet_channel_send_packet:" + err);
            return false;
        }
    }

 transaction_channel_write( addr,  
                            channel_number=0, 
                            data_buffer=Uint8Array(0), 
                            transaction=AvalonBus.LOOP_BACK)
    {
        return this.do_transaction(transaction, 
                               addr, 
                               channel_number, 
                               data_buffer);
                               
    }

 transaction_channel_read(addr, channel_number=0, length, transaction=AvalonBus.LOOP_BACK)
 {
    let data = Uint8Array(0);
    return this.do_transaction(transaction, 
                                addr, 
                                channel_number,
                                data);
                              
}

 do_transaction(trans_type, address, channel_number, data, length = -1)
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
    try
    {
        let index_packet_to_send = 0;
        let max_packet_len = (data.length)?data.length *4: 64;
        packet = new Uint8Array(max_length);
        //# 0
        packet[index_packet_to_send++] = trans_type;
        //# 1
        packet[index_packet_to_send++] = 0;

        if ((length != -1) || (data.length == 0))
        {
            // 2
            packet[index_packet_to_send++] = (length >> 8 & 0xff);
            // 3
            packet[index_packet_to_send++] = (length & 0xff);
        }
        else
        {
            // 2
            packet[index_packet_to_send++] = (data.length >> 8) & 0xff;
            // 3
            packet[index_packet_to_send++] = (data.length & 0xff);
        }

        //# 4
        packet[index_packet_to_send++] = ((address >> 24) & 0xff);
        //# 5
        packet[index_packet_to_send++] = (address >> 16) & 0xff;
        //# 6
        packet[index_packet_to_send++] = (address >> 8) & 0xff;
        //# 7
        packet[index_packet_to_send++] = address & 0xff;

        
        if (trans_type == AvalonBus.WRITE_NON_INCREMENTING || trans_type == AvalonBus.WRITE_INCREMENTING ||
            trans_type == 0x5 || trans_type == 0x08 || trans_type == 0x09 || trans_type == 0x0A)
        {
            packet.extend(data)
            self.packet_channel_send_packet(packet, channel_number=channel_number)
        }
        else if (trans_type == AvalonBus.READ_INCREMENTING || trans_type == AvalonBus.READ_NON_INCREMENTING ||
                trans_type == 0x15 || trans_type == 0x18 || trans_type == 0x19 || trans_type == 0x1A)
        {
            packet.extend(data)
            return self.packet_channel_send_packet(packet, channel_number=channel_number)
        }
        else
        {
            packet.extend(data);
            return self.packet_channel_send_packet(packet, channel_number=channel_number);
        }
    }
    catch(err)
    {
        return false;
    }
 }
}