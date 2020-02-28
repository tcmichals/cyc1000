import logging
import asyncio
import serial_asyncio
from enum import IntEnum

SOP = 0x7A
EOP = 0x7B
CHANNEL = 0x7C
ESC = 0x7D


"""
Table 421 
Transactions supported
"""


class AvalonBus(IntEnum):

    WRITE_NON_INCREMENTING = 0x00
    WRITE_INCREMENTING = 0x04
    READ_NON_INCREMENTING = 0x10
    READ_INCREMENTING = 0x14
    LOOP_BACK = 0x7F


HEADER_LEN = 8



def xor_20(val):
    """

    :param val:
    :return:
    """
    return val ^ 0x20


class Transport:

    def __init__(self, reader, writer):

        self.log = self.log = logging.getLogger(self.__class__.__name__)
        self.reader = reader
        self.writer = writer
        self.reader_task = None
        self.stopAllThreads = False
        self.rx_pktData = bytearray()
        self.rx_pktQueue = asyncio.Queue()

    def __del__(self):
        if self.reader_task:
            self.reader_task.cancel()

    def connection_lost(self):

        try:
            self.log.info("lost connection")

            if self.reader_task:
                self.reader_task.cancel()
        except Exception as ex:
            self.log.error("Error: %s", str(ex))

    def close(self):
        if self.reader_task:
            self.reader_task.cancel()

    async def rx_process(self):
        try:
            while self.stopAllThreads is False:
                msg = await self.reader.read(1024)
                logging.debug("packet " + bytes(msg).hex() + " len is " + str(len(msg)))
                if len(msg) is 0:
                    self.connection_lost()
                    break
                else:
                    rc, pkt = self.data_received(msg)
                    if rc:
                        await self.rx_pktQueue.put(pkt)
        except Exception as ex:
            logging.info("rx_process:" + str(ex))

    def data_received(self, data):
        self.rx_pktData.extend(data)
        if self.rx_pktData[0] == CHANNEL:
            if self.rx_pktData[len(self.rx_pktData) - 2] == EOP and self.rx_pktData[2] == SOP:
                pkt = self.rx_pktData[3:-2]
                pkt.append(self.rx_pktData[-1])
                self.rx_pktData = bytearray()
                return True, pkt
        return False

    def start_reader_task(self):
        loop = asyncio.get_event_loop()
        self.reader_task = loop.create_task(self.rx_process())

    def handle_data(self):
        pass

    def packet_channel_send_packet(self, data_buffer=bytearray(), channel_number=0):

        try:
            """
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
            """
            packet_to_send = bytearray()
            # TCM     packet_to_send.append(SOP)

            packet_to_send.append(CHANNEL)
            packet_to_send.append(channel_number)

            packet_to_send.append(SOP)
            logging.debug("packet len %d" % (len(packet_to_send)))

            for offset in range(len(data_buffer)):
                if offset == len(data_buffer)-1:
                    packet_to_send.append(EOP)
                current_byte = data_buffer[offset]

                if current_byte == SOP or current_byte == EOP or current_byte == CHANNEL or current_byte == ESC:
                    packet_to_send.append(ESC)
                    packet_to_send.append(xor_20(current_byte))
                else:
                    packet_to_send.append(current_byte)

            logging.debug("packet " + bytes(packet_to_send).hex() + " len is " + str(len(packet_to_send)))
            pkt = bytearray()
            pkt.append(packet_to_send[0])
            self.writer.write(packet_to_send)
            # self.writer.write(pkt)
            return True, ""
        except Exception as ex:
            logging.ERROR("packet_channel_send_packet:" + str(ex))
            return False, str(ex)

    def transaction_channel_write(self, addr,  channel_number=0, data_buffer=bytearray(), transaction=AvalonBus.LOOP_BACK, length=-1):
        return self.do_transaction(trans_type=transaction, address=addr, channel_number=channel_number, data=data_buffer, length=length)

    def transaction_channel_read(self, addr, channel_number=0, burst_length=4, transaction=AvalonBus.LOOP_BACK):
        return self.do_transaction(trans_type=transaction, address=addr, channel_number=channel_number,
                                   data=bytearray(), length=burst_length)

    def do_transaction(self, trans_type, address, channel_number=0, data=bytearray(), length=-1):
        """

        :param trans_type:
        :param address:
        :param channel_number:
        :param data:
        :param length:
        :return:
        """


        """
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
        """

        packet = bytearray()
        # 0
        packet.append(trans_type)
        # 1
        packet.append(0)

        if (length != -1) or (len(data) == 0):
            # 2
            packet.append(length >> 8 & 0xff)
            # 3
            packet.append(length & 0xff)
        else:
            # 2
            packet.append(len(data) >> 8 & 0xff)
            # 3
            packet.append(len(data) & 0xff)

        # 4
        packet.append((address >> 24) & 0xff)
        # 5
        packet.append((address >> 16) & 0xff)
        # 6
        packet.append((address >> 8) & 0xff)
        # 7
        packet.append(address & 0xff)

        if trans_type == AvalonBus.WRITE_NON_INCREMENTING or trans_type == AvalonBus.WRITE_INCREMENTING \
                or trans_type == 0x5 or trans_type == 0x08 or trans_type == 0x09 or trans_type == 0x0A:
            packet.extend(data)
            self.packet_channel_send_packet(packet, channel_number=channel_number)

        elif trans_type == AvalonBus.READ_INCREMENTING or trans_type == AvalonBus.READ_NON_INCREMENTING \
                or trans_type == 0x15 or trans_type == 0x18 or trans_type == 0x19 or trans_type == 0x1A:
            packet.extend(data)
            self.packet_channel_send_packet(packet, channel_number=channel_number)
        else:
            packet.extend(data)
            self.packet_channel_send_packet(packet, channel_number=channel_number)


# eof
