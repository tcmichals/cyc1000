// pwm_dshot.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module pwm_dshot #(
		parameter motors_supported = 4
	) (
		input  wire [2:0]  avs_s0_address,     //      avs_s0.address
		input  wire        avs_s0_write,       //            .write
		input  wire [31:0] avs_s0_writedata,   //            .writedata
		output wire        avs_s0_waitrequest, //            .waitrequest
		input  wire        avs_s0_chipselect,  //            .chipselect
		input  wire        clock_clk,          //       clock.clk
		input  wire        reset_reset,        //       reset.reset
		output wire        motor_1,            // motor_block.motor_1
		output wire        motor_2,            //            .motor_2
		output wire        motor_3,            //            .motor_3
		output wire        motor_4             //            .motor_4
	);

	// TODO: Auto-generated HDL template
localparam MOTOR_1=0;
localparam MOTOR_2=1;
localparam MOTOR_3=2;
localparam MOTOR_4=3;

	
localparam USE_PWM_2MS	 = 32'h1;
localparam USE_DSHOT_600 = 32'h2;
reg [15:0] motor_high;
reg [15:0] motor_low;

reg motor_1_write;
reg motor_2_write;
reg motor_3_write;
reg motor_4_write;
	
initial begin
	motor_high = 0;
	motor_low = 0;
end	

assign avs_s0_waitrequest= 0;

pwm_output motor_out_1(.i_clk(clock_clk),
						.i_reset(reset_reset),
						.i_pwm_low_value(motor_low),
						.i_pwm_high_value(motor_high),
						.i_write(motor_1_write),
						.o_pwm(motor_1));
			
pwm_output motor_out_2(.i_clk(clock_clk),
						.i_reset(reset_reset),
						.i_pwm_low_value(motor_low),
						.i_pwm_high_value(motor_high),
						.i_write(motor_2_write),
						.o_pwm(motor_2));
			
pwm_output motor_out_3(.i_clk(clock_clk),
						.i_reset(reset_reset),
						.i_pwm_low_value(motor_low),
						.i_pwm_high_value(motor_high),
						.i_write(motor_3_write),
						.o_pwm(motor_3));
			
pwm_output motor_out_4(.i_clk(clock_clk),
						.i_reset(reset_reset),
						.i_pwm_low_value(motor_low),
						.i_pwm_high_value(motor_high),
						.i_write(motor_4_write),
						.o_pwm(motor_4));			
						
always @(posedge clock_clk or posedge reset_reset) begin	

	if (reset_reset) begin
			motor_1_write <= 0;
			motor_2_write <= 0;
			motor_3_write <= 0;
			motor_4_write <= 0;
			motor_high <= 0;
			motor_low <= 0;
		end
	else begin
		if (avs_s0_chipselect==1 && avs_s0_write==1) begin
				motor_low <= avs_s0_writedata;
				motor_high <= avs_s0_writedata[31:16];
				case (avs_s0_address)
					MOTOR_1:	motor_1_write <= 1;
					MOTOR_2: motor_2_write <= 1;
					MOTOR_3: motor_3_write <= 1;
					MOTOR_4: motor_4_write <= 1;
					default: begin end
				endcase
		end
		else begin
			motor_1_write <= 0;
			motor_2_write <= 0;
			motor_3_write <= 0;
			motor_4_write <= 0;
		end
	 end
	end

endmodule
