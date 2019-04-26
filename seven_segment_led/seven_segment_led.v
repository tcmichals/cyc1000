

module seven_segment_led(CLK12M,
								USER_BTN,
								AIN0, 
								AIN1,
								AIN2,
								AIN3,
								AIN4,
								AIN5,
								AIN6,
								LED);
/* Crystal input */
input wire CLK12M;
input wire USER_BTN;
/* used to control the 7 segment LED */
output wire AIN0;
output wire AIN1;
output wire AIN2;
output wire AIN3;
output wire AIN4;
output wire AIN5;
output wire AIN6;
/* used to help debug LED */
output wire [7:0]LED;


/* local */
wire CLK100M_0;
wire switch_up;
wire expired;
reg [4:0] counter;
wire [6:0] segment_output;

initial counter=0;

PLL12M	PLL12M_inst (.inclk0 ( CLK12M ),
							.c0 ( CLK100M_0 ));

debouncer #(15) d1 (.CLK(CLK100M_0), .switch_input(USER_BTN), .trans_up(switch_up));
decoder_7_seg segment( .CLK(CLK100M_0), .D(counter), .SEG(segment_output));
up_counter #(100000000/5) u_counter( .i_clk(CLK100M_0), .o_expired(expired));

always @(posedge CLK100M_0) begin
	if (switch_up || expired) begin
		if (counter < 9) 
			counter <= counter +1;
		else
			counter = 0;
	end
end




assign AIN0 = segment_output[0];
assign AIN1 = segment_output[1];
assign AIN2 = segment_output[2];
assign AIN3 = segment_output[3];
assign AIN4 = segment_output[4];
assign AIN5 = segment_output[5];
assign AIN6 = segment_output[6];

assign LED[0] = counter[0];
assign LED[1] = counter[1];
assign LED[2] = counter[2];
assign LED[3] = counter[3];


							
endmodule

//eof
