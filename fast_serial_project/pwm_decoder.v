// pwm_decoder.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module pwm_decoder (
		input  wire [2:0]  avs_s0_address,     //      avs_s0.address
		input  wire        avs_s0_read,        //            .read
		output wire [31:0] avs_s0_readdata,    //            .readdata
		output wire        avs_s0_waitrequest, //            .waitrequest
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		input  wire        pwm_1,              // conduit_end.pwm_1
		input  wire        pwm_2,              //            .pwm_2
		input  wire        pwm_3,              //            .pwm_3
		input  wire        pwm_4,              //            .pwm_4
		input  wire        pwm_5,              //            .pwm_5
		input  wire        pwm_6               //            .pwm_6
	);

	
	reg [31:0] read_data;
	wire [15:0]pwm_count_1;
	wire [15:0]pwm_count_2;
	wire [15:0]pwm_count_3;
	wire [15:0]pwm_count_4;
	wire [15:0]pwm_count_5;
	wire [15:0]pwm_count_6;	
	
	initial begin
		read_data = 32'd0;
	end
	
	assign avs_s0_readdata = read_data;
	assign avs_s0_waitrequest = 1'b0;
	
	pwm_decode p1 (.i_clk(clock_clk),
						.i_pwm(pwm_1),
						.i_reset(!reset_reset),
						.o_pwm_value(pwm_count_1));
	
	pwm_decode p2 (.i_clk(clock_clk),
						.i_pwm(pwm_2),
						.i_reset(!reset_reset),
						.o_pwm_value(pwm_count_2));	

	pwm_decode p3 (.i_clk(clock_clk),
						.i_pwm(pwm_3),
						.i_reset(!reset_reset),
						.o_pwm_value(pwm_count_3));	
	
	pwm_decode p4 (.i_clk(clock_clk),
						.i_pwm(pwm_4),
						.i_reset(!reset_reset),
						.o_pwm_value(pwm_count_4));	

	pwm_decode p5 (.i_clk(clock_clk),
						.i_pwm(pwm_5),
						.i_reset(!reset_reset),
						.o_pwm_value(pwm_count_5));
	
	pwm_decode p6 (.i_clk(clock_clk),
						.i_pwm(pwm_6),
						.i_reset(!reset_reset),
						.o_pwm_value(pwm_count_6));	
				
				
always @(*) begin
	case(avs_s0_address) 
		0:	read_data <=  {16'h0001,pwm_count_1};
		1: read_data <=  {16'h0002,pwm_count_2};
		2: read_data <=  {16'h0003,pwm_count_3};
		3: read_data <=  {16'h0004,pwm_count_4};
		4: read_data <=  {16'h0005,pwm_count_5};
		5: read_data <=  {16'h0006,pwm_count_6};		
		default: read_data <=  32'hFFFF_FFFF;
	endcase 
	
end	

endmodule

