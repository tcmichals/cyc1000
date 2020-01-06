/*



FTDI fast serial tx  for FTDI

FSCLK - input into 
FSDI - Data In, TX input pin, default high 
FSCT - Clear to Send.  High if ready to send.
From Data Sheet: 4.8.2 
Notes :-
4.8.2 Incoming Fast Serial Data
An external device is allowed to send data into the FT2232H if FSCTS is high. On receipt of a zero START
bit on FSDI, the FT2232H will drop FSCTS on the next positive clock edge. The data from bits 0 to 7 are
then clocked in (LSB first). The last bit (DEST) determines where the data will be written to. The data can
be sent to either channel A or to channel B. If DEST= ‘0’, the data is sent to channel A, (assuming
channel A is enabled for fast serial mode, otherwise the data is sent to channel B). If DEST= ‘1’ the data
is sent to channel B, (assuming channel B is enabled for fast serial mode, otherwise the data will go to
channel A. (Either channel A, channel B or both channels must be enabled as fast serial mode or the
function is disabled). This is illustrated in Figure 4.15.

1. The first bit input (Start bit) is always 0.
2. FSDI is always received LSB first.
3. The last received serial bit is the destination bit (DEST).It indicates which channel the data should
go to. A ‘0’ means that it should go to channel A, a ‘1’ means that it should go to channel B.
4. The target device should ensure that CTS is high before it sends data. CTS goes low after data bit
0 (D0) and stays low until the chip can accept more data.



Serial data stream:

Start Bit | DO | D1 | D2 | D3 | D4 | D5 | D6 | D7 | DEST |

Start Bit is low.  DEST is 1, for Port B .. 
*/

module tx_fastserial(i_clk, 
                    i_fsclk, 
                    i_fscts,
                    i_data,
                    i_write,
                    o_busy,
                    o_fsdi,
						  o_debug_0);

parameter	[1:0]	CLOCKS_PER = 2'd2;                    
parameter	DEST_PORT = 1'd1;  

input wire          i_clk;           //FPGA Clock, atleast 100Mhz
input wire          i_fsclk;         //No faster then 50Mhz
input wire          i_fscts;         // Low, if cannot transmit, Hi, can send
input wire [7:0]    i_data;          // Data to TX
input wire          i_write;         // Start Transmitting
output wire         o_busy;          // IF TX is busy
output wire         o_fsdi;          //Tx out
output wire			  o_debug_0;


	// Define several states
localparam [3:0]  START	      	= 4'h0,
	               WAIT_FOR_FCTS	= 4'h1,
	               BIT_ZERO			= 4'h2,
	               BIT_ONE			= 4'h3,
	               BIT_TWO	   	= 4'h4,
	               BIT_THREE		= 4'h5,
                  BIT_FOUR   		= 4'h6,
	               BIT_FIVE   		= 4'h7,
	               BIT_SIX			= 4'h8,
	               BIT_SEVEN		= 4'h9,
	               BIT_DEST			= 4'hA,
                  DONE      		= 4'hB,
	               IDLE	    		= 4'hf;

reg	[3:0]	state;
reg	[7:0]	lcl_data;
reg   q_fscts, d_fscts;
reg	busy;
reg	fsdi;
reg   debug_0;

initial	busy = 1'b0;
initial	state  = IDLE;
initial	lcl_data = 8'hff;
initial  fsdi = 1;
initial  q_fscts = 1;
initial debug_0 = 0;

/* use combinational logic  to get i_fscts*/
always @(*) begin
	d_fscts = i_fscts;
end

always @(posedge i_clk) begin
	q_fscts <= d_fscts;

	if ( (i_write) && (!busy)) begin
			// Immediately start us off with a start bit
			{ busy, state } <= { 1'b1, START };
	      lcl_data <= i_data;
    end
	 
	case (state)
		IDLE: begin  fsdi <= 1; end /* keep high */
					
      START: begin
			if (q_fscts && i_fsclk) begin
				/* send start bit 0 */
				fsdi <= 0;
	      state <= BIT_ZERO;
			end
		end
		
      WAIT_FOR_FCTS: begin
     /* wait for FSCTS to drop then start sending data */
    	if ( !q_fscts && i_fsclk) begin
				state <= state +1;
				
          end
       end    

       BIT_DEST: begin
				if ( !q_fscts && i_fsclk) begin
					fsdi <= DEST_PORT;
					state <= state +1;
					debug_0 <= ~debug_0;
				end
       end

       DONE: begin 
				if ( !q_fscts && i_fsclk) begin
					lcl_data <= 8'hff;
					{ busy, state } <= { 1'b0, IDLE };
					debug_0 <= 0;
           end 
        end

        default: begin
				if ( state >= BIT_ZERO && state <= BIT_SEVEN) begin
				/* wait for FSCTS to drop then start sending data */
					if ( i_fsclk) begin
						state <= state +1;
						fsdi <= lcl_data[0];
                  lcl_data <= { 1'b1, lcl_data[7:1] };
						debug_0 <= ~debug_0;
					end 
				end
			end
         endcase

end //always end

	 

assign o_busy = busy;
assign o_fsdi = fsdi;

assign o_debug_0 = debug_0;

endmodule
//eof
