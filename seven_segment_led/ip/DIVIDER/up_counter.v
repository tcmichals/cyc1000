

module up_counter( i_clk,
					 o_expired);
					 
parameter COUNT=100000000;
parameter WIDTH=32;

input wire i_clk;
output wire o_expired;

/* local parameters */
reg [WIDTH-1:0] counter;
wire expired= counter==COUNT;

initial counter = 0;

always @(posedge i_clk) 
begin
	if (counter == COUNT)
		counter <= 0;
	else
		counter <= counter+1;

end

assign o_expired = expired;
					 
endmodule
					 
					 