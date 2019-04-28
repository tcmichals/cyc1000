
module clock_fastserial(i_clk, 
                     o_fsclk);

input wire          i_clk;           //FPGA Clock, atleast 100Mhz
output wire         o_fsclk;          // IF TX is busy

reg fsclk;

always @(posedge i_clk) begin
    fsclk <= ~fsclk;
end	 

assign o_fsclk = fsclk;

endmodule
//eof
