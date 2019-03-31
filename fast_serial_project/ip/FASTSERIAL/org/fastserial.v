

`default_nettype 	none


module fastserial(i_clk, 
                  i_fsclk, 
                  i_fscts,
                  i_data,
                  i_write,
                  o_busy,
                  o_fsdi);
						  
parameter	[1:0]	CLOCKS_PER = 2'd2;                    
parameter	DEST_PORT = 1'd1;  

input wire          i_clk;           //FPGA Clock, atleast 100Mhz
input wire          i_fsclk;         //No faster then 50Mhz
input wire          i_fscts;         // Low, if cannot transmit, Hi, can send
input wire [7:0]    i_data;          // Data to TX
input wire          i_write;         // Start Transmitting
output wire         o_busy;          // IF TX is busy
output wire         o_fsdi;          //Tx out						  




endmodule

//eof
