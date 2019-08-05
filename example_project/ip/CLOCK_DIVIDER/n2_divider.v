`default_nettype 	none

module n2_divider(i_reset, i_clk,
						o_clk);
							  
input wire i_reset;
input wire i_clk;
output o_clk;
parameter DIVISOR = 31'd2;
reg [31:0] counter;

initial counter = 0;

always @(posedge i_reset or posedge i_clk)
begin 
	if (i_reset) begin
		//counter <= 'b0;
		end
	else begin
		counter <= counter +1;
		if (counter == (DIVISOR-1)) begin
			counter <=0;
		end
	end
end	

assign o_clk = (counter<DIVISOR/2)?1'b0:1'b1;

endmodule

