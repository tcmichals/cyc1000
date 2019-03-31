
module fast_serial_test(CLK12M, 
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
								LED);
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

wire CLK100M_0;
wire CLK1M_1;


reg [7:0]tx_data;
wire [7:0]rx_data;
reg tx_write;
wire tx_busy;
wire rx_ready;
initial tx_data = "0";
initial tx_write = 0;

PLL12M	PLL12M_inst (
							.areset (  ),
							.inclk0 ( CLK12M ),
							.c0 ( CLK100M_0 ),
							.c1 ( CLK1M_1 ),
							.locked (  )
						);

 clock_fastserial clock_for_fastserial(.i_clk(CLK100M_0), 
													.o_fsclk(BDBUS1));

rx_fastserial rx_lite(.i_clk(CLK100M_0),
								.i_fsdo(BDBUS2),
								.i_fsclk(BDBUS1),
							   .o_data(rx_data),
								.o_ready(rx_ready),
								.o_debug0(AIN5),
								.o_debug1(AIN6));
								
tx_fastserial tx_lite(.i_clk(CLK100M_0),
							.i_fsclk(BDBUS1),
							.i_fscts(BDBUS3),
							.i_data(tx_data),
							.i_write(tx_write),
							.o_busy(tx_busy),
							.o_fsdi(BDBUS0));


assign		LED[0] = rx_data[0];
assign		LED[1] = rx_data[1];
assign		LED[2] = rx_data[2];
assign		LED[3] = rx_data[3];
assign		LED[4] = rx_data[4];
assign		LED[5] = rx_data[5];
assign		LED[6] = rx_data[6];
assign		LED[7] = rx_data[7];
//assign AIN0 = BDBUS0;
assign AIN0 = CLK1M_1;
assign AIN1 = BDBUS1;
assign AIN2 = BDBUS2;
assign AIN3 = BDBUS3;
assign AIN4 = rx_ready;

	




endmodule
