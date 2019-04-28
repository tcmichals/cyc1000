

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

reg [3:0] counter;
initial counter=0;
wire [6:0] segment_output;
reg toggle_ready;

initial tx_data = "0";
initial tx_write = 0;
initial toggle_ready =0;

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


decoder_7_seg segment( .CLK(CLK100M_0), .D(counter), .SEG(segment_output));							
			
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


	
assign AIN0 = segment_output[0];
assign AIN1 = segment_output[1];
assign AIN2 = segment_output[2];
assign AIN3 = segment_output[3];
assign AIN4 = segment_output[4];
assign AIN5 = segment_output[5];
assign AIN6 = segment_output[6];

assign D0 = tx_busy;
assign D1 = rx_ready;
assign D2 = rx_data[4];
assign D3 = rx_data[5];
assign D4 = rx_data[6];
assign D5 = rx_data[7];

assign r_reset = 1'b1;
endmodule
