


module picorv32_fast_serial(input CLK12M,
									output [7:0] LED);


reg reset_pll;
reg reset_crg;
wire lock_pll;

reg [15:0] reset_counter;	
wire CLK0;
wire CLK1_180;

initial begin
	reset_pll = 0;
	reset_counter = 4'hFFFF;
end

PLL12M	PLL12M_inst (
	.areset ( reset_crg ),
	.inclk0 ( CLK12M ),
	.c0 ( CLK0 ),
	.c1 ( CLK1_180 ),
	.locked ( lock_pll )
	);
	

always @(posedge CLK0) begin
	if (reset_counter!=0) begin
		reset_counter <= reset_counter - 1;
		reset_crg <= 1;
	end
	else begin
		reset_crg <= 0;
	end
	
end

picorv32_soc soc(CLK0, reset_crg, LED);



endmodule
