
.PHONY: all 
all: pwm_output_testbench

VERILATOR=verilator
VERILATOR_ROOT ?= $(shell bash -c 'verilator -V|grep VERILATOR_ROOT | head -1 | sed -e "s/^.*=\s*//"')
VINC := $(VERILATOR_ROOT)/include

obj_dir/Vpwm_output_testbench.cpp: pwm_output_testbench.v
	$(VERILATOR) --trace -Wall -cc pwm_output_testbench.v

obj_dir/Vpwm_output_testbench__ALL.a: obj_dir/Vpwm_output_testbench.cpp
	make --no-print-directory -C obj_dir -f Vpwm_output_testbench.mk

pwm_output_testbench: pwm_output_testbench.cpp obj_dir/Vpwm_output_testbench__ALL.a
	g++ -ggdb -I$(VINC) -I obj_dir $(VINC)/verilated.cpp		\
		$(VINC)/verilated_vcd_c.cpp pwm_output_testbench.cpp	\
		obj_dir/Vpwm_output_testbench__ALL.a -o pwm_output_testbench


	

.PHONY: clean
clean:
	rm -rf obj_dir/ pwm_output_testbench/ pwm_output_testbench *.vcd
