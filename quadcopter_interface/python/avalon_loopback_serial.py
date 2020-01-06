import argparse
import logging
import asyncio
import serial_asyncio
import avalon
import math


async def start(args):

    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'
        baud_rate = args["baud"]
        if baud_rate:
            baud_rate = int(baud_rate)
        else:
            baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port, baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()
        led_value = 0xFFFFFF | (0x1F << 24)
        data = bytearray()
        x_bytes = led_value.to_bytes(int(math.ceil(led_value.bit_length() / 8)), byteorder='little')
        data.extend(x_bytes)
        test.transaction_channel_write(0, data, transaction=avalon.AvalonBus.LOOP_BACK, length=0x5A)
        await asyncio.sleep(1)
        test.close()
        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)


def set_led( brightness=0x1f, blue=0xff, green=0xff, red=0xff):
    return ((brightness | 0xE0) << 24) | (blue << 16) | (green << 8) | red


async def test_ap102(args):
    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'
        baud_rate = args["baud"]
        if baud_rate:
            baud_rate = int(baud_rate)
        else:
            baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port, baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()
        data = bytearray()
        blue = 0xff
        green = 0xff
        red = 0xff

        high_range = 1
        for index in range(0, high_range):

            for x in range(0, 8):
                led_value = set_led(0xF, blue=blue, green=green, red=red)
                x_bytes = led_value.to_bytes(4, byteorder='little')
                data.extend(x_bytes)

            test.transaction_channel_write(index,  channel_number=0,data_buffer=data, transaction=avalon.AvalonBus.WRITE_INCREMENTING)
            logging.debug("index: " + str(index) + " " + str(index/4-1))
            await asyncio.sleep(.1)

            data = bytearray()
            led_enable = 1
            x_bytes = led_enable.to_bytes(4, byteorder='little')
            data.extend(x_bytes)

            test.transaction_channel_write(0, channel_number=0, data_buffer=data, transaction=avalon.AvalonBus.WRITE_NON_INCREMENTING)
            await asyncio.sleep(.250)

            if index % 2:
                blue = 0
                green = 0
                red = 0xff
            else:
                blue = 0xff
                green = 0xff
                red = 0xff

        test.close()
        writer.close()

        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)


async def test_id(args):
    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'
        baud_rate = args["baud"]
        if baud_rate:
            baud_rate = int(baud_rate)
        else:
            baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port, baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()

        test.transaction_channel_read(0x60,  channel_number=0,burst_length=4,
                                      transaction=avalon.AvalonBus.READ_NON_INCREMENTING)

        await asyncio.sleep(1)
        test.close()
        writer.close()

        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)




async def test_pwm(args):
    try:
        serial_port = args["port"]
        if serial_port is None:
            serial_port = '/dev/ttyUSB0'
        baud_rate = args["baud"]
        if baud_rate:
            baud_rate = int(baud_rate)
        else:
            baud_rate = 115200

        reader, writer = await asyncio.wait_for( serial_asyncio.open_serial_connection(url=serial_port, baudrate=baud_rate), 1)
        test = avalon.Transport(reader=reader, writer=writer)
        test.start_reader_task()
        for x in range (1, 10000):
            await asyncio.sleep(.250)
        test.close()
        writer.close()

        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)
def main(args):

    loop = asyncio.get_event_loop()
    # loop.run_until_complete(start(args))

    #loop.run_until_complete(test_ap102(args))
    loop.run_until_complete(test_id(args))
    #loop.run_until_complete(test_pwm(args))
    loop.run_forever()
    loop.close()
    print("Done")


if __name__ == "__main__":

    logging.basicConfig(
        format="%(asctime)-15s [%(levelname)s] %(funcName)s: %(message)s",
        level=logging.DEBUG)

    # define the program description
    text = 'This is a test program. It demonstrates how to use the argparse module with a program description.'

    # initiate the parser with a description
    parser = argparse.ArgumentParser(description=text)

    # parser.add_argument("--h", "--help", help="produce help message -- Use <ESC> or <CTRL-C> to quit")

    parser.add_argument("-addr", "--addr", help="ip address of server")
    parser.add_argument("-appName", "--appName", help="name of URI application")
    parser.add_argument("-port", "--port", help="serial port")
    parser.add_argument("-baud", "--baud", help="buadrate")

    g_cmd_line_args_ = vars(parser.parse_args())

    try:
        main(g_cmd_line_args_)
        print("done")

    except Exception as ex:
        logging.error("main:" + str(ex))

# eof
