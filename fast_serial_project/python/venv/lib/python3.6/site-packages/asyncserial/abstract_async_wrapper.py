#   :Filename:
#       abstract_async_wrapper.oy
#   :Authors:
#       Matthias Riegler <matthias@xvzf.tech>
#   :License:
#       Apache 2.0


import asyncio
from abc import ABC, abstractmethod


class AbstractAsyncWrapper(ABC):
    """
    Abstract wrapper for any Python connectivity library which supports non blocking calls,
    use this class as abstract Baseclass

    :param loop: The main eventloop
    """

    def __init__(self, loop: asyncio.AbstractEventLoop):
        """
        Initializes the async wrapper
        """
        self._loop = loop
        self._asyncio_sleep_time = 0.0005

        #Setup for async
        self._init()


    @abstractmethod
    def _init(self):
        """
        Initializes the object for non blocking calls
        """
        pass


    @property
    def loop(self) -> asyncio.AbstractEventLoop:
        """
        Eventloop
        """
        return self._loop


    @property
    @abstractmethod
    def is_open(self) -> bool:
        """
        True if the connection is open, false otherwise
        """
        pass


    @property
    @abstractmethod
    def out_waiting(self) -> int:
        """
        Number of not yet written bytes
        """
        pass


    @property
    @abstractmethod
    def in_waiting(self) -> int:
        """
        Number of bytes available to be read
        """
        pass


    async def flush(self):
        """
        Flushes output queue
        """
        while self.out_waiting > 0:
            await asyncio.sleep(self._asyncio_sleep_time)


    async def close(self):
        """
        Closes the serial connection gratefully, flushes output buffer
        """
        await self.flush()
        self.abort()


    @abstractmethod
    async def abort(self):
        """
        Kills the connection
        """
        pass


    @abstractmethod
    async def _write(self, towrite):
        """
        Writes a bytes

        :param towrite: Bytes that should be written
        """
        pass


    @abstractmethod
    async def _read(self, num_bytes) -> bytes:
        """
        :param num_bytes: How many bytes should be read
        :returns: Bytes read
        """
        pass


    async def write(self, towrite: bytes, await_blocking=False):
        """
        Appends towrite to the write queue

        >>> await test.write(b"HELLO")
        # Returns without wait time
        >>> await test.write(b"HELLO", await_blocking = True)
        # Returns when the bufer is flushed

        :param towrite:      Write buffer
        :param await_blocking:  wait for everything to be written
        """

        await self._write(towrite)

        # Wait for the output buffer to be flushed if requested
        if await_blocking:
            return await self.flush()


    async def read(self, num_bytes=0) -> bytes:
        """
        Reads a given number of bytes

        :param bytecount: How many bytes to read, leave it at default
                          to read everything that is available
        :returns: incoming bytes
        """
        if num_bytes < 1:
            num_bytes = self.in_waiting or 1

        return await self._read(num_bytes)
