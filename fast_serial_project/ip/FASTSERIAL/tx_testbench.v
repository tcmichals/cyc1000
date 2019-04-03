
`default_nettype none



module tx_testbench(i_clk, i_fscts, o_fsdi, o_fsclk);

/* inputs/ ouputs/ parameters */
input wire i_clk;
input wire i_fscts;
output wire o_fsdi;
output wire o_fsclk;


localparam TX_COUNT =1;
/* local values */
reg [7:0] tx_data;
reg tx_write; 
reg [7:0] tx_write_count;
wire tx_busy;
reg fsclk;


initial tx_write = 0;
initial tx_write_count = 0;
initial tx_data = "0";


 clock_fastserial clock_for_fastserial(.i_clk(i_clk), 
										.o_fsclk(fsclk));

tx_fastserial tx_lite(  .i_clk(i_clk),
					    .i_fsclk(fsclk),
						.i_fscts(i_fscts),
						.i_data(tx_data),
						.i_write(tx_write),
						.o_busy(tx_busy),
						.o_fsdi(o_fsdi));

always @(posedge i_clk) begin
    if ( !tx_busy && !tx_write && tx_write_count!=TX_COUNT) begin
        tx_data <= "0";
        tx_write <= 1;
        tx_write_count <= tx_write_count + 1;
    end
end

assign o_fsclk = fsclk;

endmodule
//eof