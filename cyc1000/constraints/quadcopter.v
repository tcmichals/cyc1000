

module quadcopter(CLK12M,
						LED,
						USER_BTN,
	
						/* accelerometer */
						SEN_INT1,
						SEN_INT2,
						SEN_SDI,
						SEN_SDO,
						SEN_SPC,
						SEN_CS,

						PIO0,PIO1,PIO2,PIO3,PIO4,PIO5,PIO6,PIO7,
	
					//FTDI serial port Async RS232
						BDBUS0,    //TX
						BDBUS1,    //RX
						BDBUS2,    //RTS
						BDBUS3,    //CTS
						BDBUS4,    //DTR
						BDBUS5,    //DSR
	
						AIN0, //Channel_1
						AIN1, //Channel_2
						AIN2, //Channel_3
						AIN3, //Channel_4
						AIN4, //Channel_5
						AIN5, //Channel_6
						AIN6, //Motor 1
						AIN7, //Motor 2
						
						D0, //Motor 3
						D2, //Motor 4
						D3,
						D4,
						D5,
						D6,
						
						output MEM_CLK);
	
	input wire CLK12M,
	output wire [7:0] LED,
	input wire USER_BTN,
	
	/* accelerometer */
	input wire SEN_INT1,
	input wire SEN_INT2,
	input wire SEN_SDI,
	input wire SEN_SDO,
	input wire SEN_SPC,
	input wire SEN_CS,

	input wire	D0,D1,D2,D3,D4,D5,D6,D7;
	
	//FTDI serial port Async RS232
	input wire  BDBUS0,   	//TX
	output wire BDBUS1,  	//RX
	output wire BDBUS2,   //RTS
	input wire  BDBUS3,    //CTS
	output wire BDBUS4,    //DTR
	input wire  BDBUS5,    //DSR
	
	input wire AIN0,AIN1,AIN2,AIN3,AIN4, AIN5;
	output wire AIN6, AIN7;
	output wire D0,D1;
	
	output MEM_CLK;



endmodule

// eof
