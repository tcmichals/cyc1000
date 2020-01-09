`default_nettype none
`timescale 1 ns / 1 ns


module pwm_output_testbench(input wire i_clk, 
			    input wire i_reset,
			    input wire i_write,
			    output wire o_pwm);
			  


localparam [15:0] low 	= 500;
localparam  [15:0] high	= 2000;

pwm_output motor_1(	.i_clk(i_clk),
			.i_reset(i_reset),
			.i_pwm_low_value(low),
			.i_pwm_high_value(high),
			.i_write(i_write),
			.o_pwm(o_pwm));
			
		
always @(posedge i_clk) begin
    if ( i_write ) begin
            $display ("write");
    end
end

endmodule
//eof