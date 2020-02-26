// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header

#ifndef _Vrx_testbench__Syms_H_
#define _Vrx_testbench__Syms_H_

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Vrx_testbench.h"

// SYMS CLASS
class Vrx_testbench__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vrx_testbench*                 TOPp;
    
    // CREATORS
    Vrx_testbench__Syms(Vrx_testbench* topp, const char* namep);
    ~Vrx_testbench__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    inline bool getClearActivity() { bool r=__Vm_activity; __Vm_activity=false; return r; }
    
} VL_ATTR_ALIGNED(64);

#endif // guard
