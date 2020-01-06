// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vpwm_output_testbench.h for the primary calling header

#include "Vpwm_output_testbench.h"
#include "Vpwm_output_testbench__Syms.h"


//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vpwm_output_testbench) {
    Vpwm_output_testbench__Syms* __restrict vlSymsp = __VlSymsp = new Vpwm_output_testbench__Syms(this, name());
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vpwm_output_testbench::__Vconfigure(Vpwm_output_testbench__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vpwm_output_testbench::~Vpwm_output_testbench() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Vpwm_output_testbench::eval() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vpwm_output_testbench::eval\n"); );
    Vpwm_output_testbench__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
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

void Vpwm_output_testbench::_eval_initial_loop(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
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

VL_INLINE_OPT void Vpwm_output_testbench::_sequent__TOP__1(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_sequent__TOP__1\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // ALWAYS at pwm_output_testbench.v:23
    if (VL_UNLIKELY(vlTOPp->i_write)) {
	VL_WRITEF("write\n");
    }
}

VL_INLINE_OPT void Vpwm_output_testbench::_sequent__TOP__2(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_sequent__TOP__2\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    // Begin mtask footprint  all: 
    VL_SIG8(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__state,3,0);
    VL_SIG16(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec,15,0);
    VL_SIG16(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high,15,0);
    VL_SIG16(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low,15,0);
    VL_SIG16(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low,15,0);
    VL_SIG16(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high,15,0);
    VL_SIG(__Vdly__pwm_output_testbench__DOT__motor_1__DOT__guard_time,31,0);
    // Body
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high;
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low;
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_low;
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_high;
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__tick_microsec;
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__guard_time 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time;
    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__state 
	= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__state;
    // ALWAYS at pwm_output.v:36
    if (vlTOPp->i_reset) {
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__state = 1U;
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__guard_time = 0U;
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec = 0U;
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high = 0U;
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low = 0U;
	vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm = 0U;
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low = 0U;
	__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high = 0U;
    } else {
	if (VL_UNLIKELY(vlTOPp->i_write)) {
	    VL_WRITEF("update\n");
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__state = 1U;
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__guard_time = 0U;
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec = 0U;
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high = 0U;
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low = 0U;
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high = 0x7d0U;
	    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low = 0x1f4U;
	} else {
	    if (VL_LIKELY((0x32U > (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__tick_microsec)))) {
		__Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec 
		    = (0xffffU & ((IData)(1U) + (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__tick_microsec)));
	    } else {
		if ((0xf4240U > vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time)) {
		    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__guard_time 
			= ((IData)(1U) + vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time);
		}
		VL_WRITEF("guard time %10#\n",32,vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time);
		if ((1U == (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__state))) {
		    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm = 1U;
		    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec = 0U;
		    if (((IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_high) 
			 < (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high))) {
			__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high 
			    = (0xffffU & ((IData)(1U) 
					  + (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_high)));
		    } else {
			__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high = 0U;
			vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm = 0U;
			__Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low = 0U;
			__Vdly__pwm_output_testbench__DOT__motor_1__DOT__state 
			    = ((0xf4240U <= vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time)
			        ? 3U : 2U);
		    }
		} else {
		    if (VL_LIKELY((2U == (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__state)))) {
			vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm = 0U;
			__Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec = 0U;
			if (((IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_low) 
			     < (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low))) {
			    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low 
				= (0xffffU & ((IData)(1U) 
					      + (IData)(vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_low)));
			} else {
			    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__state = 1U;
			    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high = 0U;
			    __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low = 0U;
			}
		    } else {
			VL_WRITEF("guard time tripped\n");
			vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm = 0U;
		    }
		}
	    }
	}
    }
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__state 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__state;
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__guard_time 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__guard_time;
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__tick_microsec 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__tick_microsec;
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_high 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_high;
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_low 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_low;
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low;
    vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high 
	= __Vdly__pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high;
    vlTOPp->o_pwm = vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm;
}

void Vpwm_output_testbench::_settle__TOP__3(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_settle__TOP__3\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->o_pwm = vlTOPp->pwm_output_testbench__DOT__motor_1__DOT__pwm;
}

void Vpwm_output_testbench::_eval(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_eval\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->i_clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__i_clk)))) {
	vlTOPp->_sequent__TOP__1(vlSymsp);
    }
    if ((((IData)(vlTOPp->i_clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__i_clk))) 
	 | ((IData)(vlTOPp->i_reset) & (~ (IData)(vlTOPp->__Vclklast__TOP__i_reset))))) {
	vlTOPp->_sequent__TOP__2(vlSymsp);
	vlTOPp->__Vm_traceActivity = (2U | vlTOPp->__Vm_traceActivity);
    }
    // Final
    vlTOPp->__Vclklast__TOP__i_clk = vlTOPp->i_clk;
    vlTOPp->__Vclklast__TOP__i_reset = vlTOPp->i_reset;
}

void Vpwm_output_testbench::_eval_initial(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_eval_initial\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vclklast__TOP__i_clk = vlTOPp->i_clk;
    vlTOPp->__Vclklast__TOP__i_reset = vlTOPp->i_reset;
}

void Vpwm_output_testbench::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::final\n"); );
    // Variables
    Vpwm_output_testbench__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vpwm_output_testbench::_eval_settle(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_eval_settle\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__3(vlSymsp);
}

VL_INLINE_OPT QData Vpwm_output_testbench::_change_request(Vpwm_output_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_change_request\n"); );
    Vpwm_output_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vpwm_output_testbench::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((i_clk & 0xfeU))) {
	Verilated::overWidthError("i_clk");}
    if (VL_UNLIKELY((i_reset & 0xfeU))) {
	Verilated::overWidthError("i_reset");}
    if (VL_UNLIKELY((i_write & 0xfeU))) {
	Verilated::overWidthError("i_write");}
}
#endif // VL_DEBUG

void Vpwm_output_testbench::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpwm_output_testbench::_ctor_var_reset\n"); );
    // Body
    i_clk = VL_RAND_RESET_I(1);
    i_reset = VL_RAND_RESET_I(1);
    i_write = VL_RAND_RESET_I(1);
    o_pwm = VL_RAND_RESET_I(1);
    pwm_output_testbench__DOT__motor_1__DOT__state = VL_RAND_RESET_I(4);
    pwm_output_testbench__DOT__motor_1__DOT__guard_time = VL_RAND_RESET_I(32);
    pwm_output_testbench__DOT__motor_1__DOT__tick_microsec = VL_RAND_RESET_I(16);
    pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low = VL_RAND_RESET_I(16);
    pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high = VL_RAND_RESET_I(16);
    pwm_output_testbench__DOT__motor_1__DOT__pwm_high = VL_RAND_RESET_I(16);
    pwm_output_testbench__DOT__motor_1__DOT__pwm_low = VL_RAND_RESET_I(16);
    pwm_output_testbench__DOT__motor_1__DOT__pwm = VL_RAND_RESET_I(1);
    __Vm_traceActivity = VL_RAND_RESET_I(32);
}
