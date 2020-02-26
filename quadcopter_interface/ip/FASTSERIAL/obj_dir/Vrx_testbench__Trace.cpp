// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vrx_testbench__Syms.h"


//======================

void Vrx_testbench::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vrx_testbench* t=(Vrx_testbench*)userthis;
    Vrx_testbench__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void Vrx_testbench::traceChgThis(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
			       | (vlTOPp->__Vm_traceActivity 
				  >> 1U))))) {
	    vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
	}
	if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__3(vlSymsp, vcdp, code);
	}
	vlTOPp->traceChgThis__4(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vrx_testbench::traceChgThis__2(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+1,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_ready));
	vcdp->chgBus(c+2,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state),4);
	vcdp->chgBit(c+3,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__q_fsdo));
	vcdp->chgBit(c+4,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__d_fsdo));
    }
}

void Vrx_testbench::traceChgThis__3(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus(c+5,(vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_data),8);
	vcdp->chgBit(c+6,(vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk));
    }
}

void Vrx_testbench::traceChgThis__4(Vrx_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit(c+7,(vlTOPp->i_clk));
	vcdp->chgBit(c+8,(vlTOPp->i_fsdo));
    }
}
