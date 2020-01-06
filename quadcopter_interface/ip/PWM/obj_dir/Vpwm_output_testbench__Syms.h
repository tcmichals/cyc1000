// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header

#ifndef _Vpwm_output_testbench__Syms_H_
#define _Vpwm_output_testbench__Syms_H_

#include "verilated_heavy.h"

// INCLUDE MODULE CLASSES
#include "Vpwm_output_testbench.h"

// SYMS CLASS
class Vpwm_output_testbench__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vpwm_output_testbench*         TOPp;
    
    // CREATORS
    Vpwm_output_testbench__Syms(Vpwm_output_testbench* topp, const char* namep);
    ~Vpwm_output_testbench__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    inline bool getClearActivity() { bool r=__Vm_activity; __Vm_activity=false; return r; }
    
} VL_ATTR_ALIGNED(64);

#endif // guard
