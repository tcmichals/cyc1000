`default_nettype none
`timescale 1 ns / 1 ns

module dhot_output #(
		parameter update_guardtime = 1000000, //1 second 
		parameter clockFrequency = 50000000
	) (
		input  wire        i_clk,          //       clock.clk
		input  wire        i_reset,        //       reset.reset
		input  wire [15:0] i_dshot_value,
		input  wire        i_write,       //            .write
		output wire	       o_pwm
	);
	


/* state machine state of single bit */
localparam [3:0] INIT_TIME  = 4'h0,
		 		HIGH_TIME   = 4'h1,
	     	 	LOW_TIME    = 4'h2,
                IDLE_	    = 4'h3;
		
/* DSHOT Bit time:              (1 - TH1)   (0-T0H)
DSHOT 150 Bit time is 6.67us    5.00us      2.50us
DSHOT 300 Bit time is 3.33us    2.50us      1.25us
DSHOT 600 Bit time is 1.67us    1.25us      0.625us
DSHOT1200 Bit time is 0.83us    0.025       0.313us
*/

/* For DSHOT150 clk is 50Mhz so 0-T0H is  2.50 * 50 = 125
                                0-Off is (6.67 - 2.50us) * 50 = 208.9
*/                                
                                
localparam [15:0] LOW_HIGH_TIME = 125 - 10;
localparam [15:0] LOW_LOW_TIME = 209 + 10;

/* For DSHOT150 clk is 50Mhz so 0-T1H is  5.00 * 50 = 250
                                0-Off is (6.67 - 5.00us) * 50 = 83.5
*/

localparam [15:0] HIGH_HIGH_TIME = 250 + 10;
localparam [15:0] HIGH_LOW_TIME = 84 - 10;


/* number of bits to shift */
localparam [3:0] NUM_BIT_TO_SHIFT = 15;

localparam [15:0] GUARD_TIME = 12500;

reg [3:0] state;
reg [4:0] bits_to_shift;
reg [15:0] counter_high;
reg [15:0] counter_low;

reg [15:0] dshot_command;
reg [15:0] guard_count;


reg pwm;


always @(posedge i_clk or posedge i_reset) begin	

	if (i_reset) begin
		state <= IDLE_;
		bits_to_shift <= 0;
		dshot_command <= 0;
		pwm <= 0;
		guard_count <= GUARD_TIME;
	end
	else begin
		/* update pwm value */
		if (i_write && guard_count==0) begin
            /* guard the current write */
			if (bits_to_shift == 0) begin		
				dshot_command <= i_dshot_value;
				bits_to_shift <= NUM_BIT_TO_SHIFT;
				state <= INIT_TIME;
				$display ("update %X", i_dshot_value);
				guard_count <= GUARD_TIME;
			end
		end
		else begin
			case (state)
				INIT_TIME: begin
					$display ("INIT_TIME 0x%X", dshot_command);
					if (dshot_command[15]) begin
						counter_high = HIGH_HIGH_TIME;
						counter_low = HIGH_LOW_TIME;
					end
					else begin
						counter_high = LOW_HIGH_TIME;
						counter_low = LOW_LOW_TIME;
					end
					state <= HIGH_TIME;
				end

				HIGH_TIME: begin
					pwm <= 1;
					if (counter_high == 0)	begin
						state <= LOW_TIME;
					end
					else			
						counter_high <= counter_high -1'b1;

				end
				LOW_TIME: begin
					pwm <= 0;
					if (counter_low == 0) begin
						if ( bits_to_shift == 0) begin
							state = IDLE_;
							$display("DONE  Complete ");
						end
						else begin
							bits_to_shift <= bits_to_shift -1'b1;
						  	dshot_command <= { dshot_command[14:0], 1'b0 };
						  	state <= INIT_TIME;
						end
					end
					else
						counter_low <= counter_low - 1'b1;
					
				end
				IDLE_: begin
				 if (guard_count) 
				 	guard_count <= guard_count -1'b1;
				end
		
				default: pwm <= 0;
			endcase
		
		end
	end
	
end
assign o_pwm = pwm;

endmodule
//END of modules

