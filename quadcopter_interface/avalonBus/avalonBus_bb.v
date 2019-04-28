
module avalonBus (
	clk_clk,
	reset_reset_n,
	in_bytes_stream_ready,
	in_bytes_stream_valid,
	in_bytes_stream_data,
	out_bytes_stream_ready,
	out_bytes_stream_valid,
	out_bytes_stream_data);	

	input		clk_clk;
	input		reset_reset_n;
	output		in_bytes_stream_ready;
	input		in_bytes_stream_valid;
	input	[7:0]	in_bytes_stream_data;
	input		out_bytes_stream_ready;
	output		out_bytes_stream_valid;
	output	[7:0]	out_bytes_stream_data;
endmodule
