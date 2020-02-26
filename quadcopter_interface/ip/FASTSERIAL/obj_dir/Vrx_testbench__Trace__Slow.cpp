// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vrx_testbench__Syms.h"


//======================

void Vrx_testbench::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vrx_testbench::traceInit, &Vrx_testbench::traceFull, &Vrx_testbench::traceChg, this);
}
void Vrx_testbench::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vrx_testbench* t=(Vrx_testbench*)userthis;
    Vrx_testbench__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vrx_testbench::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vrx_testbench* t=(Vrx_testbench*)userthis;
    Vrx_testbench__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vrx_testbench::traceInitThis(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vrx_testbench::traceFullThis(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vrx_testbench::traceInitThis__1(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit(c+7,"i_clk",-1);
	vcdp->declBit(c+8,"i_fsdo",-1);
	vcdp->declBit(c+7,"rx_testbench i_clk",-1);
	vcdp->declBit(c+8,"rx_testbench i_fsdo",-1);
	vcdp->declBus(c+9,"rx_testbench RX_DATA_CHK",-1,7,0);
	vcdp->declBus(c+5,"rx_testbench rx_data",-1,7,0);
	vcdp->declBit(c+1,"rx_testbench rx_ready",-1);
	vcdp->declBit(c+6,"rx_testbench fsclk",-1);
	vcdp->declBit(c+7,"rx_testbench clock_for_fastserial i_clk",-1);
	vcdp->declBit(c+6,"rx_testbench clock_for_fastserial o_fsclk",-1);
	vcdp->declBit(c+6,"rx_testbench clock_for_fastserial fsclk",-1);
	vcdp->declBit(c+7,"rx_testbench rx_lite i_clk",-1);
	vcdp->declBit(c+8,"rx_testbench rx_lite i_fsdo",-1);
	vcdp->declBit(c+6,"rx_testbench rx_lite i_fsclk",-1);
	vcdp->declBus(c+5,"rx_testbench rx_lite o_data",-1,7,0);
	vcdp->declBit(c+1,"rx_testbench rx_lite o_ready",-1);
	vcdp->declBus(c+10,"rx_testbench rx_lite WAIT_FOR_START_BIT",-1,3,0);
	vcdp->declBus(c+11,"rx_testbench rx_lite BIT_ZERO",-1,3,0);
	vcdp->declBus(c+12,"rx_testbench rx_lite BIT_ONE",-1,3,0);
	vcdp->declBus(c+13,"rx_testbench rx_lite BIT_TWO",-1,3,0);
	vcdp->declBus(c+14,"rx_testbench rx_lite BIT_THREE",-1,3,0);
	vcdp->declBus(c+15,"rx_testbench rx_lite BIT_FOUR",-1,3,0);
	vcdp->declBus(c+16,"rx_testbench rx_lite BIT_FIVE",-1,3,0);
	vcdp->declBus(c+17,"rx_testbench rx_lite BIT_SIX",-1,3,0);
	vcdp->declBus(c+18,"rx_testbench rx_lite BIT_SEVEN",-1,3,0);
	vcdp->declBus(c+19,"rx_testbench rx_lite BIT_DEST",-1,3,0);
	vcdp->declBus(c+20,"rx_testbench rx_lite DONE",-1,3,0);
	vcdp->declBus(c+21,"rx_testbench rx_lite IDLE",-1,3,0);
	vcdp->declBus(c+2,"rx_testbench rx_lite state",-1,3,0);
	vcdp->declBus(c+5,"rx_testbench rx_lite rx_data",-1,7,0);
	vcdp->declBit(c+1,"rx_testbench rx_lite rx_ready",-1);
	vcdp->declBit(c+3,"rx_testbench rx_lite q_fsdo",-1);
	vcdp->declBit(c+4,"rx_testbench rx_lite d_fsdo",-1);
    }
}

void Vrx_testbench::traceFullThis__1(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBit(c+1,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_ready));
	vcdp->fullBus(c+2,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state),4);
	vcdp->fullBit(c+3,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__q_fsdo));
	vcdp->fullBit(c+4,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__d_fsdo));
	vcdp->fullBus(c+5,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_data),8);
	vcdp->fullBit(c+6,(vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk));
	vcdp->fullBit(c+7,(vlTOPp->i_clk));
	vcdp->fullBit(c+8,(vlTOPp->i_fsdo));
	vcdp->fullBus(c+9,(0x30U),8);
	vcdp->fullBus(c+10,(0U),4);
	vcdp->fullBus(c+11,(1U),4);
	vcdp->fullBus(c+12,(2U),4);
	vcdp->fullBus(c+13,(3U),4);
	vcdp->fullBus(c+14,(4U),4);
	vcdp->fullBus(c+15,(5U),4);
	vcdp->fullBus(c+16,(6U),4);
	vcdp->fullBus(c+17,(7U),4);
	vcdp->fullBus(c+18,(8U),4);
	vcdp->fullBus(c+19,(9U),4);
	vcdp->fullBus(c+20,(0xaU),4);
	vcdp->fullBus(c+21,(0xfU),4);
    }
}
