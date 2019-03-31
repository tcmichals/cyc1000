#include <cstdio>
#include <cstdlib>
#include <memory>

#include "Vrx_fastserial.h"
#include "verilated.h"
#include "verilated_vcd_c.h"



#define TRACE_FILE "rx_fastserial.vcd"


void	tick(int tickcount, std::unique_ptr<Vrx_fastserial> &tb, std::unique_ptr<VerilatedVcdC> &tfp) 
{
	tb->eval();
	if (tfp)
		tfp->dump(tickcount * 10 - 2);
	tb->i_clk = 1;
	tb->eval();
	if (tfp)
		tfp->dump(tickcount * 10);
	tb->i_clk = 0;
	tb->eval();
	if (tfp) {
		tfp->dump(tickcount * 10 + 5);
		tfp->flush();
	}
}


int main(int argc, char **argv)
{
    unsigned tickcount = 0;
    Verilated::commandArgs(argc, argv);

    std::unique_ptr<Vrx_fastserial> tb= std::make_unique<Vrx_fastserial>();

    	// Generate a trace
	Verilated::traceEverOn(true);
	std::unique_ptr<VerilatedVcdC> tfp = std::make_unique<VerilatedVcdC>(); 
	tb->trace(tfp.get(), 99);
	tfp->open(TRACE_FILE);

	for(int k=0; k<(1<<10); k++) 
		tick(++tickcount, tb, tfp);


    return 0;


}

//eof
