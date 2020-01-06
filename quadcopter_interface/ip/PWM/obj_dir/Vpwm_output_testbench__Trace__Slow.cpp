// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vpwm_output_testbench__Syms.h"


//======================

void Vpwm_output_testbench::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vpwm_output_testbench::traceInit, &Vpwm_output_testbench::traceFull, &Vpwm_output_testbench::traceChg, this);
}
void Vpwm_output_testbench::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vpwm_output_testbench* t=(Vpwm_output_testbench*)userthis;
    Vpwm_output_testbench__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vpwm_output_testbench::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vpwm_output_testbench* t=(Vpwm_output_testbench*)userthis;
    Vpwm_output_testbench__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vpwm_output_testbench::traceInitThis(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vpwm_output_testbench::traceFullThis(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vpwm_output_testbench::traceInitThis__1(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit(c+9,"i_clk",-1);
	vcdp->declBit(c+10,"i_reset",-1);
	vcdp->declBit(c+11,"i_write",-1);
	vcdp->declBit(c+12,"o_pwm",-1);
	vcdp->declBit(c+9,"pwm_output_testbench i_clk",-1);
	vcdp->declBit(c+10,"pwm_output_testbench i_reset",-1);
	vcdp->declBit(c+11,"pwm_output_testbench i_write",-1);
	vcdp->declBit(c+12,"pwm_output_testbench o_pwm",-1);
	vcdp->declBus(c+13,"pwm_output_testbench low",-1,15,0);
	vcdp->declBus(c+14,"pwm_output_testbench high",-1,15,0);
	vcdp->declBus(c+15,"pwm_output_testbench motor_1 update_guardtime",-1,31,0);
	vcdp->declBus(c+16,"pwm_output_testbench motor_1 clockFrequency",-1,31,0);
	vcdp->declBit(c+9,"pwm_output_testbench motor_1 i_clk",-1);
	vcdp->declBit(c+10,"pwm_output_testbench motor_1 i_reset",-1);
	vcdp->declBus(c+13,"pwm_output_testbench motor_1 i_pwm_low_value",-1,15,0);
	vcdp->declBus(c+14,"pwm_output_testbench motor_1 i_pwm_high_value",-1,15,0);
	vcdp->declBit(c+11,"pwm_output_testbench motor_1 i_write",-1);
	vcdp->declBit(c+12,"pwm_output_testbench motor_1 o_pwm",-1);
	vcdp->declBus(c+17,"pwm_output_testbench motor_1 PWM_HIGH",-1,3,0);
	vcdp->declBus(c+18,"pwm_output_testbench motor_1 PWM_LOW",-1,3,0);
	vcdp->declBus(c+19,"pwm_output_testbench motor_1 GUARD_TIME",-1,3,0);
	vcdp->declBus(c+20,"pwm_output_testbench motor_1 max_time",-1,15,0);
	vcdp->declBus(c+1,"pwm_output_testbench motor_1 state",-1,3,0);
	vcdp->declBus(c+2,"pwm_output_testbench motor_1 guard_time",-1,31,0);
	vcdp->declBus(c+3,"pwm_output_testbench motor_1 tick_microsec",-1,15,0);
	vcdp->declBus(c+4,"pwm_output_testbench motor_1 pwm_set_low",-1,15,0);
	vcdp->declBus(c+5,"pwm_output_testbench motor_1 pwm_set_high",-1,15,0);
	vcdp->declBus(c+6,"pwm_output_testbench motor_1 pwm_high",-1,15,0);
	vcdp->declBus(c+7,"pwm_output_testbench motor_1 pwm_low",-1,15,0);
	vcdp->declBit(c+8,"pwm_output_testbench motor_1 pwm",-1);
    }
}

void Vpwm_output_testbench::traceFullThis__1(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBus(c+1,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__state),4);
	vcdp->fullBus(c+2,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time),32);
	vcdp->fullBus(c+3,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__tick_microsec),16);
	vcdp->fullBus(c+4,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low),16);
	vcdp->fullBus(c+5,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high),16);
	vcdp->fullBus(c+6,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_high),16);
	vcdp->fullBus(c+7,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_low),16);
	vcdp->fullBit(c+8,(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm));
	vcdp->fullBit(c+9,(vlTOPp->i_clk));
	vcdp->fullBit(c+10,(vlTOPp->i_reset));
	vcdp->fullBit(c+11,(vlTOPp->i_write));
	vcdp->fullBit(c+12,(vlTOPp->o_pwm));
	vcdp->fullBus(c+13,(0x1f4U),16);
	vcdp->fullBus(c+14,(0x7d0U),16);
	vcdp->fullBus(c+15,(0xf4240U),32);
	vcdp->fullBus(c+16,(0x2faf080U),32);
	vcdp->fullBus(c+17,(1U),4);
	vcdp->fullBus(c+18,(2U),4);
	vcdp->fullBus(c+19,(3U),4);
	vcdp->fullBus(c+20,(0x32U),16);
    }
}
