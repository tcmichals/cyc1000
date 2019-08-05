

module serial_tx( input wire i_reset, 
						input wire i_start, 
						input wire i_clk, 
						input wire [DATA_WIDTH-1:0] i_data, 
						input	wire [7:0] i_num_bits,
						output wire o_busy,
						output wire o_serial_data,
						output wire o_serial_clock);
parameter DATA_WIDTH	= 32;	// Datawidth


reg [5:0] state;
reg [DATA_WIDTH-1:0] serial_data;
reg [7:0] num_bits;
reg serial_clk;
reg i_sclk_reset;
wire o_sclk;

localparam IDLE = 	6'b0;
localparam DONE = 	6'h21;
localparam START = 	6'h1;


initial begin
	state = IDLE;
	serial_data = 0;
	serial_clk = 0;
	i_sclk_reset = 1;
end

assign o_serial_data = (state!=IDLE)?serial_data[DATA_WIDTH-1]:1'b0;
assign o_busy = (state != IDLE)?1'b1:1'b0;
assign o_serial_clock = (state!=IDLE)?serial_clk:1'b0;


 simple_divider sclk_divider( .i_clk (i_clk),
							.i_reset(i_sclk_reset),
							.maxCount (10),
							.o_clk (o_sclk));
							
always @(posedge i_clk or posedge i_reset) begin

	if (i_reset) begin
		state <= IDLE;
		serial_data <= 0;
		i_sclk_reset <= 0;
		num_bits <= 0;
	end
	else begin
		if (i_start==1) begin
			state <= START;
			serial_data <= { i_data };
			serial_clk <= 0;
			i_sclk_reset <= 0;
			num_bits <= i_num_bits;
			$display("serial_tx: start and clean clock");
		end
		else begin
			i_sclk_reset <= 1;
		end

		case (state)
			IDLE: begin /* do nothing */
				i_sclk_reset <= 1;
			end
			
			DONE: begin
				if (!o_sclk) begin
					$display("serial_tx:DONE");
					state <= IDLE;
					i_sclk_reset <= 1;
				end
			end
	
			default begin
				if ( num_bits > 0) begin
				
					if (o_sclk & !serial_clk) begin
						num_bits<=  num_bits -1;
						serial_clk <= o_sclk;
						$display("serial_tx:send data state=%d", state);
					end
					else if (!o_sclk & serial_clk) begin
						serial_clk <= o_sclk;
						serial_data <= { serial_data[DATA_WIDTH-2:0], 1'b0};
						$display("serial_tx:LOW state=%d", state);
					end else begin end
				end else begin
					state <= DONE;
				end
			end
		endcase
	end

end

endmodule
