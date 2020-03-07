
testFPGA: testFPGA.cxx Makefile addressmap.h  apa102.h  avalonProtocol.h gpioled.h  loopback.h  pwmdecoder.h  serialTransport.h  sysid.h  timer.h  transport.h pwmOut.h addressmap.h
	@echo "$@" $@
	#g++ -o $@ $@.cxx -pthread -lm -Ofast -lftdi1
	g++ -o $@ $@.cxx -pthread -lm -ggdb3 -lftdi1

clean:
	rm -f testFPGA	