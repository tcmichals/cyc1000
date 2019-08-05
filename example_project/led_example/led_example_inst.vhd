	component led_example is
		port (
			bytes_to_packets_in_bytes_stream_ready  : out std_logic;                                       -- ready
			bytes_to_packets_in_bytes_stream_valid  : in  std_logic                    := 'X';             -- valid
			bytes_to_packets_in_bytes_stream_data   : in  std_logic_vector(7 downto 0) := (others => 'X'); -- data
			clk_clk                                 : in  std_logic                    := 'X';             -- clk
			packets_to_bytes_out_bytes_stream_ready : in  std_logic                    := 'X';             -- ready
			packets_to_bytes_out_bytes_stream_valid : out std_logic;                                       -- valid
			packets_to_bytes_out_bytes_stream_data  : out std_logic_vector(7 downto 0);                    -- data
			reset_reset_n                           : in  std_logic                    := 'X';             -- reset_n
			simple_leds_leds                        : out std_logic_vector(7 downto 0);                    -- leds
			blinkt_led_serial_serial_clk            : out std_logic;                                       -- serial_clk
			blinkt_led_serial_serial_data           : out std_logic                                        -- serial_data
		);
	end component led_example;

	u0 : component led_example
		port map (
			bytes_to_packets_in_bytes_stream_ready  => CONNECTED_TO_bytes_to_packets_in_bytes_stream_ready,  --  bytes_to_packets_in_bytes_stream.ready
			bytes_to_packets_in_bytes_stream_valid  => CONNECTED_TO_bytes_to_packets_in_bytes_stream_valid,  --                                  .valid
			bytes_to_packets_in_bytes_stream_data   => CONNECTED_TO_bytes_to_packets_in_bytes_stream_data,   --                                  .data
			clk_clk                                 => CONNECTED_TO_clk_clk,                                 --                               clk.clk
			packets_to_bytes_out_bytes_stream_ready => CONNECTED_TO_packets_to_bytes_out_bytes_stream_ready, -- packets_to_bytes_out_bytes_stream.ready
			packets_to_bytes_out_bytes_stream_valid => CONNECTED_TO_packets_to_bytes_out_bytes_stream_valid, --                                  .valid
			packets_to_bytes_out_bytes_stream_data  => CONNECTED_TO_packets_to_bytes_out_bytes_stream_data,  --                                  .data
			reset_reset_n                           => CONNECTED_TO_reset_reset_n,                           --                             reset.reset_n
			simple_leds_leds                        => CONNECTED_TO_simple_leds_leds,                        --                       simple_leds.leds
			blinkt_led_serial_serial_clk            => CONNECTED_TO_blinkt_led_serial_serial_clk,            --                 blinkt_led_serial.serial_clk
			blinkt_led_serial_serial_data           => CONNECTED_TO_blinkt_led_serial_serial_data            --                                  .serial_data
		);

