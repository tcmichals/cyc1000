`default_nettype none
`timescale 1 ns / 1 ns

module pwm_output #(
		parameter update_guardtime = 1000000, //1 second 
		parameter clockFrequency = 50000000
	) (
		input  wire        i_clk,          //       clock.clk
		input  wire        i_reset,        //       reset.reset
		input  wire [15:0] i_pwm_low_value,     //      avs_s0.address
		input	 wire [15:0] i_pwm_high_value,
		input  wire        i_write,       //            .write
		output wire			 o_pwm
	);
	


localparam [3:0] PWM_HIGH   = 4'h1,
	         PWM_LOW    = 4'h2,
		 GUARD_TIME = 4'h3;
						 
localparam [15:0] max_time = 50;

reg [3:0] state;
reg [31:0] guard_time;
reg [15:0] tick_microsec;
reg [15:0] pwm_set_low;
reg [15:0] pwm_set_high;


reg [15:0] pwm_high;
reg [15:0] pwm_low;
reg pwm;


always @(posedge i_clk or posedge i_reset) begin	

	if (i_reset) begin
	
			state <= PWM_HIGH;
			guard_time <= 0;
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
				default: begin
					 state <= PWM_HIGH;
					 tick_microsec <= 0;
				end
			endcase 

			guard_time <= 0;
			pwm_set_high <=  i_pwm_high_value;
			pwm_set_low <=  i_pwm_low_value;
			$display ("update");
		end
		else begin
		
			if ( tick_microsec < max_time)
				tick_microsec <= tick_microsec + 1;
			else begin
			
				if (guard_time < update_guardtime)
					guard_time <= guard_time + 1'b1;
				else begin
					state <= GUARD_TIME;
					$display ("guard time exceeded");
				end
			
			/* OK 1 microsecond passed */
				case (state) 
				PWM_HIGH: begin
					pwm <= 1;
					tick_microsec <= 0;
					if (pwm_high < pwm_set_high) begin
						pwm_high <=  pwm_high +1;
					end
					else begin
						pwm_high <= 0;
						pwm <= 0;
						pwm_low <= 0;
						state <= PWM_LOW;
					end
				end
				
				PWM_LOW: begin
					pwm <= 0;
					tick_microsec <= 0;
					if (pwm_low < pwm_set_low) begin
						pwm_low <= pwm_low + 1'b1;
					end
					else begin
						state <= PWM_HIGH;
						pwm_high <= 0;
						pwm_low <= 0;
					end
				end
				default:
					pwm <= 0;
				endcase
		
			end
		end
	end
	
end
assign o_pwm = pwm;

endmodule
//END of modules

