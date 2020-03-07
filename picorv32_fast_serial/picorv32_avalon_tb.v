module main;

  reg clk, reset;
  reg [7:0] LED;


  picorv32_soc dut (clk, reset, LED);

  always #10 clk = ~clk;

  initial begin
     clk = 0;
     reset = 1;

     if (! $value$plusargs("x=%d", x)) begin
        $display("ERROR: please specify +x=<value> to start.");
        $finish;
     end

     #35 reset = 0;

     wait (rdy) $display("y=%d", y);
     $finish;
  end // initial begin

endmodule // main
