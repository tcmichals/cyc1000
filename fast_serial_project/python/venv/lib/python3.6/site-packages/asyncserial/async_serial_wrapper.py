#   :Filename:
#       async_serial_wrapper.py
#   :Authors:
#       Matthias Riegler <matthias@xvzf.tech>
#   :License:
#       Apache 2.0


import asyncio
import serial
from . import AbstractAsyncWrapper


class Serial(AbstractAsyncWrapper):
    """
    asyncserial is a simple wrapper for the pyserial library to provide async functionality.
    It is transparent to the pyserial interface and supports all parameters.
    You can e.g. create a connection by:

    >>> test = Serial(loop, "/dev/ttyUSB0", baudrate=115200)`

    :param loop: The main eventloop
    :param args: Arguments passed through to serial.Serial()
    :param kwargs: Keyword arguments passed through to serial.Serial()
    """

    def __init__(self, loop: asyncio.AbstractEventLoop, *args, **kwargs):
        """
        Initializes the async wrapper and Serial interface
        """
        self._serial_instance = serial.Serial(*args, **kwargs)
        self._asyncio_sleep_time = 0.0005

        super().__init__(loop)


    def _init(self):
        """
        Setups the serial connection for use with async (Setting both read and writetimeouts to 0)
        """
        # Set the serial instance to non blocking
        self._serial_instance.timeout = 0
        self._serial_instance.write_timeout = 0


    @property
    def is_open(self) -> bool:
        """
        True if the connection is open, false otherwise
        """
        return self._serial_instance.isOpen()


    @property
    def serial_instance(self) -> serial.Serial:
        """
        Serial instance
        """
        return self._serial_instance


    @property
    def out_waiting(self) -> int:
        """
        Number of not yet written bytes
        """
        return self._serial_instance.out_waiting


    @property
    def in_waiting(self) -> int:
        """
        Number of bytes available to be read
        """
        return self._serial_instance.in_waiting


    async def abort(self):
        """
        Closes the serial connection immediately, output queue will be discarded
        """
        self._serial_instance.close()


    async def _write(self, towrite: bytes):
        """
        Adds towrite to the write queue

        :param towrite: Write buffer
        """
        self._serial_instance.write(towrite)


    async def _read(self, num_bytes) -> bytes:
        """
        Reads a given number of bytes

        :param num_bytes: How many bytes to read
        :returns: incoming bytes
        """
        while True:

            if self.in_waiting < num_bytes:
                await asyncio.sleep(self._asyncio_sleep_time)

            else:
                # Try to read bytes
                inbytes = self._serial_instance.read(num_bytes)

                # Just for safety, should never happen
                if not inbytes:
                    await asyncio.sleep(self._asyncio_sleep_time)
                else:
                    return inbytes


    async def readline(self) -> bytes:
        """
        Reads one line

        >>> # Keeps waiting for a linefeed incase there is none in the buffer
        >>> await test.readline()

        :returns: bytes forming a line
        """
        while True:
            line = self._serial_instance.readline()
            if not line:
                await asyncio.sleep(self._asyncio_sleep_time)
            else:
                return line
