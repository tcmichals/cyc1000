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

        reader, writer = await asyncio.wait_for(serial_asyncio.open_serial_connection(url=serial_port, baudrate=baud_rate), 1)
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


async def test_led(args, loop):
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
        """
        for z in range (0, 10):
            for x in range (0, 8):
                data = bytearray()

                led_value = (1 << x)
                x_bytes= led_value.to_bytes(4, byteorder='little')
                data.extend(x_bytes)

                test.transaction_channel_write(0, channel_number=0, data_buffer=data, transaction=avalon.AvalonBus.WRITE_NON_INCREMENTING)
                await asyncio.sleep(.01)
        """
        data = bytearray()
        test.transaction_channel_read(0x60, channel_number=0,  transaction=avalon.AvalonBus.READ_INCREMENTING)
        await asyncio.sleep(1)

        led_value = 0x00
        x_bytes = led_value.to_bytes(4, byteorder='little')
        data.extend(x_bytes)
        test.transaction_channel_write(0x050, channel_number=0, data_buffer=data,
                                       transaction=avalon.AvalonBus.WRITE_NON_INCREMENTING)

        led_index = 0
        for y in range(0, 10000):
            led_index += 1
            if led_index is 8:
                led_index = 0
            for x in range(0, 8):
                data = bytearray()
                if x == led_index:
                    led_value = 0xFF00FF00
                else:
                    led_value = 0xFF000000
                x_bytes = led_value.to_bytes(4, byteorder='little')
                data.extend(x_bytes)
                test.transaction_channel_write(0x0 + (x * 4), channel_number=0, data_buffer=data,
                                           transaction=avalon.AvalonBus.WRITE_NON_INCREMENTING)
                await asyncio.sleep(.1)

            data = bytearray()
            led_value = 0x00000000
            x_bytes = led_value.to_bytes(4, byteorder='little')
            data.extend(x_bytes)
            test.transaction_channel_write(0x0 + (8*4), channel_number=0, data_buffer=data, transaction=avalon.AvalonBus.WRITE_NON_INCREMENTING)
            await asyncio.sleep(.01)

        test.close()
        writer.abort()
        writer.close()


        test = None
        loop.stop()
        return True, ""
    except Exception as local_ex:
        loop.stop()
        return False, str(local_ex)


def main(args):

    loop = asyncio.get_event_loop()

    loop.run_until_complete(test_led(args, loop))

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
