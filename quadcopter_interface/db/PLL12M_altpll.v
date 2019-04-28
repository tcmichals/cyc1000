//altpll bandwidth_type="AUTO" CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" clk0_divide_by=12 clk0_duty_cycle=50 clk0_multiply_by=1 clk0_phase_shift="0" clk1_divide_by=3 clk1_duty_cycle=50 clk1_multiply_by=25 clk1_phase_shift="0" compensate_clock="CLK0" device_family="Cyclone 10 LP" inclk0_input_frequency=83333 intended_device_family="Cyclone 10 LP" lpm_hint="CBX_MODULE_PREFIX=PLL12M" operation_mode="normal" pll_type="AUTO" port_clk0="PORT_USED" port_clk1="PORT_USED" port_clk2="PORT_UNUSED" port_clk3="PORT_UNUSED" port_clk4="PORT_UNUSED" port_clk5="PORT_UNUSED" port_extclk0="PORT_UNUSED" port_extclk1="PORT_UNUSED" port_extclk2="PORT_UNUSED" port_extclk3="PORT_UNUSED" port_inclk1="PORT_UNUSED" port_phasecounterselect="PORT_UNUSED" port_phasedone="PORT_UNUSED" port_scandata="PORT_UNUSED" port_scandataout="PORT_UNUSED" width_clock=5 areset clk inclk CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48
//VERSION_BEGIN 18.1 cbx_altclkbuf 2019:04:11:16:03:27:SJ cbx_altiobuf_bidir 2019:04:11:16:03:27:SJ cbx_altiobuf_in 2019:04:11:16:03:27:SJ cbx_altiobuf_out 2019:04:11:16:03:27:SJ cbx_altpll 2019:04:11:16:03:28:SJ cbx_cycloneii 2019:04:11:16:03:28:SJ cbx_lpm_add_sub 2019:04:11:16:03:28:SJ cbx_lpm_compare 2019:04:11:16:03:28:SJ cbx_lpm_counter 2019:04:11:16:03:28:SJ cbx_lpm_decode 2019:04:11:16:03:28:SJ cbx_lpm_mux 2019:04:11:16:03:28:SJ cbx_mgl 2019:04:11:18:00:57:SJ cbx_nadder 2019:04:11:16:03:28:SJ cbx_stratix 2019:04:11:16:03:28:SJ cbx_stratixii 2019:04:11:16:03:28:SJ cbx_stratixiii 2019:04:11:16:03:28:SJ cbx_stratixv 2019:04:11:16:03:28:SJ cbx_util_mgl 2019:04:11:16:03:28:SJ  VERSION_END
//CBXI_INSTANCE_NAME="quadcopter_interface_PLL12M_PLL12M_inst_altpll_altpll_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2019  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.



//synthesis_resources = cyclone10lp_pll 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  PLL12M_altpll
	( 
	areset,
	clk,
	inclk) /* synthesis synthesis_clearbox=1 */;
	input   areset;
	output   [4:0]  clk;
	input   [1:0]  inclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   areset;
	tri0   [1:0]  inclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [4:0]   wire_pll1_clk;
	wire  wire_pll1_fbout;

	cyclone10lp_pll   pll1
	( 
	.activeclock(),
	.areset(areset),
	.clk(wire_pll1_clk),
	.clkbad(),
	.fbin(wire_pll1_fbout),
	.fbout(wire_pll1_fbout),
	.inclk(inclk),
	.locked(),
	.phasedone(),
	.scandataout(),
	.scandone(),
	.vcooverrange(),
	.vcounderrange()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clkswitch(1'b0),
	.configupdate(1'b0),
	.pfdena(1'b1),
	.phasecounterselect({3{1'b0}}),
	.phasestep(1'b0),
	.phaseupdown(1'b0),
	.scanclk(1'b0),
	.scanclkena(1'b1),
	.scandata(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		pll1.bandwidth_type = "auto",
		pll1.clk0_divide_by = 12,
		pll1.clk0_duty_cycle = 50,
		pll1.clk0_multiply_by = 1,
		pll1.clk0_phase_shift = "0",
		pll1.clk1_divide_by = 3,
		pll1.clk1_duty_cycle = 50,
		pll1.clk1_multiply_by = 25,
		pll1.clk1_phase_shift = "0",
		pll1.compensate_clock = "clk0",
		pll1.inclk0_input_frequency = 83333,
		pll1.operation_mode = "normal",
		pll1.pll_type = "auto",
		pll1.lpm_type = "cyclone10lp_pll";
	assign
		clk = {wire_pll1_clk[4:0]};
endmodule //PLL12M_altpll
//VALID FILE