// pwm_decoder.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module pwm_decoder #(
		parameter clockFrequency = 50000000
	) (
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		input  wire        pwm_input_1,        // conduit_end.pwm_1
		input  wire        pwm_input_2,        //            .pwm_2
		input  wire        pwm_input_3,        //            .pwm_3
		input  wire        pwm_input_4,        //            .pwm_4
		input  wire        pwm_input_5,        //            .pwm_5
		input  wire        pwm_input_6,        //            .pwm_6
		output wire        debug_0,            //            .debug_0
		input  wire [2:0]  avs_s0_address,     //      avs_s0.address
		input  wire        avs_s0_read,        //            .read
		output reg [31:0] avs_s0_readdata,    //            .readdata
		input  wire        avs_s0_write,       //            .write
		input  wire [31:0] avs_s0_writedata,   //            .writedata
		output reg        avs_s0_waitrequest  //            .waitrequest
	);

	// TODO: Auto-generated HDL template




	//assign avs_s0_waitrequest = 1'b0;
	/*
	assign avs_s0_readdata = 32'b00000000000000000000000000000000;
*/


localparam PWM_CLK_1MHZ = 50;

reg [31:0] pwm_count_1;
reg [15:0] pwm_on_time_1;
reg [15:0] pwm_off_time_1;
reg pwm_status_1;

reg [31:0] pwm_count_2;
reg [15:0] pwm_on_time_2;
reg [15:0] pwm_off_time_2;
reg pwm_status_2;


reg [31:0] pwm_count_3;
reg [15:0] pwm_on_time_3;
reg [15:0] pwm_off_time_3;
reg pwm_status_3;

reg [31:0] pwm_count_4;
reg [15:0] pwm_on_time_4;
reg [15:0] pwm_off_time_4;
reg pwm_status_4;

reg [31:0] pwm_count_5;
reg [15:0] pwm_on_time_5;
reg [15:0] pwm_off_time_5;
reg pwm_status_5;

reg [31:0] pwm_count_6;
reg [15:0] pwm_on_time_6;
reg [15:0] pwm_off_time_6;
reg pwm_status_6;

reg [15:0] divider_clk;
reg clk;



localparam PWM_1_HIGH = 6'h1;
localparam PWM_2_HIGH = 6'h2;
localparam PWM_3_HIGH = 6'h4;
localparam PWM_4_HIGH = 6'h8;
localparam PWM_5_HIGH = 6'h10;
localparam PWM_6_HIGH = 6'h20;

localparam GUARD_ERROR 	= 16'h8000;
localparam MEASURING_ON = 1'b1;
localparam MEASURING_OFF = 1'b0;

localparam NO_ERROR = 16'h0;
localparam GUARD_TIME_ON = 16'h9C4; //2500
localparam GUARD_TIME_OFF = 16'h4E20; //20000



