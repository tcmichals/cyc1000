	component picorv32_soc_avalon is
		port (
			clk_clk                     : in  std_logic                    := 'X'; -- clk
			led_gpio_cyc1000_led_signal : out std_logic_vector(7 downto 0);        -- led_signal
			reset_reset_n               : in  std_logic                    := 'X'  -- reset_n
		);
	end component picorv32_soc_avalon;

	u0 : component picorv32_soc_avalon
		port map (
			clk_clk                     => CONNECTED_TO_clk_clk,                     --              clk.clk
			led_gpio_cyc1000_led_signal => CONNECTED_TO_led_gpio_cyc1000_led_signal, -- led_gpio_cyc1000.led_signal
			reset_reset_n               => CONNECTED_TO_reset_reset_n                --            reset.reset_n
		);

