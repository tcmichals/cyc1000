`default_nettype none
`timescale 1 ns / 1 ns

module dhot_output #(
		parameter update_guardtime = 1000000, //1 second 
		parameter clockFrequency = 50000000
	) (
		input  wire        i_clk,          //       clock.clk
		input  wire        i_reset,        //       reset.reset
		input  wire [15:0] i_pwm_low_value,     //      avs_s0.address
		input  wire [15:0] i_pwm_high_value,
		input  wire        i_write,       //            .write
		output wire	   o_pwm
	);
	


/* state machine state of single bit */
localparam [3:0] INIT_TIME  = 4'h0,
		 		HIGH_TIME   = 4'h1,
	     		LOW_TIME    = 4'h2,
		 		IDLE_	    = 4'h3;
		
						 
//localparam [15:0] LOW_HIGH_TIME = 125;
//localparam [15:0] LOW_LOW_TIME = 209;

//localparam [15:0] HIGH_HIGH_TIME = 250;
//localparam [15:0] HIGH_LOW_TIME = 84;

localparam [15:0] LOW_HIGH_TIME = 117;
localparam [15:0] LOW_LOW_TIME = 215;

localparam [15:0] HIGH_HIGH_TIME = 232;
localparam [15:0] HIGH_LOW_TIME = 100;

/* number of bits to shift */
localparam [3:0] NUM_BIT_TO_SHIFT = 15;

reg [3:0] state;
reg [4:0] bits_to_shift;
reg [15:0] counter_high;
reg [15:0] counter_low;

reg [15:0] dshot_command;
reg bit;

reg pwm;


always @(posedge i_clk or posedge i_reset) begin	

	if (i_reset) begin
			state <= IDLE_;
			bits_to_shift <= 0;
			dshot_command <= 0;
			pwm <= 0;
	end
	else begin
		/* update pwm value */
		if (i_write) begin
			if (bits_to_shift == 0) begin		
				dshot_command <= i_pwm_low_value;
				bits_to_shift <= NUM_BIT_TO_SHIFT;
				bit <= dshot_command[15];
				state <= INIT_TIME;
				$display ("update %X", i_pwm_low_value);
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
						counter_high <= counter_high -1;

				end
				LOW_TIME: begin
					
					pwm <= 0;
					if (counter_low == 0) begin
						if ( bits_to_shift == 0) begin
							state = IDLE_;
							$display("DONE  Complete ");
						end
						else begin
							bits_to_shift <= bits_to_shift -1;
						  	dshot_command <= { dshot_command[14:0], 1'b0 };
						  	state <= INIT_TIME;
						end
					end
					else
						counter_low <= counter_low - 1;
					
				end
				IDLE_: begin
				end
		
				default: pwm <= 0;
			endcase
		
		end
	end
	
end
assign o_pwm = pwm;

endmodule
//END of modules

