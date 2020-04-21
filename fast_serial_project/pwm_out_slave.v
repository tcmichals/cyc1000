// pwm_out_slave.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module pwm_out_slave (
		input  wire [1:0]  avs_s0_address,     //      avs_s0.address
		input  wire        avs_s0_write,       //            .write
		input  wire [31:0] avs_s0_writedata,   //            .writedata
		output wire        avs_s0_waitrequest, //            .waitrequest
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		output wire        pwm_out_1,          // conduit_end.pwm_out_1
		output wire        pwm_out_2,          //            .pwm_out_2
		output wire        pwm_out_3,          //            .pwm_out_3
		output wire        pwm_out_4           //            .pwm_out_4
	);

	// TODO: Auto-generated HDL template

	assign avs_s0_waitrequest = 1'b0;

	// TODO: Auto-generated HDL template

	assign avs_s0_waitrequest = 1'b0;

wire [15:0] pwm_value_low_1;
wire [15:0] pwm_value_high_1;

wire [15:0] pwm_value_low_2;
wire [15:0] pwm_value_high_2;

wire [15:0] pwm_value_low_3;
wire [15:0] pwm_value_high_3;

wire [15:0] pwm_value_low_4;
wire [15:0] pwm_value_high_4;

wire pwm_ready_1;
wire pwm_ready_2;
wire pwm_ready_3;
wire pwm_ready_4;


pwm_output pwm_1(.i_clk(clock_clk),
		.i_reset(reset_reset),
		.i_pwm_low_value(pwm_value_low_1),
		.i_pwm_high_value(pwm_value_high_1),
		.i_write(pwm_ready_1),
		.o_pwm(pwm_out_1));


pwm_output pwm_2(.i_clk(clock_clk),
		.i_reset(reset_reset),
		.i_pwm_low_value(pwm_value_low_2),
		.i_pwm_high_value(pwm_value_high_2),
		.i_write(pwm_ready_2),
		.o_pwm(pwm_out_2));

pwm_output pwm_3(.i_clk(clock_clk),
		.i_reset(reset_reset),
		.i_pwm_low_value(pwm_value_low_3),
		.i_pwm_high_value(pwm_value_high_3),
		.i_write(pwm_ready_3),
		.o_pwm(pwm_out_3));

pwm_output pwm_4(.i_clk(clock_clk),
		.i_reset(reset_reset),
		.i_pwm_low_value(pwm_value_low_4),
		.i_pwm_high_value(pwm_value_high_4),
		.i_write(pwm_ready_4),
		.o_pwm(pwm_out_4));
		
assign pwm_ready_1 = (avs_s0_write && (avs_s0_address == 2'b00))? 1'b1: 1'b0;
assign pwm_ready_2 = (avs_s0_write && (avs_s0_address == 2'b01))? 1'b1: 1'b0;
assign pwm_ready_3 = (avs_s0_write && (avs_s0_address == 2'b10))? 1'b1: 1'b0;
assign pwm_ready_4 = (avs_s0_write && (avs_s0_address == 2'b11))? 1'b1: 1'b0;

assign pwm_value_low_1 =  (avs_s0_write && (avs_s0_address == 2'b00))?avs_s0_writedata[15:0]:16'h0;
assign pwm_value_high_1 = (avs_s0_write && (avs_s0_address == 2'b00))?avs_s0_writedata[31:16]:16'h0;

assign pwm_value_low_2 =  (avs_s0_write && (avs_s0_address == 2'b01))?avs_s0_writedata[15:0]:16'h0;
assign pwm_value_high_2 = (avs_s0_write && (avs_s0_address == 2'b01))?avs_s0_writedata[31:16]:16'h0;

assign pwm_value_low_3 =  (avs_s0_write && (avs_s0_address == 2'b10))?avs_s0_writedata[15:0]:16'h0;
assign pwm_value_high_3 = (avs_s0_write && (avs_s0_address == 2'b10))?avs_s0_writedata[31:16]:16'h0;

assign pwm_value_low_4 =  (avs_s0_write && (avs_s0_address == 2'b11))?avs_s0_writedata[15:0]:16'h0;
assign pwm_value_high_4 = (avs_s0_write && (avs_s0_address == 2'b11))?avs_s0_writedata[31:16]:16'h0;		


endmodule
