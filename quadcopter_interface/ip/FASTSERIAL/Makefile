


.PHONY: all 
all: rx_testbench tx_testbench

VERILATOR=verilator
VERILATOR_ROOT ?= $(shell bash -c 'verilator -V|grep VERILATOR_ROOT | head -1 | sed -e "s/^.*=\s*//"')
VINC := $(VERILATOR_ROOT)/include

obj_dir/Vrx_testbench.cpp: rx_testbench.v
	$(VERILATOR) --trace -Wall -cc rx_testbench.v

obj_dir/Vrx_testbench__ALL.a: obj_dir/Vrx_testbench.cpp
	make --no-print-directory -C obj_dir -f Vrx_testbench.mk

rx_testbench: rx_testbench.cpp obj_dir/Vrx_testbench__ALL.a
	g++ -ggdb -I$(VINC) -I obj_dir $(VINC)/verilated.cpp		\
		$(VINC)/verilated_vcd_c.cpp rx_testbench.cpp	\
		obj_dir/Vrx_testbench__ALL.a -o rx_testbench


obj_dir/Vtx_testbench.cpp: tx_testbench.v tx_fastserial.v
	$(VERILATOR) --trace -Wall -cc tx_testbench.v

obj_dir/Vtx_testbench__ALL.a: obj_dir/Vtx_testbench.cpp
	make --no-print-directory -C obj_dir -f Vtx_testbench.mk

tx_testbench: tx_testbench.cpp  obj_dir/Vtx_testbench__ALL.a
	g++ -ggdb -I$(VINC) -I obj_dir $(VINC)/verilated.cpp		\
		$(VINC)/verilated_vcd_c.cpp tx_testbench.cpp	\
		obj_dir/Vtx_testbench__ALL.a -o tx_testbench		

.PHONY: clean
clean:
	rm -rf obj_dir/ rx_testbench/ rx_testbench rx_testbench.vcd

