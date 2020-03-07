
module picorv32_soc_avalon (
	clk_clk,
	led_gpio_cyc1000_led_signal,
	reset_reset_n);	

	input		clk_clk;
	output	[7:0]	led_gpio_cyc1000_led_signal;
	input		reset_reset_n;
endmodule
