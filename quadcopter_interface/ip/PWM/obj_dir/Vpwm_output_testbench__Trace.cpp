// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vpwm_output_testbench__Syms.h"


//======================

void Vpwm_output_testbench::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vpwm_output_testbench* t=(Vpwm_output_testbench*)userthis;
    Vpwm_output_testbench__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void Vpwm_output_testbench::traceChgThis(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
	}
	vlTOPp->traceChgThis__3(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vpwm_output_testbench::traceChgThis__2(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+1,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__state),4);
	vcdp->chgBus(c+2,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time),32);
	vcdp->chgBus(c+3,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__tick_microsec),16);
	vcdp->chgBus(c+4,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low),16);
	vcdp->chgBus(c+5,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high),16);
	vcdp->chgBus(c+6,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_high),16);
	vcdp->chgBus(c+7,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_low),16);
	vcdp->chgBit(c+8,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm));
    }
}

void Vpwm_output_testbench::traceChgThis__3(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+9,(vlTOPp->i_clk));
	vcdp->chgBit(c+10,(vlTOPp->i_reset));
	vcdp->chgBit(c+11,(vlTOPp->i_write));
	vcdp->chgBit(c+12,(vlTOPp->o_pwm));
    }
}
