`default_nettype 	none

module simple_divider( input wire i_clk,
							  input i_reset,
							  input  [23:0] maxCount,
							  output wire o_clk);
							  


reg div_clk;
reg [32:0] counter;
initial div_clk =0;
initial counter = 0;

always @(posedge i_clk,  posedge i_reset)
begin 
	if (i_reset) 
		begin
			counter <= 'b0;
			div_clk <= 'b0;
		end
	else
		begin
			if (counter == maxCount) 
			begin
				counter <= 'b0;
				div_clk <= 1'b1;
			end 
			else 
				begin
					counter <= counter + 1;
					div_clk <= 1'b0;
				end
		end
end	

assign o_clk = div_clk;	
 							  
endmodule

