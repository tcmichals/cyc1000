
`default_nettype none
`timescale 1 ns / 1 ns

module fast_serial(input CLK12M, 
						 input USER_BTN,
						 input wire BDBUS2,   //FSDO 
						 input wire BDBUS3,    //FSCTS
						 output wire BDBUS0,   //FSDI
						 output wire BDBUS1,  //FSCLK
						 output wire BDBUS4,   //DTR
						 output [7:0] LED,
						 output wire D4,
						 output wire D5);
						 

wire CLK_C0_50Mhz;
wire r_reset;

wire [7:0]tx_data;
wire [7:0]rx_data;
wire tx_write;
wire tx_busy;
wire rx_ready;
wire o_in_bytes_stream_ready;

assign D5 = BDBUS0;
assign D4 = BDBUS2;

						 
PLL12	PLL12_inst (.inclk0 ( CLK12M ),
						.c0 ( CLK_C0_50Mhz ));


clock_fastserial clock_for_fastserial(.i_clk(CLK_C0_50Mhz), 
												.o_fsclk(BDBUS1));

rx_fastserial rx_lite(.i_clk(CLK_C0_50Mhz),
								.i_fsdo(BDBUS2),
								.i_fsclk(BDBUS1),
							   .o_data(rx_data),
								.o_ready(rx_ready));
								
tx_fastserial tx_lite(.i_clk(CLK_C0_50Mhz),
							.i_fsclk(BDBUS1),
							.i_fscts(BDBUS3),
							.i_data(tx_data),
							.i_write(tx_write),
							.o_busy(tx_busy),
							.o_fsdi(BDBUS0), 
							.o_debug_0());
				
	


		reg [31:0] inr_irq0_irq;        // inr_irq0.irq
		reg [15:0] avm_m0_address;      // avm_m0_1.address
		reg        avm_m0_read;         //         .read
		reg       avm_m0_waitrequest;  //         .waitrequest
		reg [31:0] avm_m0_readdata;     //         .readdata
		reg        avm_m0_write;        //         .write
		reg [31:0] avm_m0_writedata;    //         .writedata
		reg [4:0]  avm_m0_1_chipselect;  //         .chipselect
	
	avalon_fast_serial u0 (
		.clk_clk                (CLK_C0_50Mhz),                //              clk.clk
		.in_bytes_stream_ready  (o_in_bytes_stream_ready),  //  in_bytes_stream.ready
		.in_bytes_stream_valid  (rx_ready),  //                 .valid
		.in_bytes_stream_data   (rx_data),   //                 .data
		.led_gpio_led           (LED),            //         led_gpio.led
		.out_bytes_stream_ready (!tx_busy), // out_bytes_stream.ready
		.out_bytes_stream_valid (tx_write), //                 .valid
		.out_bytes_stream_data  (tx_data),  //                 .data
		.reset_reset_n          (r_reset)          //            reset.reset_n

	);
							
reg [31:0] reset_count;
reg reset_reg;
assign r_reset = reset_reg;
initial reset_count = 0;
initial reset_reg = 0;
localparam RESET_COUNT = 32'hFFF;

always @(posedge CLK_C0_50Mhz) begin

	if (reset_count != RESET_COUNT ) begin
		reset_count<= reset_count + 1'b1;
		reset_reg <= 1'b0;
		end
	else begin
		reset_reg <= 1'b1;
	end
end	
	

endmodule

//eof
