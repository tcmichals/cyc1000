`default_nettype none
`timescale 1 ns / 1 ns
/* https://iverilog.fandom.com/wiki/Getting_Started */

module test;



  /* Make a reset that pulses once. */
  reg i_reset = 0;
  reg i_clk = 0;
  reg [15:0] low = 16'hAA20;
  reg [15:0] high = 16'hAA55;
  reg i_write = 0 ;
  wire o_pwm;

  initial begin
     $dumpfile("test.vcd");
     $dumpvars(0,test);
     # 10 i_reset = 1;
     # 10 i_reset = 0;
     # 1 i_write = 1;
     # 1 i_write = 0;
     # 10689 $finish;
  end

  /* Make a regular pulsing clock. */

  always #1 i_clk = !i_clk;


dhot_output motor_1(	.i_clk(i_clk),
			.i_reset(i_reset),
			.i_pwm_low_value(low),
			.i_pwm_high_value(high),
			.i_write(i_write),
			.o_pwm(o_pwm));
			
  /* Make a reset that pulses once. */  
  initial
     $monitor("At time %t, value = %h", $time, o_pwm, );

		


endmodule
//eof
