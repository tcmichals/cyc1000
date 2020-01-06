
testFPGA: testFPGA.cxx Makefile addressmap.h  apa102.h  avalonProtocol.h gpioled.h  loopback.h  pwmdecoder.h  serialTransport.h  sysid.h  timer.h  transport.h pwmOut.h addressmap.h
	@echo "$@" $@
	g++ -o $@ $@.cxx -pthread -lm -ggdb3
	#g++ -o $@ $@.cxx -pthread -lm -Ofast

clean:
	rm -f testFPGA	