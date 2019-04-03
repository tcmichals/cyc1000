`default_nettype none

module rx_testbench(i_clk, i_fsdo);

input wire i_clk;
input wire i_fsdo;

localparam RX_DATA_CHK ="0";

wire [7:0] rx_data;
wire rx_ready;
wire fsclk;


clock_fastserial clock_for_fastserial(.i_clk(i_clk), 
									  .o_fsclk(fsclk));

rx_fastserial rx_lite(  .i_clk(i_clk),
					    .i_fsdo(i_fsdo),
						.i_fsclk(fsclk),
						.o_data(rx_data),
						.o_ready(rx_ready));

always @(posedge i_clk) begin
    if ( rx_ready ) begin
            assert (RX_DATA_CHK == rx_data)  $display ("OK. A equals B");
    end
end

endmodule
//eof
