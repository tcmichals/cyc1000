// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Vpwm_output_testbench_H_
#define _Vpwm_output_testbench_H_

#include "verilated_heavy.h"

class Vpwm_output_testbench__Syms;
class VerilatedVcd;

//----------

VL_MODULE(Vpwm_output_testbench) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    // Begin mtask footprint  all: 
    VL_IN8(i_clk,0,0);
    VL_IN8(i_reset,0,0);
    VL_IN8(i_write,0,0);
    VL_OUT8(o_pwm,0,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    // Begin mtask footprint  all: 
    VL_SIG8(pwm_output_testbench__DOT__motor_1__DOT__state,3,0);
    VL_SIG8(pwm_output_testbench__DOT__motor_1__DOT__pwm,0,0);
    VL_SIG16(pwm_output_testbench__DOT__motor_1__DOT__tick_microsec,15,0);
    VL_SIG16(pwm_output_testbench__DOT__motor_1__DOT__pwm_set_low,15,0);
    VL_SIG16(pwm_output_testbench__DOT__motor_1__DOT__pwm_set_high,15,0);
    VL_SIG16(pwm_output_testbench__DOT__motor_1__DOT__pwm_high,15,0);
    VL_SIG16(pwm_output_testbench__DOT__motor_1__DOT__pwm_low,15,0);
    VL_SIG(pwm_output_testbench__DOT__motor_1__DOT__guard_time,31,0);
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    // Begin mtask footprint  all: 
    VL_SIG8(__Vclklast__TOP__i_clk,0,0);
    VL_SIG8(__Vclklast__TOP__i_reset,0,0);
    VL_SIG(__Vm_traceActivity,31,0);
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vpwm_output_testbench__Syms* __VlSymsp;  // Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vpwm_output_testbench);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vpwm_output_testbench(const char* name="TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vpwm_output_testbench();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options=0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vpwm_output_testbench__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vpwm_output_testbench__Syms* symsp, bool first);
  private:
    static QData _change_request(Vpwm_output_testbench__Syms* __restrict vlSymsp);
    void _ctor_var_reset();
  public:
    static void _eval(Vpwm_output_testbench__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif // VL_DEBUG
  public:
    static void _eval_initial(Vpwm_output_testbench__Syms* __restrict vlSymsp);
    static void _eval_settle(Vpwm_output_testbench__Syms* __restrict vlSymsp);
    static void _sequent__TOP__1(Vpwm_output_testbench__Syms* __restrict vlSymsp);
    static void _sequent__TOP__2(Vpwm_output_testbench__Syms* __restrict vlSymsp);
    static void _settle__TOP__3(Vpwm_output_testbench__Syms* __restrict vlSymsp);
    static void traceChgThis(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__2(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__3(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis__1(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceInitThis(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceInitThis__1(Vpwm_output_testbench__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code);
} VL_ATTR_ALIGNED(128);

#endif // guard
