import argparse
import logging
import asyncio
import serial_asyncio
import avalon
import math

"""
FPGA Memory map
LED
0x00 - 0x03 = write the LED value
0x04 - 0x7  = OR of current LED
0x08 - 0xB  = AND of the current LED

0x40 - 0x43 FPGA ID 0x112233
0x44 - 0x47 Time stamp

"""

FPGA_ID_REG = 0x40
FPGA_ID_TIME_STAMP = 0x44


async def led_test(args):

    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'

        baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port,
                                                                                       baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()
        led_value = 0x01
        data = bytearray(4)
        for i in range(0, 0x100):
            data[0] = i
            logging.debug("length of data {}".format(len(data)))
            test.transaction_channel_write(0x0, channel_number=0, data_buffer=data, transaction=avalon.AvalonBus.WRITE_NON_INCREMENTING)

            pkt = await test.rx_pktQueue.get()
        test.close()
        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)


async def test_id(args):
    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'

        baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port,
                                                                                       baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()

        test.transaction_channel_read(0x10, channel_number=0, burst_length=4,
                                      transaction=avalon.AvalonBus.READ_NON_INCREMENTING)

        pkt = await test.rx_pktQueue.get()
        if len(pkt) is 4:
            print("Array length {} 0x{:04x}".format(len(pkt), int.from_bytes(pkt, byteorder='little')))
        else:
            print("Error")
        test.close()
        writer.close()

        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)


async def pwm_id(args):
    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'

        baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port,
                                                                                       baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()

        for i in range(0, 1000):
            test.transaction_channel_read(0x20, channel_number=0, burst_length=4*6,
                                      transaction=avalon.AvalonBus.READ_INCREMENTING)

            pkt = await test.rx_pktQueue.get()

            pwm_1 = int.from_bytes(pkt[0:4], byteorder='little', signed=False)
            pwm_2 = int.from_bytes(pkt[4:8], byteorder='little', signed=False)
            pwm_3 = int.from_bytes(pkt[8:12], byteorder='little', signed=False)
            pwm_4 = int.from_bytes(pkt[12:16], byteorder='little', signed=False)
            pwm_5 = int.from_bytes(pkt[16:20], byteorder='little', signed=False)
            pwm_6 = int.from_bytes(pkt[20:], byteorder='little', signed=False)

            print("pwm_1 0x{:08x}  0x{:08x}  0x{:08x} 0x{:08x} 0x{:08x} 0x{:08x}".
                  format(pwm_1, pwm_2, pwm_3, pwm_4, pwm_5, pwm_6), end='\r', flush=True)
            await asyncio.sleep(1)

        test.close()
        writer.close()

        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)

def main(args):

    loop = asyncio.get_event_loop()
    if args['test'] == 'pwm':
        loop.run_until_complete(pwm_id(args))

    loop.run_until_complete(test_id(args))
    loop.run_until_complete(led_test(args))
    loop.close()
    print("Done")


if __name__ == "__main__":

    """logging.basicConfig(
        format="%(asctime)-15s [%(levelname)s] %(funcName)s: %(message)s",
        level=logging.DEBUG)
    """

    # define the program description
    text = 'This is a test program. It demonstrates how to use the argparse module with a program description.'

    # initiate the parser with a description
    parser = argparse.ArgumentParser(description=text)
    parser.add_argument("-port", "--port", help="serial port")
    parser.add_argument("-test", "--test", help="pwm led id default=all")
    g_cmd_line_args_ = vars(parser.parse_args())

    try:
        main(g_cmd_line_args_)
        print("done")

    except Exception as ex:
        logging.error("main:" + str(ex))

# eof
