// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vrx_testbench.h for the primary calling header

#include "Vrx_testbench.h"
#include "Vrx_testbench__Syms.h"


//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vrx_testbench) {
    Vrx_testbench__Syms* __restrict vlSymsp = __VlSymsp = new Vrx_testbench__Syms(this, name());
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vrx_testbench::__Vconfigure(Vrx_testbench__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vrx_testbench::~Vrx_testbench() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Vrx_testbench::eval() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vrx_testbench::eval\n"); );
    Vrx_testbench__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
	VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
	vlSymsp->__Vm_activity = true;
	_eval(vlSymsp);
	if (VL_UNLIKELY(++__VclockLoop > 100)) {
	    // About to fail, so enable debug to see what's not settling.
	    // Note you must run make with OPT=-DVL_DEBUG for debug prints.
	    int __Vsaved_debug = Verilated::debug();
	    Verilated::debug(1);
	    __Vchange = _change_request(vlSymsp);
	    Verilated::debug(__Vsaved_debug);
	    VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Verilated model didn't converge");
	} else {
	    __Vchange = _change_request(vlSymsp);
	}
    } while (VL_UNLIKELY(__Vchange));
}

void Vrx_testbench::_eval_initial_loop(Vrx_testbench__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
	_eval_settle(vlSymsp);
	_eval(vlSymsp);
	if (VL_UNLIKELY(++__VclockLoop > 100)) {
	    // About to fail, so enable debug to see what's not settling.
	    // Note you must run make with OPT=-DVL_DEBUG for debug prints.
	    int __Vsaved_debug = Verilated::debug();
	    Verilated::debug(1);
	    __Vchange = _change_request(vlSymsp);
	    Verilated::debug(__Vsaved_debug);
	    VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Verilated model didn't DC converge");
	} else {
	    __Vchange = _change_request(vlSymsp);
	}
    } while (VL_UNLIKELY(__Vchange));
}

//--------------------
// Internal Methods

void Vrx_testbench::_initial__TOP__1(Vrx_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_initial__TOP__1\n"); );
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // INITIAL at rx_fastserial.v:37
    vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_ready = 0U;
    // INITIAL at rx_fastserial.v:36
    vlTOPp->rx_testbench__DOT__rx_lite__DOT__state = 0U;
    // INITIAL at rx_fastserial.v:38
    vlTOPp->rx_testbench__DOT__rx_lite__DOT__q_fsdo = 1U;
    // INITIAL at rx_fastserial.v:39
    vlTOPp->rx_testbench__DOT__rx_lite__DOT__d_fsdo = 1U;
}