always @(posedge clock_clk or posedge reset_reset) begin

	if (reset_reset) begin
	
		divider_clk <= 0;
		avs_s0_waitrequest <= 0;
		
		pwm_count_1 <= 0;
		pwm_on_time_1 <= 0;
		pwm_off_time_1 <=0;
		pwm_status_1 <= MEASURING_OFF;
		
		pwm_count_2 <= 0;
		pwm_on_time_2 <= 0;
		pwm_off_time_2 <=0;
		pwm_status_2 <= MEASURING_OFF;

		pwm_count_3 <= 0;
		pwm_on_time_3 <= 0;
		pwm_off_time_3 <=0;
		pwm_status_3 <= MEASURING_OFF;
		
		pwm_count_4 <= 0;
		pwm_on_time_4 <= 0;
		pwm_off_time_4 <=0;
		pwm_status_4 <= MEASURING_OFF;
		
		pwm_count_5 <= 0;
		pwm_on_time_5 <= 0;
		pwm_off_time_5 <=0;
		pwm_status_5 <= MEASURING_OFF;
		
		pwm_count_6 <= 0;
		pwm_on_time_6 <= 0;
		pwm_off_time_6 <=0;
		pwm_status_6 <= MEASURING_OFF;
		
		
	end
	else begin
	
		if (avs_s0_read) begin
			if (avs_s0_waitrequest ) begin
				case (avs_s0_address )
					0: avs_s0_readdata <= pwm_count_1;
					1: avs_s0_readdata <= pwm_count_2;
					2: avs_s0_readdata <= pwm_count_3;
					3: avs_s0_readdata <= pwm_count_4;
					4: avs_s0_readdata <= pwm_count_5;
					5: avs_s0_readdata <= pwm_count_6;
					default: avs_s0_readdata <= {16'h0000, pwm_on_time_1} ;
				endcase 
				avs_s0_waitrequest <= 0;
			end
			else
				avs_s0_waitrequest<=1;
		end
		
	/* up counter, once reached sample_pwm is high */
		if (divider_clk == PWM_CLK_1MHZ) begin
			divider_clk <= 0;
			
			/* 1 */
			if (pwm_input_1) begin
				if ( pwm_status_1 == MEASURING_OFF) begin
					pwm_on_time_1 <= 1;
					pwm_status_1 <= MEASURING_ON;
				end
				else begin
					pwm_off_time_1 <= 0;
					pwm_status_1 <= MEASURING_ON;
					if (pwm_on_time_1 < GUARD_TIME_ON)
						pwm_on_time_1 <= pwm_on_time_1 + 16'b1;
					else if (pwm_on_time_1 >= GUARD_TIME_ON) 
						pwm_count_1 <= {GUARD_ERROR | MEASURING_ON, NO_ERROR};
				end
			end
			else begin
				if ( pwm_status_1 & MEASURING_ON) begin
					pwm_count_1 <= {NO_ERROR | MEASURING_ON, pwm_on_time_1};
					pwm_off_time_1 <= 1;
					pwm_status_1 <= MEASURING_OFF;
				end
				else begin
					pwm_status_1 <= MEASURING_OFF;
					pwm_on_time_1 <= 0;
					if (pwm_off_time_1 < GUARD_TIME_OFF)
						pwm_off_time_1 <= pwm_off_time_1 +1;
					else if (pwm_off_time_1 >= GUARD_TIME_OFF) 
						pwm_count_1 <= {GUARD_ERROR | MEASURING_OFF, NO_ERROR};
				end
			end


			/* 2 */
			if (pwm_input_2) begin
				if ( pwm_status_2 == MEASURING_OFF) begin
					pwm_on_time_2 <= 1;
					pwm_status_2 <= MEASURING_ON;
				end
				else begin
					pwm_off_time_2 <= 0;
					pwm_status_2 <= MEASURING_ON;
					if (pwm_on_time_2 < GUARD_TIME_ON)
						pwm_on_time_2 <= pwm_on_time_2 + 16'b1;
					else if (pwm_on_time_2 >= GUARD_TIME_ON) 
						pwm_count_2 <= {GUARD_ERROR | MEASURING_ON, NO_ERROR};
				end
			end
			else begin
				if ( pwm_status_2 & MEASURING_ON) begin
					pwm_count_2 <= {NO_ERROR | MEASURING_ON, pwm_on_time_2};
					pwm_off_time_2 <= 1;
					pwm_status_2 <= MEASURING_OFF;
				end
				else begin
					pwm_status_2 <= MEASURING_OFF;
					pwm_on_time_2 <= 0;
					if (pwm_off_time_2 < GUARD_TIME_OFF)
						pwm_off_time_2 <= pwm_off_time_2 +1;
					else if (pwm_off_time_2 >= GUARD_TIME_OFF) 
						pwm_count_2 <= {GUARD_ERROR | MEASURING_OFF, NO_ERROR};
				end
			end		
		
			/* 3 */
			if (pwm_input_3) begin
				if ( pwm_status_3 == MEASURING_OFF) begin
					pwm_on_time_3 <= 1;
					pwm_status_3 <= MEASURING_ON;
				end
				else begin
					pwm_off_time_3 <= 0;
					pwm_status_3 <= MEASURING_ON;
					if (pwm_on_time_3 < GUARD_TIME_ON)
						pwm_on_time_3 <= pwm_on_time_3 + 16'b1;
					else if (pwm_on_time_3 >= GUARD_TIME_ON) 
						pwm_count_3 <= {GUARD_ERROR | MEASURING_ON, NO_ERROR};
				end
			end
			else begin
				if ( pwm_status_3 & MEASURING_ON) begin
					pwm_count_3 <= {NO_ERROR | MEASURING_ON, pwm_on_time_3};
					pwm_off_time_3 <= 1;
					pwm_status_3 <= MEASURING_OFF;
				end
				else begin
					pwm_status_3 <= MEASURING_OFF;
					pwm_on_time_3 <= 0;
					if (pwm_off_time_3 < GUARD_TIME_OFF)
						pwm_off_time_3 <= pwm_off_time_3 +1;
					else if (pwm_off_time_3 >= GUARD_TIME_OFF) 
						pwm_count_3 <= {GUARD_ERROR | MEASURING_OFF, NO_ERROR};
				end
			end	

			/* 4 */
			if (pwm_input_4) begin
				if ( pwm_status_4 == MEASURING_OFF) begin
					pwm_on_time_4 <= 1;
					pwm_status_4 <= MEASURING_ON;
				end
				else begin
					pwm_off_time_4 <= 0;
					pwm_status_4 <= MEASURING_ON;
					if (pwm_on_time_4 < GUARD_TIME_ON)
						pwm_on_time_4 <= pwm_on_time_4 + 16'b1;
					else if (pwm_on_time_4 >= GUARD_TIME_ON) 
						pwm_count_4 <= {GUARD_ERROR | MEASURING_ON, NO_ERROR};
				end
			end
			else begin
				if ( pwm_status_4 & MEASURING_ON) begin
					pwm_count_4 <= {NO_ERROR | MEASURING_ON, pwm_on_time_4};
					pwm_off_time_4 <= 1;
					pwm_status_4 <= MEASURING_OFF;
				end
				else begin
					pwm_status_4 <= MEASURING_OFF;
					pwm_on_time_4 <= 0;
					if (pwm_off_time_4 < GUARD_TIME_OFF)
						pwm_off_time_4 <= pwm_off_time_4 +1;
					else if (pwm_off_time_4 >= GUARD_TIME_OFF) 
						pwm_count_4 <= {GUARD_ERROR | MEASURING_OFF, NO_ERROR};
				end
			end

			/* 5 */
			if (pwm_input_5) begin
				clk <= 1;
				if ( pwm_status_5 == MEASURING_OFF) begin
					pwm_on_time_5 <= 1;
					pwm_status_5 <= MEASURING_ON;
				end
				else begin
					pwm_off_time_5 <= 0;
					pwm_status_5 <= MEASURING_ON;
					if (pwm_on_time_5 < GUARD_TIME_ON)
						pwm_on_time_5 <= pwm_on_time_5 + 16'b1;
					else if (pwm_on_time_5 >= GUARD_TIME_ON) 
						pwm_count_5 <= {GUARD_ERROR | MEASURING_ON, NO_ERROR};
				end
			end
			else begin
				clk <= 0;
				if ( pwm_status_5 & MEASURING_ON) begin
					pwm_count_5 <= {NO_ERROR | MEASURING_ON, pwm_on_time_5};
					pwm_off_time_5 <= 1;
					pwm_status_5 <= MEASURING_OFF;
				end
				else begin
					pwm_status_5 <= MEASURING_OFF;
					pwm_on_time_5 <= 0;
					if (pwm_off_time_5 < GUARD_TIME_OFF)
						pwm_off_time_5 <= pwm_off_time_5 +1;
					else if (pwm_off_time_5 >= GUARD_TIME_OFF) 
						pwm_count_5 <= {GUARD_ERROR | MEASURING_OFF, NO_ERROR};
				end
			end

			/* 6 */
			if (pwm_input_6) begin
				clk <= 1;
				if ( pwm_status_6 == MEASURING_OFF) begin
					pwm_on_time_6 <= 1;
					pwm_status_6 <= MEASURING_ON;
				end
				else begin
					pwm_off_time_6 <= 0;
					pwm_status_6 <= MEASURING_ON;
					if (pwm_on_time_6 < GUARD_TIME_ON)
						pwm_on_time_6 <= pwm_on_time_6 + 16'b1;
					else if (pwm_on_time_6 >= GUARD_TIME_ON) 
						pwm_count_6 <= {GUARD_ERROR | MEASURING_ON, NO_ERROR};
				end
			end
			else begin
				clk <= 0;
				if ( pwm_status_6 & MEASURING_ON) begin
					pwm_count_6 <= {NO_ERROR | MEASURING_ON, pwm_on_time_6};
					pwm_off_time_6 <= 1;
					pwm_status_6 <= MEASURING_OFF;
				end
				else begin
					pwm_status_6 <= MEASURING_OFF;
					pwm_on_time_6 <= 0;
					if (pwm_off_time_6 < GUARD_TIME_OFF)
						pwm_off_time_6 <= pwm_off_time_6 +1;
					else if (pwm_off_time_6 >= GUARD_TIME_OFF) 
						pwm_count_6 <= {GUARD_ERROR | MEASURING_OFF, NO_ERROR};
				end
			end
		end
		else begin
			divider_clk <= divider_clk + 1;
		end
	
	end
end	
	assign debug_0 = clk;


endmodule
