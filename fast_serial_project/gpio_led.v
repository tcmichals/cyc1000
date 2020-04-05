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
		input  wire [1:0]  avs_s0_address,     //      avs_s0.address
		input  wire        avs_s0_write,       //            .write
		input  wire [31:0] avs_s0_writedata,   //            .writedata
		output wire        avs_s0_waitrequest, //            .waitrequest
		input  wire        avs_s0_chipselect,  //            .chipselect
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		output wire [7:0]  LED                 // conduit_end.led
	);


assign avs_s0_waitrequest = 1'b0;
reg [7:0] led_reg;

initial begin
	led_reg = 0;  //just a test to validate the FPGA loaded
end

	always @(posedge clock_clk or negedge reset_reset) begin
		if (!reset_reset) begin
			led_reg <= 0;
		end
		else begin
			if (avs_s0_write && avs_s0_address == 0 && avs_s0_chipselect) begin
				led_reg <= avs_s0_writedata;
				`ifdef VERILATOR
					$display("LED:register(%x)", led_reg );
				`endif
			end
			else if (avs_s0_write && avs_s0_address == 1 && avs_s0_chipselect) begin
				led_reg <= led_reg | avs_s0_writedata;
				`ifdef VERILATOR
					$display("LED:register(%x)", led_reg );
				`endif
			end
			else if (avs_s0_write && avs_s0_address == 2 & avs_s0_chipselect) begin
				led_reg <= led_reg & ~avs_s0_writedata;
				`ifdef VERILATOR
					$display("LED:register(%x)", led_reg );
				`endif
			end
		end
	end


	
assign LED = led_reg;

endmodule
