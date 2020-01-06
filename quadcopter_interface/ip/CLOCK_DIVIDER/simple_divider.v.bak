`default_nettype 	none

module simple_divider( input wire i_clk,
							  input i_reset,
							  input  [23:0] maxCount,
							  output o_clk);
							  


reg [31:0] counter;
wire [31:0] r_next;
reg div_clk;

initial div_clk =0;
initial counter = 0;

always @(posedge i_reset or posedge i_clk)
begin 
	if (i_reset) begin
		counter <= 'b0;
		div_clk <= 0;
	end
	else if (r_next == maxCount) begin
			counter <=0;
			div_clk <= ~div_clk;
		end
	else begin
			counter <= r_next;
	end
end	

assign r_next = counter + 1;
assign o_clk = div_clk;	
endmodule

