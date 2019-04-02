#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <memory>

#include "Vtx_testbench.h"
#include "verilated.h"
#include "verilated_vcd_c.h"


#define TRACE_FILE "tx_testbench.vcd"
bool toogle_fsdi = false;
void toggle_fcts_if_read(int tickcount, 
					std::unique_ptr<Vtx_testbench> &tb, 
					std::unique_ptr<VerilatedVcdC> &tfp )
{
	if (tb->o_fsdi == 0 && 	tb->i_clk == 1 &&	tb->o_fsclk == 1 &&
			toogle_fsdi == false
		)
	{
		tb->i_fscts = 0;
		toogle_fsdi = true;
		std::cout << "tb->o_fsdi lowered.." << std::endl;
	}

}
void	tick(int tickcount, 
					std::unique_ptr<Vtx_testbench> &tb, 
					std::unique_ptr<VerilatedVcdC> &tfp) 
{
	toggle_fcts_if_read(tickcount, tb, tfp);
	tb->eval();
	if (tfp)
	{
		tfp->dump(tickcount * 10 - 2);
	}
	tb->i_clk = 1;
	toggle_fcts_if_read(tickcount, tb, tfp);
	tb->eval();

	if (tfp)
	{
		tfp->dump(tickcount * 10);
	}

	tb->i_clk = 0;
	toggle_fcts_if_read(tickcount, tb, tfp);
	tb->eval();

	if (tfp) 
	{
		tfp->dump(tickcount * 10 + 5);
		tfp->flush();
	}

}


int main(int argc, char **argv)
{
	unsigned tickcount = 0;
  Verilated::commandArgs(argc, argv);

  std::unique_ptr<Vtx_testbench> tb= std::make_unique<Vtx_testbench>();

    	// Generate a trace
	Verilated::traceEverOn(true);
	std::unique_ptr<VerilatedVcdC> tfp = std::make_unique<VerilatedVcdC>(); 
	tb->trace(tfp.get(), 99);
	tfp->open(TRACE_FILE);

	tb->i_fscts = 1;
	tb->eval();
	std::cout << " i_fscts: " << 	((int)tb->i_fscts) << std::endl;
	for(int k=0; k< 32; k++) 
	{
		tick(++tickcount, tb, tfp);
	}

  return 0;

}

//eof
