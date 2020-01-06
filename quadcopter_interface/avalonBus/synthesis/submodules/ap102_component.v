// ap102_component.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

/*

C Code 
void show(void){
	write_byte(0);
	write_byte(0);
	write_byte(0);
	write_byte(0);
	for(x = 0; x < NUM_LEDS; x++){
		write_byte(APA_SOF | (leds[x] & 0b11111));
		write_byte((leds[x] >> 8 ) & 0xFF);
		write_byte((leds[x] >> 16) & 0xFF);
		write_byte((leds[x] >> 24) & 0xFF);
	}
	write_byte(0xff);
	//write_byte(0xff);
	//write_byte(0xff);
	//write_byte(0xff);
}

*/
`timescale 1 ps / 1 ps
module ap102_component #(
		parameter number_leds = 8
	) (
		output wire        led_sclk,           // led_block.sclk
		output wire        led_sdo,            //          .sdo
		input  wire [3:0]  avs_s0_address,     //    avs_s0.address
		input  wire        avs_s0_write,       //          .write
		input  wire [31:0] avs_s0_writedata,   //          .writedata
		output wire        avs_s0_waitrequest, //          .waitrequest
		input  wire        clock_clk,          //     clock.clk
		input  wire        reset_reset         //     reset.reset
	);

	// TODO: Auto-generated HDL template
	assign avs_s0_waitrequest = 1'b0;
	

	localparam START_OF_FRAME_OFFSET = 0;
	localparam SIZE_OF_LED_ARRAY =  number_leds + 2;
	localparam END_OF_FRAME_OFFSET = SIZE_OF_LED_ARRAY - 1;
	
	reg [31:0] leds [SIZE_OF_LED_ARRAY:0];
	reg [3:0] which_led;
	reg [2:0] state;
	reg [7:0] num_bits;
		
	reg start_tx;	
	reg [31:0] led_data;
	wire tx_busy;

	assign avs_s0_waitrequest = 1'b0;
	
	localparam IDLE =   3'h0;
	localparam INIT =   3'h1;
	localparam START =  3'h2;
	localparam WAIT =   3'h3;
	localparam STOP =   3'h4;
	
	localparam APA102_START_FRAME = 32'h0;
	localparam APA102_END_FRAME = 32'hFFFFFFFF;
	/* Add Header */
	localparam APA102_LED_FRAME_MASK = 32'hFF000000;

	initial begin
	
		state = IDLE;
		/* zero out all leds */
		`ifdef VERILATOR
			leds[0] = APA102_START_FRAME;
			leds[1] = 32'hFF0000FF;
			leds[2] = 32'hFF00FF00;
			leds[3] = 32'hFFFF0000;
			leds[4] = 32'hFF000000;
			leds[5] = 32'hFF000000;
			leds[6] = 32'hFF000000;
			leds[7] = 32'hFF000000;
			leds[8] = 32'hFF000000;
			leds[END_OF_FRAME_OFFSET] = APA102_END_FRAME;
		`else
			leds[0] = APA102_START_FRAME;
			leds[1] = 32'hFF0000FF;
			leds[2] = 32'hFF00FF00;
			leds[3] = 32'hFFFF0000;
			leds[4] = 32'hFF000000;
			leds[5] = 32'hFF000000;
			leds[6] = 32'hFF000000;
			leds[7] = 32'hFF000000;
			leds[8] = 32'hFF000000;
			leds[END_OF_FRAME_OFFSET] = APA102_END_FRAME;

		`endif 
		
		which_led = 0;
		start_tx = 0;
	end 

	serial_tx tx ( .i_reset(reset_reset), 
						.i_start(start_tx), 
						.i_clk(clock_clk), 
						.i_data(led_data), 
						.i_num_bits(num_bits),
						.o_busy(tx_busy),
						.o_serial_data(led_sdo),
						.o_serial_clock(led_sclk));
			

always @(posedge clock_clk or posedge reset_reset) begin

		if (reset_reset) begin
			state <= IDLE;
			which_led <= 0;
		end
		else begin
			if (avs_s0_write) begin  /* was if ( avs_s0_address > 1 && avs_s0_address < 9) begin */
				if ( avs_s0_address > 0 && avs_s0_address < 9) begin
			
					leds[avs_s0_address] <= (avs_s0_writedata | APA102_LED_FRAME_MASK);
					`ifdef VERILATOR
						$display("ap102_component:Set LED register(%d)", avs_s0_address );
					`endif
				end else begin
					state <= INIT;
					which_led <=0;
					$display("ap102_component:Set state to INIT");
				end
			end else begin 
		 
			/* put state machine here */
			case (state)
	
				INIT: begin
					if (!tx_busy) begin
						$display("ap102_component:state INIT, set state to start");
						start_tx <= 1;
						num_bits <= 32;
						
						led_data <= leds[which_led];
						state <= START;
					end
				end
			
				START: begin
						$display("ap102_component:state START, set state to WAIT, which_led(%d)", which_led);
						start_tx <= 0;
						state <= WAIT;
						which_led <= which_led + 1'b1;
					end

				WAIT: begin
					if ( !tx_busy ) begin
						$display("ap102_component:state WAIT which_led=%d", which_led);
						if ( which_led == SIZE_OF_LED_ARRAY) begin
							`ifdef LOCAL_DEBUG
								state <= STOP;
							`else
								state <= IDLE;
							`endif
							$display("ap102_component:DONE");
							end
						else begin
							if ( which_led == (SIZE_OF_LED_ARRAY-1))
								num_bits <= 8;
							else
								num_bits <= 32;
							led_data <= leds[which_led];
							state <= START;
							start_tx <= 1;
						end
					end
				end
			
				IDLE: begin
					`ifdef VERILATOR
						 $display("state IDLE address(%d) avs_s0_write(%d)", avs_s0_address, avs_s0_write);
					`endif

					`ifdef LOCAL_DEBUG
						state <= INIT;
					`endif

					which_led <=0;
				end
				
				default: begin
					$display("ap102_component: default state is %d", state);
				end
			endcase

		end
	end
 end /* clock */
	
	


endmodule
