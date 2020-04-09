// led_gpio.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module led_gpio (
		input  wire [3:0]  avs_s0_address,     //  avs_s0.address
		input  wire        avs_s0_write,       //        .write
		input  wire [31:0] avs_s0_writedata,   //        .writedata
		output wire        avs_s0_waitrequest, //        .waitrequest
		input  wire        avs_s0_chipselect,  //        .chipselect
		input  wire        clock_clk,          //   clock.clk
		input  wire        reset_reset,        //   reset.reset
		output wire [7:0]  LED                 // conduit.led
	);

	assign avs_s0_waitrequest = 1'b0;
	assign LED = led_output;

	reg[7:0] led_output;

	initial begin
		led_output = 8'b00000000;
	end

	always @(posedge clock_clk ) begin

			if (avs_s0_write && avs_s0_address == 0 && avs_s0_chipselect) begin
				led_output <= {avs_s0_writedata[7:0]};
				`ifdef VERILATOR
					$display("LED:register(%x)", led_output );
				`endif
			end
			else if (avs_s0_write && avs_s0_address == 1 && avs_s0_chipselect) begin
				led_output <= led_output | {avs_s0_writedata[7:0]};
				`ifdef VERILATOR
					$display("LED:register(%x)", led_output );
				`endif
			end
			else if (avs_s0_write && avs_s0_address == 2 && avs_s0_chipselect) begin
				led_output <= led_output & ~{avs_s0_writedata[7:0]};
				`ifdef VERILATOR
					$display("LED:register(%x)", led_output );
				`endif
			end
	end

endmodule
