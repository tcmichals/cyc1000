module debouncer(
    input CLK,
    input switch_input,
    output reg state,
    output trans_up,
    output trans_dn
    );
    parameter TIMEOUT_WIDTH=3;

// Synchronize the switch input to the clock
reg sync_0, sync_1;
always @(posedge CLK) 
begin
  sync_0 <= switch_input;
end
	
always @(posedge CLK) 
begin
  sync_1 <= sync_0; 
end

// Debounce the switch
reg [(TIMEOUT_WIDTH-1):0] count;
wire idle = (state == sync_1);
wire finished = &count;	// true when all bits of count are 1's

always @(posedge CLK)
begin
  if (idle)
  begin
    count <= 0;
  end
  else 
  begin
    count <= count + 1;  
    if (finished)
    begin
      state <= ~state;  
    end
  end
end

assign trans_dn = ~idle & finished & ~state;
assign trans_up = ~idle & finished & state;

endmodule
