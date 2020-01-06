`default_nettype 	none


module fast_serial_test(
	input CLK12M,
	output [7:0] LED,
	input USER_BTN,
	
	/* accelerometer */
	//FTDI serial port Async RS232
	output BDBUS0,   	//FSDI
	output BDBUS1,  	//RX
	input BDBUS2,   //FSDO 
	input BDBUS3,    //FSCTS
	output BDBUS4,    //DTR
	input BDBUS5,    //DSR
	
	output [8:0] AIN,
	output MEM_CLK
);

wire nreset;
wire CLK100M;
wire one_meg_clk;

PLL12M pllinst(.inclk0(CLK12M),
					.c0(MEM_CLK),
					.c1(CLK100M));

n2_divider #(2) fastserialCLK (.i_reset(),
										.i_clk(CLK100M),
										.o_clk(one_meg_clk));

					

assign AIN[0] = one_meg_clk;
assign AIN[1] = MEM_CLK;
assign AIN[2] = one_meg_clk;
assign AIN[3] = MEM_CLK;


assign LED[7] = 1;
assign LED[6] = 1;
assign LED[5] = 1;
assign LED[4] = 1;
assign LED[0] = MEM_CLK;

endmodule
