
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

function appendArrays( first, size, second)
{
    var tmp = new Uint8Array(size + second.byteLength);
    for(let index=0; index < size; ++index)
        tmp[index] = first[index];
    tmp.set( second, size);
    return tmp;

}

function truncArray(buffer, size)
{
    let tmp = new Uint8Array(size);
    for (let index = 0; index < size; ++index) 
    {
        tmp[index] = buffer[index];
        
    }

    return tmp;

}

function dumpArray(array)
{
    let str =""
    for( let index =0; index < array.byteLength; index++)
    {
        str += array[index].toString(16) + ' ';
    }
    console.log("dumpArray:" + str);

}

WRITE_NON_INCREMENTING = 0x00;
WRITE_INCREMENTING = 0x04;
READ_NON_INCREMENTING = 0x10;
READ_INCREMENTING = 0x14;
LOOP_BACK = 0x7F;
SOP = 0x7A;
EOP = 0x7B;
CHANNEL = 0x7C;
ESC = 0x7D;
HEADER_LEN = 8

class AvalonBus
{
    constructor() 
    {

        this.writer = null;
        this.rxMsgArrayBuffer = new ArrayBuffer();
        this.size_Of_request = 0;
        this.postCallback = null;

   }

   setWriter(writer)
   {
       this.writer = writer;;
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
            let packet_to_send =  new Uint8Array(max_length);
            let index_packet_to_send = 0;
            //packet_to_send.append(SOP)

            packet_to_send[index_packet_to_send++] = CHANNEL;
            packet_to_send[index_packet_to_send++] = channel_number;

            packet_to_send[index_packet_to_send++] = SOP;
            
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

            packet_to_send = truncArray(packet_to_send, index_packet_to_send);
            this.writer.Write(packet_to_send.buffer);
   
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

 transaction_channel_read(addr, channel_number, length, transaction=LOOP_BACK)
 {
    let data = new Uint8Array(0);
    return this.do_transaction(transaction, 
                                addr, 
                                channel_number,
                                data, length);
                              
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
        let packet = new Uint8Array(max_packet_len);
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

            this.size_Of_request = length;
        }
        else
        {
            // 2
            packet[index_packet_to_send++] = (data.length >> 8) & 0xff;
            // 3
            packet[index_packet_to_send++] = (data.length & 0xff);

            this.size_Of_request = data.length;
        }

        //# 4
        packet[index_packet_to_send++] = ((address >> 24) & 0xff);
        //# 5
        packet[index_packet_to_send++] = (address >> 16) & 0xff;
        //# 6
        packet[index_packet_to_send++] = (address >> 8) & 0xff;
        //# 7
        packet[index_packet_to_send++] = address & 0xff;

        
        if (trans_type == WRITE_NON_INCREMENTING || trans_type == WRITE_INCREMENTING ||
            trans_type == 0x5 || trans_type == 0x08 || trans_type == 0x09 || trans_type == 0x0A)
        {
             packet = appendArrays(packet,index_packet_to_send,data);
            this.packet_channel_send_packet(packet, channel_number)
        }
        else if (trans_type == READ_INCREMENTING || trans_type == READ_NON_INCREMENTING ||
                trans_type == 0x15 || trans_type == 0x18 || trans_type == 0x19 || trans_type == 0x1A)
        {
            packet = appendArrays(packet,index_packet_to_send,data);
            return this.packet_channel_send_packet(packet, channel_number)
        }
        else
        {
            packet = appendArrays(packet,index_packet_to_send,data);
            return this.packet_channel_send_packet(packet, channel_number);
        }
    }
    catch(err)
    {
        return false;
    }
 }

 /*

transaction_channel.c
 must have the size parameter to properly decode packet.. 

 */
onReceive( packet)
{
    let packet_view = new Uint8Array(packet);
    this.rxMsgArrayBuffer = appendArray(this.rxMsgArrayBuffer, packet_view);
    let view = new Uint8Array(this.rxMsgArrayBuffer);

    if (this.size_Of_request)
    {
        let data = new Uint8Array(this.size_Of_request);
        let offset = 0;
        for(let index = 0; index < view.byteLength; ++index)
        {
            switch(view[index])
            {
                case ESC:
                    data[offset++] = this.xor_20(view[index]);
                break;

                case SOP:
                    offset = 0;
                break;

                case EOP:
                break;

                default:
                    data[offset++] = view[index];
                break;
            }
        }

        if (this.size_Of_request == offset)
        {
            //dumpArray(data);
            if (this.postCallback)
                this.postCallback(data);
            this.rxMsgArrayBuffer = new ArrayBuffer();

        }
            
    }
}


SetCallback(callback)
{
    this.postCallback = callback;
}


}
