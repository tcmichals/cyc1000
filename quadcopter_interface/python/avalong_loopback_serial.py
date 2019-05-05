import argparse
import logging
import asyncio
import serial_asyncio
import avalon


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
        data = bytearray()
        test.transaction_channel_write(0, data, transaction=avalon.AvalonBus.LOOP_BACK, length=0x5A)
        await asyncio.sleep(1)
        test.close()
        test = None
        return True, ""
    except Exception as local_ex:
        return False, str(local_ex)

def main(args):

    loop = asyncio.get_event_loop()
    loop.run_until_complete(start(args))
    loop.run_forever()
    loop.close()


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
