// picorv32_avalon.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`default_nettype none
`timescale 1 ns / 1 ns

module picorv32_avalon (
		output wire [31:0] avm_m0_address,       //   avm_m0.address
		output wire        avm_m0_read,          //         .read
		input  wire        avm_m0_waitrequest,   //         .waitrequest
		input  wire [31:0] avm_m0_readdata,      //         .readdata
		input  wire        avm_m0_readdatavalid, //         .readdatavalid
		output wire        avm_m0_write,         //         .write
		output wire [31:0] avm_m0_writedata,     //         .writedata
		output wire [3:0]  avm_m0_byteenable,    //         .byteenable
		input  wire        clock_clk,            //    clock.clk
		input  wire        reset_reset,          //    reset.reset
		input  wire [31:0] inr_irq0_irq          // inr_irq0.irq
	);


	
/***************************************************************
 * picorv32_avalon
 ***************************************************************/


localparam ENABLE_COUNTERS = 1;
localparam ENABLE_COUNTERS64 = 1;
localparam ENABLE_REGS_16_31 = 1;
localparam ENABLE_REGS_DUALPORT = 1;
localparam TWO_STAGE_SHIFT = 1;
localparam BARREL_SHIFTER = 0;
localparam TWO_CYCLE_COMPARE = 0;
localparam TWO_CYCLE_ALU = 0;
localparam COMPRESSED_ISA = 0;
localparam CATCH_MISALIGN = 1;
localparam CATCH_ILLINSN = 1;
localparam ENABLE_PCPI = 0;
localparam ENABLE_MUL = 0;
localparam ENABLE_FAST_MUL = 0;
localparam ENABLE_DIV = 0;
localparam ENABLE_IRQ = 0;
localparam ENABLE_IRQ_QREGS = 1;
localparam ENABLE_IRQ_TIMER = 1;
localparam ENABLE_TRACE = 0;
localparam REGS_INIT_ZERO = 0;
localparam MASKED_IRQ = 32'h0000_0000;
localparam LATCHED_IRQ = 32'hffff_ffff;
localparam PROGADDR_RESET = 32'h 0000_0000;
localparam PROGADDR_IRQ = 32'h 0000_0010;
localparam STACKADDR = 32'hffff_ffff;

wire trap;

wire mem_instr;
// Pico Co-Processor Interface (PCPI)
`ifdef RISCV_FORMAL
wire        pcpi_valid;
wire [31:0] pcpi_insn;
wire [31:0] pcpi_rs1;
wire [31:0] pcpi_rs2;
wire         pcpi_wr;
wire  [31:0] pcpi_rd;
wire         pcpi_wait;
wire         pcpi_ready;

wire [31:0] eoi;


wire clk;
wire resetn;

assign clk = clock_clk;
assign resetn = ~reset_reset;

picorv32 #(
		.ENABLE_COUNTERS     (ENABLE_COUNTERS     ),
		.ENABLE_COUNTERS64   (ENABLE_COUNTERS64   ),
		.ENABLE_REGS_16_31   (ENABLE_REGS_16_31   ),
		.ENABLE_REGS_DUALPORT(ENABLE_REGS_DUALPORT),
		.TWO_STAGE_SHIFT     (TWO_STAGE_SHIFT     ),
		.BARREL_SHIFTER      (BARREL_SHIFTER      ),
		.TWO_CYCLE_COMPARE   (TWO_CYCLE_COMPARE   ),
		.TWO_CYCLE_ALU       (TWO_CYCLE_ALU       ),
		.COMPRESSED_ISA      (COMPRESSED_ISA      ),
		.CATCH_MISALIGN      (CATCH_MISALIGN      ),
		.CATCH_ILLINSN       (CATCH_ILLINSN       ),
		.ENABLE_PCPI         (ENABLE_PCPI         ),
		.ENABLE_MUL          (ENABLE_MUL          ),
		.ENABLE_FAST_MUL     (ENABLE_FAST_MUL     ),
		.ENABLE_DIV          (ENABLE_DIV          ),
		.ENABLE_IRQ          (ENABLE_IRQ          ),
		.ENABLE_IRQ_QREGS    (ENABLE_IRQ_QREGS    ),
		.ENABLE_IRQ_TIMER    (ENABLE_IRQ_TIMER    ),
		.ENABLE_TRACE        (ENABLE_TRACE        ),
		.REGS_INIT_ZERO      (REGS_INIT_ZERO      ),
		.MASKED_IRQ          (MASKED_IRQ          ),
		.LATCHED_IRQ         (LATCHED_IRQ         ),
		.PROGADDR_RESET      (PROGADDR_RESET      ),
		.PROGADDR_IRQ        (PROGADDR_IRQ        ),
		.STACKADDR           (STACKADDR           )
	) picorv32_core (
		.clk      (clk   ),
		.resetn   (resetn),
		.trap     (trap  ),

		.mem_valid(avm_m0_write),
		.mem_addr (avm_m0_address ),
		.mem_wdata(avm_m0_writedata),
		.mem_wstrb(avm_m0_byteenable),
		.mem_instr(mem_instr),
		.mem_ready(avm_m0_readdatavalid),
		.mem_rdata(avm_m0_readdata),

		.irq(inr_irq0_irq),
		.eoi(eoi),

`ifdef RISCV_FORMAL
		.rvfi_valid    (rvfi_valid    ),
		.rvfi_order    (rvfi_order    ),
		.rvfi_insn     (rvfi_insn     ),
		.rvfi_trap     (rvfi_trap     ),
		.rvfi_halt     (rvfi_halt     ),
		.rvfi_intr     (rvfi_intr     ),
		.rvfi_rs1_addr (rvfi_rs1_addr ),
		.rvfi_rs2_addr (rvfi_rs2_addr ),
		.rvfi_rs1_rdata(rvfi_rs1_rdata),
		.rvfi_rs2_rdata(rvfi_rs2_rdata),
		.rvfi_rd_addr  (rvfi_rd_addr  ),
		.rvfi_rd_wdata (rvfi_rd_wdata ),
		.rvfi_pc_rdata (rvfi_pc_rdata ),
		.rvfi_pc_wdata (rvfi_pc_wdata ),
		.rvfi_mem_addr (rvfi_mem_addr ),
		.rvfi_mem_rmask(rvfi_mem_rmask),
		.rvfi_mem_wmask(rvfi_mem_wmask),
		.rvfi_mem_rdata(rvfi_mem_rdata),
		.rvfi_mem_wdata(rvfi_mem_wdata),
`endif

		.trace_valid(trace_valid),
		.trace_data (trace_data)
	);

`endif
	
endmodule
