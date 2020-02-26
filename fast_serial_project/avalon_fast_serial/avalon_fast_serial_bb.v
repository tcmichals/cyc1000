
module avalon_fast_serial (
	clk_clk,
	in_bytes_stream_ready,
	in_bytes_stream_valid,
	in_bytes_stream_data,
	out_bytes_stream_ready,
	out_bytes_stream_valid,
	out_bytes_stream_data,
	reset_reset_n,
	led_gpio_led);	

	input		clk_clk;
	output		in_bytes_stream_ready;
	input		in_bytes_stream_valid;
	input	[7:0]	in_bytes_stream_data;
	input		out_bytes_stream_ready;
	output		out_bytes_stream_valid;
	output	[7:0]	out_bytes_stream_data;
	input		reset_reset_n;
	output	[7:0]	led_gpio_led;
endmodule
