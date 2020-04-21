// dshot_150.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module dshot_150 (
		input  wire [1:0]  avs_s0_address,     //      avs_s0.address
		input  wire        avs_s0_write,       //            .write
		input  wire [31:0] avs_s0_writedata,   //            .writedata
		output wire        avs_s0_waitrequest, //            .waitrequest
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		output wire        motor_1,            // conduit_end.motor_1
		output wire        motor_2,            //            .motor_2
		output wire        motor_3,            //            .motor_3
		output wire        motor_4             //            .motor_4
	);

	// TODO: Auto-generated HDL template
	assign avs_s0_waitrequest = 1'b0;

wire [15:0] dshot_value_motor_1;
wire [15:0] dshot_value_motor_2;
wire [15:0] dshot_value_motor_3;
wire [15:0] dshot_value_motor_4;

wire dshot_ready_1;
wire dshot_ready_2;
wire dshot_ready_3;
wire dshot_ready_4;



dhot_output dshot_motor_1(.i_clk(clock_clk),
			.i_reset(reset_reset),
			.i_dshot_value(dshot_value_motor_1),
			.i_write(dshot_ready_1),
			.o_pwm(motor_1));

dhot_output dshot_motor_2(.i_clk(clock_clk),
			.i_reset(reset_reset),
			.i_dshot_value(dshot_value_motor_2),
			.i_write(dshot_ready_2),
			.o_pwm(motor_2));

dhot_output dshot_motor_3(.i_clk(clock_clk),
			.i_reset(reset_reset),
			.i_dshot_value(dshot_value_motor_3),
			.i_write(dshot_ready_3),
			.o_pwm(motor_3));

dhot_output dshot_motor_4(.i_clk(clock_clk),
			.i_reset(reset_reset),
			.i_dshot_value(dshot_value_motor_4),
			.i_write(dshot_ready_4),
			.o_pwm(motor_4));


assign dshot_ready_1 = (avs_s0_write && (avs_s0_address == 2'b00))? 1'b1: 1'b0;
assign dshot_ready_2 = (avs_s0_write && (avs_s0_address == 2'b01))? 1'b1: 1'b0;
assign dshot_ready_3 = (avs_s0_write && (avs_s0_address == 2'b10))? 1'b1: 1'b0;
assign dshot_ready_4 = (avs_s0_write && (avs_s0_address == 2'b11))? 1'b1: 1'b0;

assign dshot_value_motor_1 = (avs_s0_write && (avs_s0_address == 2'b00))?avs_s0_writedata[15:0]:16'h0;
assign dshot_value_motor_2 = (avs_s0_write && (avs_s0_address == 2'b01))?avs_s0_writedata[15:0]:16'h0;
assign dshot_value_motor_3 = (avs_s0_write && (avs_s0_address == 2'b10))?avs_s0_writedata[15:0]:16'h0;
assign dshot_value_motor_4 = (avs_s0_write && (avs_s0_address == 2'b11))?avs_s0_writedata[15:0]:16'h0;



endmodule
