

module quadcopter_interface(CLK12M, 
								USER_BTN,
									/* accelerometer */
								SEN_INT1,
								SEN_INT2,
								SEN_SDI,
								SEN_SDO,
								SEN_SPC,
								SEN_CS,
									//FTDI serial port Async RS232
								BDBUS0,   	//FSDI
								BDBUS1,  	//RX
								BDBUS2,   //FSDO 
								BDBUS3,    //FSCTS
								BDBUS4,    //DTR
								BDBUS5,    //DSR
								AIN0, 
								AIN1,
								AIN2,
								AIN3,
								AIN4,
								AIN5,
								AIN6,
								LED,
								D0,D1,D2,D3, D4,D5);

input wire CLK12M;
input wire USER_BTN;

input wire SEN_INT1;
input wire SEN_INT2;
input wire SEN_SDI;
input wire SEN_SDO;
input wire SEN_SPC;
input wire SEN_CS;
//FTDI serial port Async RS232
output wire BDBUS0;   //FSDI
output wire BDBUS1;  //FSCLK
input wire BDBUS2;   //FSDO 
input wire BDBUS3;    //FSCTS
output wire BDBUS4;   //DTR
input wire BDBUS5;    //DSR	

output wire AIN0;
output wire AIN1;
output wire AIN2;
output wire AIN3;
output wire AIN4;
output wire AIN5;
output wire AIN6;
output wire [7:0]LED;
output wire D0,D1,D2,D3,D4,D5;

wire CLK100M_0;
wire CLK100M_1;
wire r_reset;


reg [7:0]tx_data;
wire [7:0]rx_data;
reg tx_write;
wire tx_busy;
wire rx_ready;
wire o_in_bytes_stream_ready;


initial tx_data = "0";
initial tx_write = 0;


PLL12M	PLL12M_inst (.areset (  ),
							.inclk0 ( CLK12M ),
							.c0 ( CLK100M_0 ),
							.c1 ( CLK100M_1 ));
							
clock_fastserial clock_for_fastserial(.i_clk(CLK100M_0), 
												.o_fsclk(BDBUS1));

rx_fastserial rx_lite(.i_clk(CLK100M_0),
								.i_fsdo(BDBUS2),
								.i_fsclk(BDBUS1),
							   .o_data(rx_data),
								.o_ready(rx_ready),
								.o_debug_0(),
								.o_debug_1(),
								.o_debug_2());
								
tx_fastserial tx_lite(.i_clk(CLK100M_0),
							.i_fsclk(BDBUS1),
							.i_fscts(BDBUS3),
							.i_data(tx_data),
							.i_write(tx_write),
							.o_busy(tx_busy),
							.o_fsdi(BDBUS0), 
							.o_debug_0());


			
avalonBus u0 (
		.clk_clk                (CLK100M_0),        				//              clk.clk
		.reset_reset_n          (r_reset),          				//            reset.reset_n
		.in_bytes_stream_ready  (o_in_bytes_stream_ready),  	//  in_bytes_stream.ready
		.in_bytes_stream_valid  (rx_ready),  						//                 .valid
		.in_bytes_stream_data   (rx_data),   						//                 .data
		.out_bytes_stream_ready (!tx_busy), 						// out_bytes_stream.ready
		.out_bytes_stream_valid (tx_write), 	//                 .valid
		.out_bytes_stream_data  (tx_data)   						// .data
	);


	
assign AIN0 = tx_busy;
assign AIN1 = tx_write;
assign AIN2 = tx_data[0];
assign AIN3 = tx_data[1];
assign AIN4 = tx_data[2];
assign AIN5 = tx_data[3];
assign AIN6 = tx_data[4];

assign D0 = tx_data[5];
assign D1 = 0;
assign D2 = 0;
assign D3 = 0;
assign D4 = 0;
assign D5 = 0;

assign r_reset = 1'b1;
endmodule
