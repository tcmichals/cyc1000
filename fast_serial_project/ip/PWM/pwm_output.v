`default_nettype none
`timescale 1 ns / 1 ns

/*  Generic PWM out based on a 1us timer
    Two inputs
	Low time for pluse
	High time for pulse.
        There is a dead time of 1us between pulse rates

	For example:
		Standard PWM is 1ms to 2ms high pulse with. 
		So, for 1ms high and 3ms low time, this will be a 400Hz signal
	Oneshot 125 is 125us low to 250us high.
	for a low value, it is 125us high and 125us low = 250us. there is a delay of 1us between updates. The master must send the 		rates at least every 10ms or faster. 
		
*/


module pwm_output #(
		parameter clockFrequency = 50000000
	) (
		input  wire        i_clk,          //       clock.clk
		input  wire        i_reset,        //       reset.reset
		input  wire [15:0] i_pwm_low_value,     //      avs_s0.address
		input  wire [15:0] i_pwm_high_value,
		input  wire        i_write,       //            .write
		output wire	   o_pwm
	);
	


localparam [3:0]	IDLE	   = 4'h0,
			PWM_HIGH   = 4'h1,
	         	PWM_LOW    = 4'h2,
			GUARD_TIME = 4'h3;

						 
localparam [15:0] ticks_in_oneus = 16'd50; /* clockFrequency/1000000 gives a truncation warning */

reg [3:0] state;

reg [15:0] tick_microsec;
reg [15:0] pwm_set_low;
reg [15:0] pwm_set_high;


reg [15:0] pwm_high;
reg [15:0] pwm_low;
reg pwm;


always @(posedge i_clk) begin	

	if (i_reset) begin
		state <= IDLE;
		tick_microsec <= 0;
		pwm_high <= 0;
		pwm_low <= 0;
		pwm <= 0;
		pwm_set_low <= 0;
		pwm_set_high <= 0;
	end
	else begin
		/* update pwm value */
		if (i_write) begin
			case (state)
				PWM_HIGH:;
				PWM_LOW:;
				GUARD_TIME:;
				default: begin
					 state <= PWM_HIGH;
					 tick_microsec <= 0;
					 pwm_set_high <=  i_pwm_high_value;
					 pwm_set_low <=  i_pwm_low_value;
					$display ("update");
				end
			endcase 
		end
		else begin
			/* simple counter for 1us clock */
			if ( tick_microsec < ticks_in_oneus)
				tick_microsec <= tick_microsec +1'b1;
			else begin
				/* reset counter */
				tick_microsec <= 0;
				case (state) 
				
					PWM_HIGH: begin
						pwm <= 1;
						if (pwm_high < pwm_set_high) 
							pwm_high <=  pwm_high + 1'b1;
						else 
							state <= PWM_LOW;
					end
				
					PWM_LOW: begin
						pwm <= 0;
						if (pwm_low < pwm_set_low)
							pwm_low <= pwm_low + 1'b1;
						else
							state <= GUARD_TIME;
					end
					
					GUARD_TIME: begin
						pwm <= 0;
						 if (tick_microsec < ticks_in_oneus) 
							tick_microsec <= tick_microsec +1'b1;
						else
							state <= IDLE;
					end
				
					default: begin
						pwm <= 0;
						pwm_high <= 0;
						pwm_low <= 0;
					end
				endcase
			end
		end
	end
end
assign o_pwm = pwm;

endmodule
//END of modules
