//Legal Notice: (C)2020 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module picorv32_soc_avalon_mutex_0 (
                                     // inputs:
                                      address,
                                      chipselect,
                                      clk,
                                      data_from_cpu,
                                      read,
                                      reset_n,
                                      write,

                                     // outputs:
                                      data_to_cpu
                                   )
;

  output  [ 31: 0] data_to_cpu;
  input            address;
  input            chipselect;
  input            clk;
  input   [ 31: 0] data_from_cpu;
  input            read;
  input            reset_n;
  input            write;


wire    [ 31: 0] data_to_cpu;
wire             mutex_free;
reg     [ 15: 0] mutex_owner;
wire             mutex_reg_enable;
wire    [ 31: 0] mutex_state;
reg     [ 15: 0] mutex_value;
wire             owner_valid;
reg              reset_reg;
wire             reset_reg_enable;
  //s1, which is an e_avalon_slave
  //mutex_value, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          mutex_value <= 0;
      else if (mutex_reg_enable)
          mutex_value <= data_from_cpu[15 : 0];
    end


  //mutex_owner, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          mutex_owner <= 0;
      else if (mutex_reg_enable)
          mutex_owner <= data_from_cpu[31 : 16];
    end


  //reset_reg, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reset_reg <= 1'b1;
      else if (reset_reg_enable)
          reset_reg <= 1'b0;
    end


  assign mutex_free = mutex_value == 0;
  assign owner_valid = mutex_owner == data_from_cpu[31 : 16];
  assign mutex_reg_enable = (mutex_free | owner_valid) & chipselect & write & ~address;
  assign reset_reg_enable = chipselect & write & address;
  assign data_to_cpu = address ? reset_reg : mutex_state;
  assign mutex_state[15 : 0] = mutex_value;
  assign mutex_state[31 : 16] = mutex_owner;

endmodule

