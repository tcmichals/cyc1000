	led_example u0 (
		.bytes_to_packets_in_bytes_stream_ready  (<connected-to-bytes_to_packets_in_bytes_stream_ready>),  //  bytes_to_packets_in_bytes_stream.ready
		.bytes_to_packets_in_bytes_stream_valid  (<connected-to-bytes_to_packets_in_bytes_stream_valid>),  //                                  .valid
		.bytes_to_packets_in_bytes_stream_data   (<connected-to-bytes_to_packets_in_bytes_stream_data>),   //                                  .data
		.clk_clk                                 (<connected-to-clk_clk>),                                 //                               clk.clk
		.packets_to_bytes_out_bytes_stream_ready (<connected-to-packets_to_bytes_out_bytes_stream_ready>), // packets_to_bytes_out_bytes_stream.ready
		.packets_to_bytes_out_bytes_stream_valid (<connected-to-packets_to_bytes_out_bytes_stream_valid>), //                                  .valid
		.packets_to_bytes_out_bytes_stream_data  (<connected-to-packets_to_bytes_out_bytes_stream_data>),  //                                  .data
		.reset_reset_n                           (<connected-to-reset_reset_n>),                           //                             reset.reset_n
		.simple_leds_leds                        (<connected-to-simple_leds_leds>),                        //                       simple_leds.leds
		.blinkt_led_serial_serial_clk            (<connected-to-blinkt_led_serial_serial_clk>),            //                 blinkt_led_serial.serial_clk
		.blinkt_led_serial_serial_data           (<connected-to-blinkt_led_serial_serial_data>)            //                                  .serial_data
	);

