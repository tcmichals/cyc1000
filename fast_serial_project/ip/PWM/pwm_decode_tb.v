`default_nettype none
`timescale 1 ns/10 ps  // time-unit = 1 us, precision = 10 ps

module pwm_decode_tb;

    reg clk = 1;
    reg pwm_signal = 0;
    reg reset = 1;
    time currentTime = 0;
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
   
    /* measure 1999us */
    #0001000 pwm_signal <= 1;
    #2000000 pwm_signal <= 0;

    /* measure 2600ms (guard time is 2600max), should result in ERROR*/
    #0010000 pwm_signal <= 1;
    currentTime = $realtime;
    #2700000 pwm_signal <= 0;

    /* measure 699us, should result in ERROR*/
    #0001000 pwm_signal <= 1;
    currentTime = $realtime;
    #0700000 pwm_signal <= 0;

   currentTime = $realtime;
    /* should result in error locked low */
    #2610000 $finish;
end
        
always @(posedge clk)
begin
    if (pwm_complete) begin
        if ( pwm_value & GUARD_ERROR) begin
           $display("PWM ERROR %dus", (pwm_value & ~GUARD_ERROR));
	end
        else
           $display("PWM length %dus", pwm_value);

    end
end


    

endmodule
