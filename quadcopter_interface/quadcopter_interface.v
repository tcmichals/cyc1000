`default_nettype none
`timescale 1 ns / 1 ns


module quadcopter_interface(CLK12M, 
								USER_BTN,
									/* accelerometer */
								SEN_INT1,
								SEN_INT2,
								SEN_SDI,
								SEN_SDO,
								SEN_SPC,
								SEN_CS,
									//FTDI serial port Async RS232
								BDBUS0,   	//FSDI
								BDBUS1,  	//RX
								BDBUS2,   //FSDO 
								BDBUS3,    //FSCTS
								BDBUS4,    //DTR
								BDBUS5,    //DSR
								AIN0, 
								AIN1,
								AIN2,
								AIN3,
								AIN4,
								AIN5,
								AIN6,
								LED,
								D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11);

input wire CLK12M;
input wire USER_BTN;

input wire SEN_INT1;
input wire SEN_INT2;
input wire SEN_SDI;
input wire SEN_SDO;
input wire SEN_SPC;
input wire SEN_CS;
//FTDI serial port Async RS232
output wire BDBUS0;   //FSDI
output wire BDBUS1;  //FSCLK
input wire BDBUS2;   //FSDO 
input wire BDBUS3;    //FSCTS
output wire BDBUS4;   //DTR
input wire BDBUS5;    //DSR	

output wire AIN0;
output wire AIN1;
output wire AIN2;
output wire AIN3;
output wire AIN4;
output wire AIN5;
output wire AIN6;
output wire [7:0]LED;
output wire D0,D1,D2,D3,D4,D5;
input wire D6,D7,D8,D9,D10,D11;

wire CLK_0;
wire CLK_1;
wire r_reset;


reg [7:0]tx_data;
wire [7:0]rx_data;
reg tx_write;
wire tx_busy;
wire rx_ready;
wire o_in_bytes_stream_ready;

assign D5 = BDBUS0;
assign D4 = BDBUS2;
initial tx_data = "0";
initial tx_write = 0;


/*
CLK_0 is 50MHz
CLK_1 is 100Mhz
*/
PLL12M	PLL12M_inst (.areset (  ),
							.inclk0 ( CLK12M ),
							.c0 ( CLK_0 ),
							.c1 ( CLK_1 ));
							
clock_fastserial clock_for_fastserial(.i_clk(CLK_0), 
												.o_fsclk(BDBUS1));

rx_fastserial rx_lite(.i_clk(CLK_0),
								.i_fsdo(BDBUS2),
								.i_fsclk(BDBUS1),
							   .o_data(rx_data),
								.o_ready(rx_ready));
								
tx_fastserial tx_lite(.i_clk(CLK_0),
							.i_fsclk(BDBUS1),
							.i_fscts(BDBUS3),
							.i_data(tx_data),
							.i_write(tx_write),
							.o_busy(tx_busy),
							.o_fsdi(BDBUS0), 
							.o_debug_0());



avalonBus u0 (
        .ap102_led_outputs_sclk (AIN0), 							// ap102_led_0_led_block.sclk
        .ap102_led_outputs_sdo  (AIN1),  						// .sdo
        .clk_clk                    (CLK_0),               //  clk.clk
		  .gpio_led_outputs_led_0    (LED[0]),    //    gpio_led_outputs.led_0
        .gpio_led_outputs_led_1    (LED[1]),    //                    .led_1
        .gpio_led_outputs_led_2    (LED[2]),    //                    .led_2
        .gpio_led_outputs_led_3    (LED[3]),    //                    .led_3
		  .gpio_led_outputs_led_4    (LED[4]),    //                    .led_4
		  .gpio_led_outputs_led_5    (LED[5]),    //                    .led_5
		  .gpio_led_outputs_led_6    (LED[6]),    //                    .led_6
		  .gpio_led_outputs_led_7    (LED[7]),    //                    .led_7		  
        .in_bytes_stream_ready      (o_in_bytes_stream_ready), // in_bytes_stream.ready
        .in_bytes_stream_valid      (rx_ready),      				//  .valid
        .in_bytes_stream_data       (rx_data),       				//  .data
        .out_bytes_stream_ready     (!tx_busy),     				//  out_bytes_stream.ready
        .out_bytes_stream_valid     (tx_write),     				//   .valid
        .out_bytes_stream_data      (tx_data),      				//   .data
		  .pwm_decoder_inputs_pwm_1 (D6), // pwm_decoder_inputs.pwm_1
        .pwm_decoder_inputs_pwm_2 (D7), //                   .pwm_2
        .pwm_decoder_inputs_pwm_3 (D8), //                   .pwm_3
        .pwm_decoder_inputs_pwm_4 (D9), //                   .pwm_4
        .pwm_decoder_inputs_pwm_5 (D10), //                   .pwm_5
        .pwm_decoder_inputs_pwm_6 (D11), //                   .pwm_6
		  /*.pwm_decoder_inputs_debug_0(AIN2),*/

		  .pwm_dshot_motors_motor_1   (AIN2),   //   pwm_dshot_motors.motor_1
        .pwm_dshot_motors_motor_2   (AIN3),   //                   .motor_2
        .pwm_dshot_motors_motor_3   (AIN4),   //                   .motor_3
        .pwm_dshot_motors_motor_4   (AIN5),
		  .reset_reset_n              (r_reset),               	//    reset.reset_n

    );

reg [31:0] reset_count;
reg reset_reg;
assign r_reset = reset_reg;
initial reset_count = 0;
initial reset_reg = 0;
localparam RESET_COUNT = 32'hFFF;

always @(posedge CLK_0) begin

	if (reset_count != RESET_COUNT ) begin
		reset_count<= reset_count + 1'b1;
		reset_reg <= 1'b0;
		end
	else begin
		reset_reg <= 1'b1;
	end
end	
	


endmodule
