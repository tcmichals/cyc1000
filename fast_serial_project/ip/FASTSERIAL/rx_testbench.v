`default_nettype none

module rx_testbench(i_clk, i_fsdo);

input wire i_clk;
input wire i_fsdo;

wire [7:0] rx_data;
wire rx_data_ready;
wire fsclk;



rx_fastserial rx(i_clk, i_fsdo, rx_data, rx_data_ready, fsclk);


endmodule
//eof
