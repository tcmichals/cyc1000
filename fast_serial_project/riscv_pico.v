// riscv_pico.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module riscv_pico #(
		parameter AUTO_INR_IRQ0_INTERRUPTS_USED = "-1"
	) (
		output wire [15:0] avm_m0_address,       //   avm_m0.address
		output wire        avm_m0_read,          //         .read
		input  wire        avm_m0_waitrequest,   //         .waitrequest
		input  wire [31:0] avm_m0_readdata,      //         .readdata
		input  wire        avm_m0_readdatavalid, //         .readdatavalid
		output wire        avm_m0_write,         //         .write
		output wire [31:0] avm_m0_writedata,     //         .writedata
		output wire        avm_m0_chipselect,    //         .chipselect
		input  wire        clock_clk,            //    clock.clk
		input  wire        reset_reset,          //    reset.reset
		input  wire [31:0] inr_irq0_irq          // inr_irq0.irq
	);

	// TODO: Auto-generated HDL template

	assign avm_m0_chipselect = 1'b0;

	assign avm_m0_address = 16'b0000000000000000;

	assign avm_m0_read = 1'b0;

	assign avm_m0_write = 1'b0;

	assign avm_m0_writedata = 32'b00000000000000000000000000000000;

endmodule