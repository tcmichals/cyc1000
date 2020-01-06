

`default_nettype 	none

module packet_processor( i_clck, 
								 i_reset,
								
								 o_rx_pkt
								 o_rx_cnt
								 
								  );
									 
/* arguements */
input wire i_clk;
input wire i_reset;

									 


	/* packet pool */
	reg [1:0] ping_pong_rx;
	reg [7:0] rx_index;
	reg [7:0] pool_rx_0[127:0];


	reg [1:0] ping_pong_rx;
	reg [7:0] rx_index;	
	reg [7:0] pool_tx_0[127:0];


endmodule

//eof