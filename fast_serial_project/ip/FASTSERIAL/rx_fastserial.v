

module rx_fastserial(i_clk, 
                     i_fsdo,
		     i_fsclk,
                     o_data,
                     o_ready);

              


input wire          	i_clk;           //FPGA Clock, atleast 100Mhz
input wire          	i_fsdo;         //No faster then 50Mhz
input wire         	i_fsclk;          // IF TX is busy
output wire [7:0]    o_data;          // Data to TX
output wire          o_ready;         // Start Transmitting

<<<<<<< HEAD
	// Define several states
=======
// Define several states
>>>>>>> 7b0704c901cebfc77cf10ea5a4acdae4db390414
localparam [3:0]    WAIT_FOR_START_BIT	= 4'h0,
	                BIT_ZERO	    = 4'h1,
	                BIT_ONE		    = 4'h2,
	                BIT_TWO	        = 4'h3,
	                BIT_THREE	    = 4'h4,
                    BIT_FOUR        = 4'h5,
	                BIT_FIVE	    = 4'h6,
	                BIT_SIX		    = 4'h7,
	                BIT_SEVEN	    = 4'h8,
	                BIT_DEST	    = 4'h9,
                    DONE            = 4'hA,
	                IDLE		    = 4'hf;

reg [3:0] state;
reg [7:0] rx_data;
reg rx_ready;
reg q_fsdo, d_fsdo;


initial state = WAIT_FOR_START_BIT;
initial rx_ready = 0;
initial q_fsdo = 1;
initial d_fsdo =1;

always @(posedge i_clk) begin
	if (i_fsclk) begin
		{ q_fsdo, d_fsdo} <= { d_fsdo, i_fsdo};
<<<<<<< HEAD
=======

>>>>>>> 7b0704c901cebfc77cf10ea5a4acdae4db390414
	end
end	 

always @(posedge i_clk) begin

	if (i_fsclk) begin
	
		case (state)
			WAIT_FOR_START_BIT: begin

				if (q_fsdo == 0) begin
					state <= BIT_ZERO;
				end
			end
			BIT_DEST: begin
				rx_ready <= 1;
				state <= state +1;
			end
			
			DONE: begin
				state <= WAIT_FOR_START_BIT;
				rx_ready <= 0;
			end
			
			default: begin
				if (state >= BIT_ZERO && state <= BIT_SEVEN) begin
					state <= state + 1;
					{rx_data }<= {rx_data[6:0], q_fsdo};
				end
			end
			endcase
	end
end

assign o_ready = rx_ready;
assign o_data = rx_data;
<<<<<<< HEAD
=======

>>>>>>> 7b0704c901cebfc77cf10ea5a4acdae4db390414

endmodule
//eof
