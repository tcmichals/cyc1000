
`default_nettype none
`timescale 1 ns / 1 ns

module picorv32_soc(input clk,
							input reset,
							output [7:0] LED);
							
							
							
						
    picorv32_soc_avalon soc (
        .clk_clk                     (clk),                     //              clk.clk
        .led_gpio_cyc1000_led_signal (LED), // led_gpio_cyc1000.led_signal
        .reset_reset_n               (reset)                //            reset.reset_n
    );
	 
endmodule
//eof
	 
			