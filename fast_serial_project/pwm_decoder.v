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
		input  wire [7:0]  avs_s0_address,       //      avs_s0.address
		input  wire        avs_s0_read,          //            .read
		output wire [31:0] avs_s0_readdata,      //            .readdata
		output wire        avs_s0_readdatavalid, //            .readdatavalid
		output wire        avs_s0_waitrequest,   //            .waitrequest
		input  wire        clock_clk,            //       clock.clk
		input  wire        reset_reset,          //       reset.reset
		input  wire        pwm_1,                // pwm_signals.pwm_1
		input  wire        pwm_2,                //            .pwm_2
		input  wire        pwm_3,                //            .pwm_3
		input  wire        pwm_4,                //            .pwm_4
		input  wire        pwm_5,                //            .pwm_5
		input  wire        pwm_6                 //            .pwm_6
	);

	// TODO: Auto-generated HDL template

	assign avs_s0_readdata = 32'b00000000000000000000000000000000;

	assign avs_s0_waitrequest = 1'b0;

	assign avs_s0_readdatavalid = 1'b0;

endmodule
