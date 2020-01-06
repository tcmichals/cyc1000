#include <cstdio>
#include <cstdlib>
#include <memory>

#include "Vpwm_output_testbench.h"
#include "verilated.h"
#include "verilated_vcd_c.h"



#define TRACE_FILE "pwm_out_testbench.vcd"

std::size_t reset_time = 10;
std::size_t i_write = 20;
bool toggle = true;

void	tick( 	std::size_t &tickcount, 
		std::unique_ptr<Vpwm_output_testbench> &tb, 
		std::unique_ptr<VerilatedVcdC> &tfp) 
{
	if (reset_time !=0)
	{
		reset_time--;		
		tb->i_reset = 1;
	}
	else
	{
		tb->i_reset = 0;
		if (toggle && tb->i_write == 0)
		{
			tb->i_write = 1;
			toggle = false;
		}
		else
			tb->i_write = 0;

	}

	

	tb->eval();
	tickcount++;
	if (tfp)
		tfp->dump(tickcount);
	tb->i_clk = 1;
	tb->eval();
	tickcount+=1;
	if (tfp)
		tfp->dump(tickcount);
	tb->i_clk = 0;
	tb->eval();
	tickcount+=1;
	if (tfp) {
		tfp->dump(tickcount);
		tfp->flush();
	}
	
}


int main(int argc, char **argv)
{
    std::size_t tickcount = 0;
    Verilated::commandArgs(argc, argv);

    std::unique_ptr<Vpwm_output_testbench> tb= std::make_unique<Vpwm_output_testbench>();

    	// Generate a trace
	Verilated::traceEverOn(true);
	std::unique_ptr<VerilatedVcdC> tfp = std::make_unique<VerilatedVcdC>(); 
	tb->trace(tfp.get(), 100);
//TCM	tfp->open(TRACE_FILE);

	for(int k=0; k< 900000000; k++) 
		tick(++tickcount, tb, tfp);


    return 0;


}

//eof
