`default_nettype none


`timescale 1 ns/10 ps  // time-unit = 1 us, precision = 10 ps

module pwm_decode_tb;

    reg clk = 1;
    reg pwm_signal = 0;
    reg reset = 0;
    wire pwm_complete;
    wire [15:0]pwm_value;

    localparam period = 10000000;

    //Override our clock with 1Mhz clock
    pwm_decode #(period) UUT( .i_clk(clk),
                              .i_pwm(pwm_signal),
                              .i_reset(reset),
                              .o_pwm_ready(pwm_complete),
                              .o_pwm_value(pwm_value));

always begin
        #50 clk =!clk;
end

localparam GUARD_ERROR 	= 16'h8000;

initial begin
    $dumpfile("pwm_decode_tb.vcd");
    $dumpvars(0,pwm_decode_tb);
    #1000000 pwm_signal <= 1;
    #2000000 pwm_signal <= 0;

    #1000000 pwm_signal <= 1;
    #5000000 pwm_signal <= 0;

    #1000000 pwm_signal <= 1;
    #0700000 pwm_signal <= 0;

    #7000000 $finish;
end
        
always @(posedge clk)
begin
    if (pwm_complete) begin
        if ( pwm_value & GUARD_ERROR)
           $display("PWM ERROR %d %dus", (pwm_value & ~GUARD_ERROR), $time/1000);
        else
           $display("PWM length %d %dus", pwm_value, $time/1000);

    end
end


    

endmodule
