


module rx_fastserial(i_reset,
                    i_clk, 
                    i_fsdi,
                    o_data,
                    o_rxready,
                    o_fsclk
                    );
 
input wire          i_reset;
input wire          i_clk;           //FPGA Clock, atleast 100Mhz
input wire          i_fsdi;
output wire [7:0]    o_data;          // RX Data 
output wire         o_rxready;       //RX data is ready
output wire         o_fsclk;         // fsclk output

reg d_rx_line;
reg q_rx_line;
reg clk_2x_divider;

always @(posedge i_clk) begin
    clk_2x_divider <= ~clk_2x_divider;
end

always @(posedge i_clk) begin

    if (clk_2x_divider) begin
        // This samples the input anc clocks it it at each 100Mhz clock
        { q_rx_line, d_rx_line} <= {d_rx_line, i_fsdi };
    end
end



assign o_fsclk = clk_2x_divider;


endmodule

//eof

