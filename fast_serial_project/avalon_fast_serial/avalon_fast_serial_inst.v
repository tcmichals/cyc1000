	avalon_fast_serial u0 (
		.clk_clk                (<connected-to-clk_clk>),                //              clk.clk
		.in_bytes_stream_ready  (<connected-to-in_bytes_stream_ready>),  //  in_bytes_stream.ready
		.in_bytes_stream_valid  (<connected-to-in_bytes_stream_valid>),  //                 .valid
		.in_bytes_stream_data   (<connected-to-in_bytes_stream_data>),   //                 .data
		.out_bytes_stream_ready (<connected-to-out_bytes_stream_ready>), // out_bytes_stream.ready
		.out_bytes_stream_valid (<connected-to-out_bytes_stream_valid>), //                 .valid
		.out_bytes_stream_data  (<connected-to-out_bytes_stream_data>),  //                 .data
		.reset_reset_n          (<connected-to-reset_reset_n>),          //            reset.reset_n
		.led_gpio_led           (<connected-to-led_gpio_led>)            //         led_gpio.led
	);

