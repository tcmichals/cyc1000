/*

Simple BRAM controller

*/

`default_nettype	none

module bram_wb(	i_clk,
                i_rst,
		//These are wishbone bus
		i_wb_cyc, 
                i_wb_stb, 
                i_wb_we, 
                i_wb_addr, 
                i_wb_data,
	        o_wb_ack, 
                o_wb_stall, 
                o_wb_data
               );
	parameter BUSW = 32;
	parameter RAM_SIZE=256;
	input 	wire i_clk;
	input 	wire i_rst;

// The WISHBONE bus for reading and configuring this scope
	input	wire			i_wb_cyc, i_wb_stb, i_wb_we;
	input	wire	[15:0]		i_wb_addr; 
	input	wire	[(BUSW-1):0]	i_wb_data;
	output	reg 			o_wb_ack;
	output	reg 			o_wb_stall;
	output	reg [(BUSW-1):0]	o_wb_data;

//Locals
  	// Declare the Memory variable
  	reg [BUSW-1:0] r_Memory[DEPTH-1:0];
	wire busy;
	initial o_wb_ack = 1’b0;


	always @(posedge i_clk) begin
		if ( i_wb_stb && i_wb_we && !o_wb_stall) begin
		end

	end


	always @(posedge i_clk)
		o_wb_ack <= (i_wb_stb)&&(!o_wb_stall);


	assign	o_wb_stall = (busy)&&(i_wb_we);
	


endmodule
//eof

