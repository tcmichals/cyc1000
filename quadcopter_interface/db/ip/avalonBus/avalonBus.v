// avalonBus.v

// Generated using ACDS version 18.1 646

`timescale 1 ps / 1 ps
module avalonBus (
		output wire       ap102_led_outputs_sclk,     //  ap102_led_outputs.sclk
		output wire       ap102_led_outputs_sdo,      //                   .sdo
		input  wire       clk_clk,                    //                clk.clk
		output wire       gpio_led_outputs_led_0,     //   gpio_led_outputs.led_0
		output wire       gpio_led_outputs_led_1,     //                   .led_1
		output wire       gpio_led_outputs_led_2,     //                   .led_2
		output wire       gpio_led_outputs_led_3,     //                   .led_3
		output wire       gpio_led_outputs_led_4,     //                   .led_4
		output wire       gpio_led_outputs_led_5,     //                   .led_5
		output wire       gpio_led_outputs_led_6,     //                   .led_6
		output wire       gpio_led_outputs_led_7,     //                   .led_7
		output wire       in_bytes_stream_ready,      //    in_bytes_stream.ready
		input  wire       in_bytes_stream_valid,      //                   .valid
		input  wire [7:0] in_bytes_stream_data,       //                   .data
		input  wire       out_bytes_stream_ready,     //   out_bytes_stream.ready
		output wire       out_bytes_stream_valid,     //                   .valid
		output wire [7:0] out_bytes_stream_data,      //                   .data
		input  wire       pwm_decoder_inputs_pwm_1,   // pwm_decoder_inputs.pwm_1
		input  wire       pwm_decoder_inputs_pwm_2,   //                   .pwm_2
		input  wire       pwm_decoder_inputs_pwm_3,   //                   .pwm_3
		input  wire       pwm_decoder_inputs_pwm_4,   //                   .pwm_4
		input  wire       pwm_decoder_inputs_pwm_5,   //                   .pwm_5
		input  wire       pwm_decoder_inputs_pwm_6,   //                   .pwm_6
		output wire       pwm_decoder_inputs_debug_0, //                   .debug_0
		output wire       pwm_dshot_motors_motor_1,   //   pwm_dshot_motors.motor_1
		output wire       pwm_dshot_motors_motor_2,   //                   .motor_2
		output wire       pwm_dshot_motors_motor_3,   //                   .motor_3
		output wire       pwm_dshot_motors_motor_4,   //                   .motor_4
		input  wire       reset_reset_n               //              reset.reset_n
	);

	wire  [31:0] packets_to_master_0_avalon_master_readdata;             // mm_interconnect_0:packets_to_master_0_avalon_master_readdata -> packets_to_master_0:readdata
	wire         packets_to_master_0_avalon_master_waitrequest;          // mm_interconnect_0:packets_to_master_0_avalon_master_waitrequest -> packets_to_master_0:waitrequest
	wire  [31:0] packets_to_master_0_avalon_master_address;              // packets_to_master_0:address -> mm_interconnect_0:packets_to_master_0_avalon_master_address
	wire         packets_to_master_0_avalon_master_read;                 // packets_to_master_0:read -> mm_interconnect_0:packets_to_master_0_avalon_master_read
	wire   [3:0] packets_to_master_0_avalon_master_byteenable;           // packets_to_master_0:byteenable -> mm_interconnect_0:packets_to_master_0_avalon_master_byteenable
	wire         packets_to_master_0_avalon_master_readdatavalid;        // mm_interconnect_0:packets_to_master_0_avalon_master_readdatavalid -> packets_to_master_0:readdatavalid
	wire         packets_to_master_0_avalon_master_write;                // packets_to_master_0:write -> mm_interconnect_0:packets_to_master_0_avalon_master_write
	wire  [31:0] packets_to_master_0_avalon_master_writedata;            // packets_to_master_0:writedata -> mm_interconnect_0:packets_to_master_0_avalon_master_writedata
	wire         mm_interconnect_0_ap102_led_0_avs_s0_waitrequest;       // ap102_led_0:avs_s0_waitrequest -> mm_interconnect_0:ap102_led_0_avs_s0_waitrequest
	wire   [3:0] mm_interconnect_0_ap102_led_0_avs_s0_address;           // mm_interconnect_0:ap102_led_0_avs_s0_address -> ap102_led_0:avs_s0_address
	wire         mm_interconnect_0_ap102_led_0_avs_s0_write;             // mm_interconnect_0:ap102_led_0_avs_s0_write -> ap102_led_0:avs_s0_write
	wire  [31:0] mm_interconnect_0_ap102_led_0_avs_s0_writedata;         // mm_interconnect_0:ap102_led_0_avs_s0_writedata -> ap102_led_0:avs_s0_writedata
	wire  [31:0] mm_interconnect_0_pwm_decoder_0_avs_s0_readdata;        // pwm_decoder_0:avs_s0_readdata -> mm_interconnect_0:pwm_decoder_0_avs_s0_readdata
	wire         mm_interconnect_0_pwm_decoder_0_avs_s0_waitrequest;     // pwm_decoder_0:avs_s0_waitrequest -> mm_interconnect_0:pwm_decoder_0_avs_s0_waitrequest
	wire   [2:0] mm_interconnect_0_pwm_decoder_0_avs_s0_address;         // mm_interconnect_0:pwm_decoder_0_avs_s0_address -> pwm_decoder_0:avs_s0_address
	wire         mm_interconnect_0_pwm_decoder_0_avs_s0_read;            // mm_interconnect_0:pwm_decoder_0_avs_s0_read -> pwm_decoder_0:avs_s0_read
	wire         mm_interconnect_0_pwm_decoder_0_avs_s0_write;           // mm_interconnect_0:pwm_decoder_0_avs_s0_write -> pwm_decoder_0:avs_s0_write
	wire  [31:0] mm_interconnect_0_pwm_decoder_0_avs_s0_writedata;       // mm_interconnect_0:pwm_decoder_0_avs_s0_writedata -> pwm_decoder_0:avs_s0_writedata
	wire         mm_interconnect_0_pwm_dshot_0_avs_s0_chipselect;        // mm_interconnect_0:pwm_dshot_0_avs_s0_chipselect -> pwm_dshot_0:avs_s0_chipselect
	wire         mm_interconnect_0_pwm_dshot_0_avs_s0_waitrequest;       // pwm_dshot_0:avs_s0_waitrequest -> mm_interconnect_0:pwm_dshot_0_avs_s0_waitrequest
	wire   [2:0] mm_interconnect_0_pwm_dshot_0_avs_s0_address;           // mm_interconnect_0:pwm_dshot_0_avs_s0_address -> pwm_dshot_0:avs_s0_address
	wire         mm_interconnect_0_pwm_dshot_0_avs_s0_write;             // mm_interconnect_0:pwm_dshot_0_avs_s0_write -> pwm_dshot_0:avs_s0_write
	wire  [31:0] mm_interconnect_0_pwm_dshot_0_avs_s0_writedata;         // mm_interconnect_0:pwm_dshot_0_avs_s0_writedata -> pwm_dshot_0:avs_s0_writedata
	wire         mm_interconnect_0_gpio_led_0_avs_slave_waitrequest;     // gpio_led_0:avs_s1_waitrequest -> mm_interconnect_0:gpio_led_0_avs_slave_waitrequest
	wire   [1:0] mm_interconnect_0_gpio_led_0_avs_slave_address;         // mm_interconnect_0:gpio_led_0_avs_slave_address -> gpio_led_0:avs_s1_address
	wire         mm_interconnect_0_gpio_led_0_avs_slave_write;           // mm_interconnect_0:gpio_led_0_avs_slave_write -> gpio_led_0:avs_s1_write
	wire  [31:0] mm_interconnect_0_gpio_led_0_avs_slave_writedata;       // mm_interconnect_0:gpio_led_0_avs_slave_writedata -> gpio_led_0:avs_s1_writedata
	wire  [31:0] mm_interconnect_0_sysid_qsys_0_control_slave_readdata;  // sysid_qsys_0:readdata -> mm_interconnect_0:sysid_qsys_0_control_slave_readdata
	wire   [0:0] mm_interconnect_0_sysid_qsys_0_control_slave_address;   // mm_interconnect_0:sysid_qsys_0_control_slave_address -> sysid_qsys_0:address
	wire         mm_interconnect_0_timer_0_s1_chipselect;                // mm_interconnect_0:timer_0_s1_chipselect -> timer_0:chipselect
	wire  [15:0] mm_interconnect_0_timer_0_s1_readdata;                  // timer_0:readdata -> mm_interconnect_0:timer_0_s1_readdata
	wire   [2:0] mm_interconnect_0_timer_0_s1_address;                   // mm_interconnect_0:timer_0_s1_address -> timer_0:address
	wire         mm_interconnect_0_timer_0_s1_write;                     // mm_interconnect_0:timer_0_s1_write -> timer_0:write_n
	wire  [15:0] mm_interconnect_0_timer_0_s1_writedata;                 // mm_interconnect_0:timer_0_s1_writedata -> timer_0:writedata
	wire         st_bytes_to_packets_0_out_packets_stream_valid;         // st_bytes_to_packets_0:out_valid -> avalon_st_adapter:in_0_valid
	wire   [7:0] st_bytes_to_packets_0_out_packets_stream_data;          // st_bytes_to_packets_0:out_data -> avalon_st_adapter:in_0_data
	wire         st_bytes_to_packets_0_out_packets_stream_ready;         // avalon_st_adapter:in_0_ready -> st_bytes_to_packets_0:out_ready
	wire   [7:0] st_bytes_to_packets_0_out_packets_stream_channel;       // st_bytes_to_packets_0:out_channel -> avalon_st_adapter:in_0_channel
	wire         st_bytes_to_packets_0_out_packets_stream_startofpacket; // st_bytes_to_packets_0:out_startofpacket -> avalon_st_adapter:in_0_startofpacket
	wire         st_bytes_to_packets_0_out_packets_stream_endofpacket;   // st_bytes_to_packets_0:out_endofpacket -> avalon_st_adapter:in_0_endofpacket
	wire         avalon_st_adapter_out_0_valid;                          // avalon_st_adapter:out_0_valid -> packets_to_master_0:in_valid
	wire   [7:0] avalon_st_adapter_out_0_data;                           // avalon_st_adapter:out_0_data -> packets_to_master_0:in_data
	wire         avalon_st_adapter_out_0_ready;                          // packets_to_master_0:in_ready -> avalon_st_adapter:out_0_ready
	wire         avalon_st_adapter_out_0_startofpacket;                  // avalon_st_adapter:out_0_startofpacket -> packets_to_master_0:in_startofpacket
	wire         avalon_st_adapter_out_0_endofpacket;                    // avalon_st_adapter:out_0_endofpacket -> packets_to_master_0:in_endofpacket
	wire         packets_to_master_0_out_stream_valid;                   // packets_to_master_0:out_valid -> avalon_st_adapter_001:in_0_valid
	wire   [7:0] packets_to_master_0_out_stream_data;                    // packets_to_master_0:out_data -> avalon_st_adapter_001:in_0_data
	wire         packets_to_master_0_out_stream_ready;                   // avalon_st_adapter_001:in_0_ready -> packets_to_master_0:out_ready
	wire         packets_to_master_0_out_stream_startofpacket;           // packets_to_master_0:out_startofpacket -> avalon_st_adapter_001:in_0_startofpacket
	wire         packets_to_master_0_out_stream_endofpacket;             // packets_to_master_0:out_endofpacket -> avalon_st_adapter_001:in_0_endofpacket
	wire         avalon_st_adapter_001_out_0_valid;                      // avalon_st_adapter_001:out_0_valid -> st_packets_to_bytes_0:in_valid
	wire   [7:0] avalon_st_adapter_001_out_0_data;                       // avalon_st_adapter_001:out_0_data -> st_packets_to_bytes_0:in_data
	wire         avalon_st_adapter_001_out_0_ready;                      // st_packets_to_bytes_0:in_ready -> avalon_st_adapter_001:out_0_ready
	wire   [7:0] avalon_st_adapter_001_out_0_channel;                    // avalon_st_adapter_001:out_0_channel -> st_packets_to_bytes_0:in_channel
	wire         avalon_st_adapter_001_out_0_startofpacket;              // avalon_st_adapter_001:out_0_startofpacket -> st_packets_to_bytes_0:in_startofpacket
	wire         avalon_st_adapter_001_out_0_endofpacket;                // avalon_st_adapter_001:out_0_endofpacket -> st_packets_to_bytes_0:in_endofpacket
	wire         rst_controller_reset_out_reset;                         // rst_controller:reset_out -> [ap102_led_0:reset_reset, avalon_st_adapter:in_rst_0_reset, avalon_st_adapter_001:in_rst_0_reset, gpio_led_0:reset_reset, mm_interconnect_0:packets_to_master_0_clk_reset_reset_bridge_in_reset_reset, packets_to_master_0:reset_n, pwm_decoder_0:reset_reset, pwm_dshot_0:reset_reset, st_bytes_to_packets_0:reset_n, st_packets_to_bytes_0:reset_n, sysid_qsys_0:reset_n, timer_0:reset_n]

	ap102_component #(
		.number_leds (8)
	) ap102_led_0 (
		.led_sclk           (ap102_led_outputs_sclk),                           // led_block.sclk
		.led_sdo            (ap102_led_outputs_sdo),                            //          .sdo
		.avs_s0_address     (mm_interconnect_0_ap102_led_0_avs_s0_address),     //    avs_s0.address
		.avs_s0_write       (mm_interconnect_0_ap102_led_0_avs_s0_write),       //          .write
		.avs_s0_writedata   (mm_interconnect_0_ap102_led_0_avs_s0_writedata),   //          .writedata
		.avs_s0_waitrequest (mm_interconnect_0_ap102_led_0_avs_s0_waitrequest), //          .waitrequest
		.clock_clk          (clk_clk),                                          //     clock.clk
		.reset_reset        (rst_controller_reset_out_reset)                    //     reset.reset
	);

	gpio_led gpio_led_0 (
		.clock_clk          (clk_clk),                                            //       clock.clk
		.reset_reset        (rst_controller_reset_out_reset),                     //       reset.reset
		.led_signal_0       (gpio_led_outputs_led_0),                             // conduit_end.led_0
		.led_signal_1       (gpio_led_outputs_led_1),                             //            .led_1
		.led_signal_2       (gpio_led_outputs_led_2),                             //            .led_2
		.led_signal_3       (gpio_led_outputs_led_3),                             //            .led_3
		.led_signal_4       (gpio_led_outputs_led_4),                             //            .led_4
		.led_signal_5       (gpio_led_outputs_led_5),                             //            .led_5
		.led_signal_6       (gpio_led_outputs_led_6),                             //            .led_6
		.led_signal_7       (gpio_led_outputs_led_7),                             //            .led_7
		.avs_s1_address     (mm_interconnect_0_gpio_led_0_avs_slave_address),     //   avs_slave.address
		.avs_s1_write       (mm_interconnect_0_gpio_led_0_avs_slave_write),       //            .write
		.avs_s1_writedata   (mm_interconnect_0_gpio_led_0_avs_slave_writedata),   //            .writedata
		.avs_s1_waitrequest (mm_interconnect_0_gpio_led_0_avs_slave_waitrequest)  //            .waitrequest
	);

	altera_avalon_packets_to_master #(
		.FAST_VER    (1),
		.FIFO_DEPTHS (2),
		.FIFO_WIDTHU (1)
	) packets_to_master_0 (
		.clk               (clk_clk),                                         //           clk.clk
		.reset_n           (~rst_controller_reset_out_reset),                 //     clk_reset.reset_n
		.out_ready         (packets_to_master_0_out_stream_ready),            //    out_stream.ready
		.out_valid         (packets_to_master_0_out_stream_valid),            //              .valid
		.out_data          (packets_to_master_0_out_stream_data),             //              .data
		.out_startofpacket (packets_to_master_0_out_stream_startofpacket),    //              .startofpacket
		.out_endofpacket   (packets_to_master_0_out_stream_endofpacket),      //              .endofpacket
		.in_ready          (avalon_st_adapter_out_0_ready),                   //     in_stream.ready
		.in_valid          (avalon_st_adapter_out_0_valid),                   //              .valid
		.in_data           (avalon_st_adapter_out_0_data),                    //              .data
		.in_startofpacket  (avalon_st_adapter_out_0_startofpacket),           //              .startofpacket
		.in_endofpacket    (avalon_st_adapter_out_0_endofpacket),             //              .endofpacket
		.address           (packets_to_master_0_avalon_master_address),       // avalon_master.address
		.readdata          (packets_to_master_0_avalon_master_readdata),      //              .readdata
		.read              (packets_to_master_0_avalon_master_read),          //              .read
		.write             (packets_to_master_0_avalon_master_write),         //              .write
		.writedata         (packets_to_master_0_avalon_master_writedata),     //              .writedata
		.waitrequest       (packets_to_master_0_avalon_master_waitrequest),   //              .waitrequest
		.readdatavalid     (packets_to_master_0_avalon_master_readdatavalid), //              .readdatavalid
		.byteenable        (packets_to_master_0_avalon_master_byteenable)     //              .byteenable
	);

	pwm_decoder pwm_decoder_0 (
		.clock_clk          (clk_clk),                                            //       clock.clk
		.reset_reset        (rst_controller_reset_out_reset),                     //       reset.reset
		.pwm_input_1        (pwm_decoder_inputs_pwm_1),                           // conduit_end.pwm_1
		.pwm_input_2        (pwm_decoder_inputs_pwm_2),                           //            .pwm_2
		.pwm_input_3        (pwm_decoder_inputs_pwm_3),                           //            .pwm_3
		.pwm_input_4        (pwm_decoder_inputs_pwm_4),                           //            .pwm_4
		.pwm_input_5        (pwm_decoder_inputs_pwm_5),                           //            .pwm_5
		.pwm_input_6        (pwm_decoder_inputs_pwm_6),                           //            .pwm_6
		.debug_0            (pwm_decoder_inputs_debug_0),                         //            .debug_0
		.avs_s0_address     (mm_interconnect_0_pwm_decoder_0_avs_s0_address),     //      avs_s0.address
		.avs_s0_read        (mm_interconnect_0_pwm_decoder_0_avs_s0_read),        //            .read
		.avs_s0_readdata    (mm_interconnect_0_pwm_decoder_0_avs_s0_readdata),    //            .readdata
		.avs_s0_write       (mm_interconnect_0_pwm_decoder_0_avs_s0_write),       //            .write
		.avs_s0_writedata   (mm_interconnect_0_pwm_decoder_0_avs_s0_writedata),   //            .writedata
		.avs_s0_waitrequest (mm_interconnect_0_pwm_decoder_0_avs_s0_waitrequest)  //            .waitrequest
	);

	pwm_dshot pwm_dshot_0 (
		.avs_s0_address     (mm_interconnect_0_pwm_dshot_0_avs_s0_address),     //      avs_s0.address
		.avs_s0_write       (mm_interconnect_0_pwm_dshot_0_avs_s0_write),       //            .write
		.avs_s0_writedata   (mm_interconnect_0_pwm_dshot_0_avs_s0_writedata),   //            .writedata
		.avs_s0_waitrequest (mm_interconnect_0_pwm_dshot_0_avs_s0_waitrequest), //            .waitrequest
		.avs_s0_chipselect  (mm_interconnect_0_pwm_dshot_0_avs_s0_chipselect),  //            .chipselect
		.clock_clk          (clk_clk),                                          //       clock.clk
		.reset_reset        (rst_controller_reset_out_reset),                   //       reset.reset
		.motor_1            (pwm_dshot_motors_motor_1),                         // motor_block.motor_1
		.motor_2            (pwm_dshot_motors_motor_2),                         //            .motor_2
		.motor_3            (pwm_dshot_motors_motor_3),                         //            .motor_3
		.motor_4            (pwm_dshot_motors_motor_4)                          //            .motor_4
	);

	altera_avalon_st_bytes_to_packets #(
		.CHANNEL_WIDTH (8),
		.ENCODING      (0)
	) st_bytes_to_packets_0 (
		.clk               (clk_clk),                                                //                clk.clk
		.reset_n           (~rst_controller_reset_out_reset),                        //          clk_reset.reset_n
		.out_channel       (st_bytes_to_packets_0_out_packets_stream_channel),       // out_packets_stream.channel
		.out_ready         (st_bytes_to_packets_0_out_packets_stream_ready),         //                   .ready
		.out_valid         (st_bytes_to_packets_0_out_packets_stream_valid),         //                   .valid
		.out_data          (st_bytes_to_packets_0_out_packets_stream_data),          //                   .data
		.out_startofpacket (st_bytes_to_packets_0_out_packets_stream_startofpacket), //                   .startofpacket
		.out_endofpacket   (st_bytes_to_packets_0_out_packets_stream_endofpacket),   //                   .endofpacket
		.in_ready          (in_bytes_stream_ready),                                  //    in_bytes_stream.ready
		.in_valid          (in_bytes_stream_valid),                                  //                   .valid
		.in_data           (in_bytes_stream_data)                                    //                   .data
	);

	altera_avalon_st_packets_to_bytes #(
		.CHANNEL_WIDTH (8),
		.ENCODING      (0)
	) st_packets_to_bytes_0 (
		.clk              (clk_clk),                                   //               clk.clk
		.reset_n          (~rst_controller_reset_out_reset),           //         clk_reset.reset_n
		.in_ready         (avalon_st_adapter_001_out_0_ready),         // in_packets_stream.ready
		.in_valid         (avalon_st_adapter_001_out_0_valid),         //                  .valid
		.in_data          (avalon_st_adapter_001_out_0_data),          //                  .data
		.in_channel       (avalon_st_adapter_001_out_0_channel),       //                  .channel
		.in_startofpacket (avalon_st_adapter_001_out_0_startofpacket), //                  .startofpacket
		.in_endofpacket   (avalon_st_adapter_001_out_0_endofpacket),   //                  .endofpacket
		.out_ready        (out_bytes_stream_ready),                    //  out_bytes_stream.ready
		.out_valid        (out_bytes_stream_valid),                    //                  .valid
		.out_data         (out_bytes_stream_data)                      //                  .data
	);

	avalonBus_sysid_qsys_0 sysid_qsys_0 (
		.clock    (clk_clk),                                               //           clk.clk
		.reset_n  (~rst_controller_reset_out_reset),                       //         reset.reset_n
		.readdata (mm_interconnect_0_sysid_qsys_0_control_slave_readdata), // control_slave.readdata
		.address  (mm_interconnect_0_sysid_qsys_0_control_slave_address)   //              .address
	);

	avalonBus_timer_0 timer_0 (
		.clk        (clk_clk),                                 //   clk.clk
		.reset_n    (~rst_controller_reset_out_reset),         // reset.reset_n
		.address    (mm_interconnect_0_timer_0_s1_address),    //    s1.address
		.writedata  (mm_interconnect_0_timer_0_s1_writedata),  //      .writedata
		.readdata   (mm_interconnect_0_timer_0_s1_readdata),   //      .readdata
		.chipselect (mm_interconnect_0_timer_0_s1_chipselect), //      .chipselect
		.write_n    (~mm_interconnect_0_timer_0_s1_write),     //      .write_n
		.irq        ()                                         //   irq.irq
	);

	avalonBus_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                             (clk_clk),                                               //                                           clk_0_clk.clk
		.packets_to_master_0_clk_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                        // packets_to_master_0_clk_reset_reset_bridge_in_reset.reset
		.packets_to_master_0_avalon_master_address                 (packets_to_master_0_avalon_master_address),             //                   packets_to_master_0_avalon_master.address
		.packets_to_master_0_avalon_master_waitrequest             (packets_to_master_0_avalon_master_waitrequest),         //                                                    .waitrequest
		.packets_to_master_0_avalon_master_byteenable              (packets_to_master_0_avalon_master_byteenable),          //                                                    .byteenable
		.packets_to_master_0_avalon_master_read                    (packets_to_master_0_avalon_master_read),                //                                                    .read
		.packets_to_master_0_avalon_master_readdata                (packets_to_master_0_avalon_master_readdata),            //                                                    .readdata
		.packets_to_master_0_avalon_master_readdatavalid           (packets_to_master_0_avalon_master_readdatavalid),       //                                                    .readdatavalid
		.packets_to_master_0_avalon_master_write                   (packets_to_master_0_avalon_master_write),               //                                                    .write
		.packets_to_master_0_avalon_master_writedata               (packets_to_master_0_avalon_master_writedata),           //                                                    .writedata
		.ap102_led_0_avs_s0_address                                (mm_interconnect_0_ap102_led_0_avs_s0_address),          //                                  ap102_led_0_avs_s0.address
		.ap102_led_0_avs_s0_write                                  (mm_interconnect_0_ap102_led_0_avs_s0_write),            //                                                    .write
		.ap102_led_0_avs_s0_writedata                              (mm_interconnect_0_ap102_led_0_avs_s0_writedata),        //                                                    .writedata
		.ap102_led_0_avs_s0_waitrequest                            (mm_interconnect_0_ap102_led_0_avs_s0_waitrequest),      //                                                    .waitrequest
		.gpio_led_0_avs_slave_address                              (mm_interconnect_0_gpio_led_0_avs_slave_address),        //                                gpio_led_0_avs_slave.address
		.gpio_led_0_avs_slave_write                                (mm_interconnect_0_gpio_led_0_avs_slave_write),          //                                                    .write
		.gpio_led_0_avs_slave_writedata                            (mm_interconnect_0_gpio_led_0_avs_slave_writedata),      //                                                    .writedata
		.gpio_led_0_avs_slave_waitrequest                          (mm_interconnect_0_gpio_led_0_avs_slave_waitrequest),    //                                                    .waitrequest
		.pwm_decoder_0_avs_s0_address                              (mm_interconnect_0_pwm_decoder_0_avs_s0_address),        //                                pwm_decoder_0_avs_s0.address
		.pwm_decoder_0_avs_s0_write                                (mm_interconnect_0_pwm_decoder_0_avs_s0_write),          //                                                    .write
		.pwm_decoder_0_avs_s0_read                                 (mm_interconnect_0_pwm_decoder_0_avs_s0_read),           //                                                    .read
		.pwm_decoder_0_avs_s0_readdata                             (mm_interconnect_0_pwm_decoder_0_avs_s0_readdata),       //                                                    .readdata
		.pwm_decoder_0_avs_s0_writedata                            (mm_interconnect_0_pwm_decoder_0_avs_s0_writedata),      //                                                    .writedata
		.pwm_decoder_0_avs_s0_waitrequest                          (mm_interconnect_0_pwm_decoder_0_avs_s0_waitrequest),    //                                                    .waitrequest
		.pwm_dshot_0_avs_s0_address                                (mm_interconnect_0_pwm_dshot_0_avs_s0_address),          //                                  pwm_dshot_0_avs_s0.address
		.pwm_dshot_0_avs_s0_write                                  (mm_interconnect_0_pwm_dshot_0_avs_s0_write),            //                                                    .write
		.pwm_dshot_0_avs_s0_writedata                              (mm_interconnect_0_pwm_dshot_0_avs_s0_writedata),        //                                                    .writedata
		.pwm_dshot_0_avs_s0_waitrequest                            (mm_interconnect_0_pwm_dshot_0_avs_s0_waitrequest),      //                                                    .waitrequest
		.pwm_dshot_0_avs_s0_chipselect                             (mm_interconnect_0_pwm_dshot_0_avs_s0_chipselect),       //                                                    .chipselect
		.sysid_qsys_0_control_slave_address                        (mm_interconnect_0_sysid_qsys_0_control_slave_address),  //                          sysid_qsys_0_control_slave.address
		.sysid_qsys_0_control_slave_readdata                       (mm_interconnect_0_sysid_qsys_0_control_slave_readdata), //                                                    .readdata
		.timer_0_s1_address                                        (mm_interconnect_0_timer_0_s1_address),                  //                                          timer_0_s1.address
		.timer_0_s1_write                                          (mm_interconnect_0_timer_0_s1_write),                    //                                                    .write
		.timer_0_s1_readdata                                       (mm_interconnect_0_timer_0_s1_readdata),                 //                                                    .readdata
		.timer_0_s1_writedata                                      (mm_interconnect_0_timer_0_s1_writedata),                //                                                    .writedata
		.timer_0_s1_chipselect                                     (mm_interconnect_0_timer_0_s1_chipselect)                //                                                    .chipselect
	);

	avalonBus_avalon_st_adapter #(
		.inBitsPerSymbol (8),
		.inUsePackets    (1),
		.inDataWidth     (8),
		.inChannelWidth  (8),
		.inErrorWidth    (0),
		.inUseEmptyPort  (0),
		.inUseValid      (1),
		.inUseReady      (1),
		.inReadyLatency  (0),
		.outDataWidth    (8),
		.outChannelWidth (0),
		.outErrorWidth   (0),
		.outUseEmptyPort (0),
		.outUseValid     (1),
		.outUseReady     (1),
		.outReadyLatency (0)
	) avalon_st_adapter (
		.in_clk_0_clk        (clk_clk),                                                // in_clk_0.clk
		.in_rst_0_reset      (rst_controller_reset_out_reset),                         // in_rst_0.reset
		.in_0_data           (st_bytes_to_packets_0_out_packets_stream_data),          //     in_0.data
		.in_0_valid          (st_bytes_to_packets_0_out_packets_stream_valid),         //         .valid
		.in_0_ready          (st_bytes_to_packets_0_out_packets_stream_ready),         //         .ready
		.in_0_startofpacket  (st_bytes_to_packets_0_out_packets_stream_startofpacket), //         .startofpacket
		.in_0_endofpacket    (st_bytes_to_packets_0_out_packets_stream_endofpacket),   //         .endofpacket
		.in_0_channel        (st_bytes_to_packets_0_out_packets_stream_channel),       //         .channel
		.out_0_data          (avalon_st_adapter_out_0_data),                           //    out_0.data
		.out_0_valid         (avalon_st_adapter_out_0_valid),                          //         .valid
		.out_0_ready         (avalon_st_adapter_out_0_ready),                          //         .ready
		.out_0_startofpacket (avalon_st_adapter_out_0_startofpacket),                  //         .startofpacket
		.out_0_endofpacket   (avalon_st_adapter_out_0_endofpacket)                     //         .endofpacket
	);

	avalonBus_avalon_st_adapter_001 #(
		.inBitsPerSymbol (8),
		.inUsePackets    (1),
		.inDataWidth     (8),
		.inChannelWidth  (0),
		.inErrorWidth    (0),
		.inUseEmptyPort  (0),
		.inUseValid      (1),
		.inUseReady      (1),
		.inReadyLatency  (0),
		.outDataWidth    (8),
		.outChannelWidth (8),
		.outErrorWidth   (0),
		.outUseEmptyPort (0),
		.outUseValid     (1),
		.outUseReady     (1),
		.outReadyLatency (0)
	) avalon_st_adapter_001 (
		.in_clk_0_clk        (clk_clk),                                      // in_clk_0.clk
		.in_rst_0_reset      (rst_controller_reset_out_reset),               // in_rst_0.reset
		.in_0_data           (packets_to_master_0_out_stream_data),          //     in_0.data
		.in_0_valid          (packets_to_master_0_out_stream_valid),         //         .valid
		.in_0_ready          (packets_to_master_0_out_stream_ready),         //         .ready
		.in_0_startofpacket  (packets_to_master_0_out_stream_startofpacket), //         .startofpacket
		.in_0_endofpacket    (packets_to_master_0_out_stream_endofpacket),   //         .endofpacket
		.out_0_data          (avalon_st_adapter_001_out_0_data),             //    out_0.data
		.out_0_valid         (avalon_st_adapter_001_out_0_valid),            //         .valid
		.out_0_ready         (avalon_st_adapter_001_out_0_ready),            //         .ready
		.out_0_startofpacket (avalon_st_adapter_001_out_0_startofpacket),    //         .startofpacket
		.out_0_endofpacket   (avalon_st_adapter_001_out_0_endofpacket),      //         .endofpacket
		.out_0_channel       (avalon_st_adapter_001_out_0_channel)           //         .channel
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
