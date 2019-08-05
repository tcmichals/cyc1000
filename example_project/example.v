

module example(input wire CLK12M,
					input wire USER_BTN,
									/* accelerometer */
					input wire SEN_INT1,
					input wire SEN_INT2,
					input wire SEN_SDI,
					input wire SEN_SDO,
					input wire SEN_SPC,
					input wire SEN_CS,
									//FTDI serial port Async RS232
					output wire			BDBUS0,   	//FSDI
					output wire			BDBUS1,  	//CLK
					input wire			BDBUS2,   //FSDO 
					input wire			BDBUS3,    //FSCTS
					output wire			BDBUS4,    //DTR
					input wire			BDBUS5,    //DSR
					output wire			AIN0, 
					output wire			AIN1,
					output wire			AIN2,
					output wire			AIN3,
					output wire			AIN4,
					output wire			AIN5,
					output wire			AIN6,
					output wire			[7:0]LED,
					output wire			D0,D1,D2,D3,D4,D5);


wire o_CLK12;

reg [7:0]tx_data;
wire [7:0]rx_data;
reg tx_write;
wire tx_busy;
wire rx_ready;
wire o_in_bytes_stream_ready;


reg r_reset;
reg [31:0]reset_count;
localparam RESET_COUNT = 32'hFFF;


assign AIN2 = tx_data[3];
assign AIN3 = tx_data[4];
assign AIN4 = tx_data[5];
assign AIN5 = tx_data[6];
assign AIN6 = tx_write;
assign D0= tx_busy;



initial begin
	reset_count = 0;
	r_reset = 0;
end

always @(posedge o_CLK12) begin

	if (reset_count != RESET_COUNT ) begin
		reset_count<= reset_count + 2'b1;
		r_reset = 1'b0;
		end
	else
		r_reset = 1'b1;
end


PLL12M	PLL12M_inst (
	.inclk0 ( CLK12M ),
	.c0 ( o_CLK12 )
	);


	
clock_fastserial clock_for_fastserial(.i_clk(o_CLK12), 
												.o_fsclk(BDBUS1));

rx_fastserial rx_lite(.i_clk(o_CLK12),
								.i_fsdo(BDBUS2),
								.i_fsclk(BDBUS1),
							   .o_data(rx_data),
								.o_ready(rx_ready),
								.o_debug_0(),
								.o_debug_1(),
								.o_debug_2());
								
tx_fastserial tx_lite(.i_clk(o_CLK12),
							.i_fsclk(BDBUS1),
							.i_fscts(BDBUS3),
							.i_data(tx_data),
							.i_write(tx_write),
							.o_busy(tx_busy),
							.o_fsdi(BDBUS0), 
							.o_debug_0());
						

    led_example u0 (
        .bytes_to_packets_in_bytes_stream_ready  (o_in_bytes_stream_ready),  //  bytes_to_packets_in_bytes_stream.ready
        .bytes_to_packets_in_bytes_stream_valid  (rx_ready),  //                                  .valid
        .bytes_to_packets_in_bytes_stream_data   (rx_data),   //                                  .data
        .clk_clk                                 (o_CLK12),                                 //                               clk.clk
        .packets_to_bytes_out_bytes_stream_ready (!tx_busy), // packets_to_bytes_out_bytes_stream.ready
        .packets_to_bytes_out_bytes_stream_valid (tx_write), //                                  .valid
        .packets_to_bytes_out_bytes_stream_data  (tx_data),  //                                  .data
        .reset_reset_n                           (r_reset),                           //                             reset.reset_n
        .simple_leds_leds                        (LED),
        .blinkt_led_serial_serial_clk            (AIN0),            //                 blinkt_led_serial.serial_clk
        .blinkt_led_serial_serial_data           (AIN1)  		  //                       simple_leds.leds
    );

	 
					



	

							
endmodule
