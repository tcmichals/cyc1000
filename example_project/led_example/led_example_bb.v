
module led_example (
	bytes_to_packets_in_bytes_stream_ready,
	bytes_to_packets_in_bytes_stream_valid,
	bytes_to_packets_in_bytes_stream_data,
	clk_clk,
	packets_to_bytes_out_bytes_stream_ready,
	packets_to_bytes_out_bytes_stream_valid,
	packets_to_bytes_out_bytes_stream_data,
	reset_reset_n,
	simple_leds_leds,
	blinkt_led_serial_serial_clk,
	blinkt_led_serial_serial_data);	

	output		bytes_to_packets_in_bytes_stream_ready;
	input		bytes_to_packets_in_bytes_stream_valid;
	input	[7:0]	bytes_to_packets_in_bytes_stream_data;
	input		clk_clk;
	input		packets_to_bytes_out_bytes_stream_ready;
	output		packets_to_bytes_out_bytes_stream_valid;
	output	[7:0]	packets_to_bytes_out_bytes_stream_data;
	input		reset_reset_n;
	output	[7:0]	simple_leds_leds;
	output		blinkt_led_serial_serial_clk;
	output		blinkt_led_serial_serial_data;
endmodule
