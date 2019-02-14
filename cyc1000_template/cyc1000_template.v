

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

	input [7:0]	PIO,
	
	//FTDI serial port Async RS232
	input BDBUS0,   	//TX
	output BDBUS1,  	//RX
	output BDBUS2,   //RTS
	input BDBUS3,    //CTS
	output BDBUS4,    //DTR
	input BDBUS5,    //DSR
	
	output [8:0] AIN,
	output MEM_CLK
);

wire nreset;
assign nreset = ~USER_BTN;


wire CLK100M;

//setup a PLL more of this later
PLL12M pllinst(.areset(nreset),
					.inclk0(CLK12M),
					.c0(MEM_CLK),
					.c1(CLK100M),
					.locked());
					 

wire div_1ms;
wire div_250ms;

simple_divider div1ms(.i_clk(CLK100M),
							.i_reset(nreset),
							.maxCount(100000),
							.o_clk(div_1ms));
							

simple_divider div250ms(.i_clk(div_1ms),
							.i_reset(nreset),
							.maxCount(250),
							.o_clk(div_250ms));


							
kit_sequencer kit(.i_clk(div_250ms),
						.i_reset(nreset),
						.o_led(LED));
						
/* mapping serial port pins to 
   BDBUS[0] to AIN[0]
*/

thruwire a0(.i_wire(BDBUS0), .o_wire(AIN[0]));

//Take TX and send it to RX
thruwire a0_tx(.i_wire(BDBUS0), .o_wire(BDBUS1));
thruwire a1(.i_wire(BDBUS0), .o_wire(AIN[1]));


thruwire a2(.i_wire(BDBUS2), .o_wire(AIN[2]));
thruwire a3(.i_wire(BDBUS3), .o_wire(AIN[3]));
thruwire a4(.i_wire(BDBUS4), .o_wire(AIN[4]));
thruwire a5(.i_wire(BDBUS5), .o_wire(AIN[5]));

endmodule