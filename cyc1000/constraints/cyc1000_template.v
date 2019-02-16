`default_nettype 	none


module cyc1000_template(
	input CLK12M,
	output [7:0] LED,
	input USER_BTN,
	
	/* accelerometer */
	input SEN_INT1,
	input SEN_INT2,
	input SEN_SDI,
	input SEN_SDO,
	input SEN_SPC,
	input SEN_CS,
	
	
	//input [7:0]	PIO,
	input [5:0]	BDBUS,
	
	input [8:0] AIN,
	
	output MEM_CLK
);

wire nreset;
assign nreset = USER_BTN;


wire CLK100M;

//setup a PLL more of this later
PLL12M pllinst(.areset(~nreset),
					.inclk0(CLK12M),
					.c0(MEM_CLK),
					.c1(CLK100M),
					.locked());
					 

reg div_1ms;
reg div_250ms;

simple_divider div_1ms( .i_clk(CLK100M),
								.i_reset(~nreset)
								.maxCount(100000),
								.o_clk(div_1ms));

simple_divider div_250ms( .i_clk(div_1ms)
								.i_reset(~nreset)
								.maxCount(250),
								.o_clk(div_1ms));
								

kit_sequencer kit(.i_clk(div_250ms),
						.i_reset(nreset),
						.o_led(LED));

`ifdef WORKING_CODE
`endif

endmodule