VL_INLINE_OPT void Vrx_testbench::_sequent__TOP__2(Vrx_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_sequent__TOP__2\n"); );
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    // Begin mtask footprint  all: 
    VL_SIG8(__Vdly__rx_testbench__DOT__clock_for_fastserial__DOT__fsclk,0,0);
    VL_SIG8(__Vdly__rx_testbench__DOT__rx_lite__DOT__state,3,0);
    VL_SIG8(__Vdly__rx_testbench__DOT__rx_lite__DOT__rx_data,7,0);
    // Body
    __Vdly__rx_testbench__DOT__clock_for_fastserial__DOT__fsclk 
	= vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk;
    __Vdly__rx_testbench__DOT__rx_lite__DOT__rx_data 
	= vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_data;
    __Vdly__rx_testbench__DOT__rx_lite__DOT__state 
	= vlTOPp->rx_testbench__DOT__rx_lite__DOT__state;
    // ALWAYS at clock_fastserial.v:10
    __Vdly__rx_testbench__DOT__clock_for_fastserial__DOT__fsclk 
	= (1U & (~ (IData)(vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk)));
    // ALWAYS at rx_fastserial.v:48
    if ((0xaU == (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state))) {
	__Vdly__rx_testbench__DOT__rx_lite__DOT__state = 0U;
	vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_ready = 0U;
	__Vdly__rx_testbench__DOT__rx_lite__DOT__rx_data = 0U;
    }
    if (vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk) {
	if ((0U == (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state))) {
	    if ((1U & (~ (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__q_fsdo)))) {
		__Vdly__rx_testbench__DOT__rx_lite__DOT__state = 1U;
	    }
	} else {
	    if ((9U == (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state))) {
		__Vdly__rx_testbench__DOT__rx_lite__DOT__state 
		    = (0xfU & ((IData)(1U) + (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state)));
		vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_ready = 1U;
	    } else {
		if (((1U <= (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state)) 
		     & (8U >= (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state)))) {
		    __Vdly__rx_testbench__DOT__rx_lite__DOT__state 
			= (0xfU & ((IData)(1U) + (IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__state)));
		    __Vdly__rx_testbench__DOT__rx_lite__DOT__rx_data 
			= (((IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__q_fsdo) 
			    << 7U) | (0x7fU & ((IData)(vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_data) 
					       >> 1U)));
		}
	    }
	}
    }
    vlTOPp->rx_testbench__DOT__rx_lite__DOT__rx_data 
	= __Vdly__rx_testbench__DOT__rx_lite__DOT__rx_data;
    vlTOPp->rx_testbench__DOT__rx_lite__DOT__state 
	= __Vdly__rx_testbench__DOT__rx_lite__DOT__state;
    // ALWAYS at rx_fastserial.v:42
    if (vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk) {
	vlTOPp->rx_testbench__DOT__rx_lite__DOT__q_fsdo 
	    = vlTOPp->rx_testbench__DOT__rx_lite__DOT__d_fsdo;
    }
    // ALWAYS at rx_fastserial.v:42
    if (vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk) {
	vlTOPp->rx_testbench__DOT__rx_lite__DOT__d_fsdo 
	    = vlTOPp->i_fsdo;
    }
    vlTOPp->rx_testbench__DOT__clock_for_fastserial__DOT__fsclk 
	= __Vdly__rx_testbench__DOT__clock_for_fastserial__DOT__fsclk;
}

void Vrx_testbench::_eval(Vrx_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_eval\n"); );
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->i_clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__i_clk)))) {
	vlTOPp->_sequent__TOP__2(vlSymsp);
	vlTOPp->__Vm_traceActivity = (2U | vlTOPp->__Vm_traceActivity);
    }
    // Final
    vlTOPp->__Vclklast__TOP__i_clk = vlTOPp->i_clk;
}

void Vrx_testbench::_eval_initial(Vrx_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_eval_initial\n"); );
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_initial__TOP__1(vlSymsp);
    vlTOPp->__Vm_traceActivity = (1U | vlTOPp->__Vm_traceActivity);
    vlTOPp->__Vclklast__TOP__i_clk = vlTOPp->i_clk;
}

void Vrx_testbench::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::final\n"); );
    // Variables
    Vrx_testbench__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vrx_testbench::_eval_settle(Vrx_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_eval_settle\n"); );
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

VL_INLINE_OPT QData Vrx_testbench::_change_request(Vrx_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_change_request\n"); );
    Vrx_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vrx_testbench::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((i_clk & 0xfeU))) {
	Verilated::overWidthError("i_clk");}
    if (VL_UNLIKELY((i_fsdo & 0xfeU))) {
	Verilated::overWidthError("i_fsdo");}
}
#endif // VL_DEBUG

void Vrx_testbench::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vrx_testbench::_ctor_var_reset\n"); );
    // Body
    i_clk = VL_RAND_RESET_I(1);
    i_fsdo = VL_RAND_RESET_I(1);
    rx_testbench__DOT__clock_for_fastserial__DOT__fsclk = VL_RAND_RESET_I(1);
    rx_testbench__DOT__rx_lite__DOT__state = VL_RAND_RESET_I(4);
    rx_testbench__DOT__rx_lite__DOT__rx_data = VL_RAND_RESET_I(8);
    rx_testbench__DOT__rx_lite__DOT__rx_ready = VL_RAND_RESET_I(1);
    rx_testbench__DOT__rx_lite__DOT__q_fsdo = VL_RAND_RESET_I(1);
    rx_testbench__DOT__rx_lite__DOT__d_fsdo = VL_RAND_RESET_I(1);
    __Vm_traceActivity = VL_RAND_RESET_I(32);
}
