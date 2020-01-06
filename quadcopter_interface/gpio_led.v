// gpio_led.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module gpio_led (
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		output wire        led_signal_0,       // conduit_end.led_0
		output wire        led_signal_1,       //            .led_1
		output wire        led_signal_2,       //            .led_2
		output wire        led_signal_3,       //            .led_3
		output wire        led_signal_4,       //            .led_4
		output wire        led_signal_5,       //            .led_5
		output wire        led_signal_6,       //            .led_6
		output wire        led_signal_7,       //            .led_7
		input  wire [1:0]  avs_s1_address,     //   avs_slave.address
		input  wire        avs_s1_write,       //            .write
		input  wire [31:0] avs_s1_writedata,   //            .writedata
		output wire        avs_s1_waitrequest  //            .waitrequest
	);

	// TODO: Auto-generated HDL template

	assign avs_s1_waitrequest = 1'b0;
	
// TODO: Auto-generated HDL template

	assign avs_s1_waitrequest = 1'b0;
	
	reg[7:0] led_output;

	assign avs_s1_waitrequest = 1'b0;
	assign led_signal_0 = led_output[0];
	assign led_signal_1 = led_output[1];
	assign led_signal_2 = led_output[2];
	assign led_signal_3 = led_output[3];
	assign led_signal_4 = led_output[4];
	assign led_signal_5 = led_output[5];	
	assign led_signal_6 = led_output[6];	
	assign led_signal_7 = led_output[7];		

	initial begin
		led_output = 8'b00000000;
	end


	always @(posedge clock_clk or posedge reset_reset) begin
		if (reset_reset) begin
			led_output <= 0;
		end
		else begin
			if (avs_s1_write && avs_s1_address == 0) begin
				led_output <= avs_s1_writedata;
				`ifdef VERILATOR
					$display("LED:register(%x)", led_output );
				`endif
			end
			else if (avs_s1_write && avs_s1_address == 1) begin
				led_output <= led_output | avs_s1_writedata;
				`ifdef VERILATOR
					$display("LED:register(%x)", led_output );
				`endif
			end
			else if (avs_s1_write && avs_s1_address == 2) begin
				led_output <= led_output & ~avs_s1_writedata;
				`ifdef VERILATOR
					$display("LED:register(%x)", led_output );
				`endif
			end
		end
	end

endmodule
