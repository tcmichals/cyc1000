	component avalonBus is
		port (
			clk_clk                : in  std_logic                    := 'X';             -- clk
			reset_reset_n          : in  std_logic                    := 'X';             -- reset_n
			in_bytes_stream_ready  : out std_logic;                                       -- ready
			in_bytes_stream_valid  : in  std_logic                    := 'X';             -- valid
			in_bytes_stream_data   : in  std_logic_vector(7 downto 0) := (others => 'X'); -- data
			out_bytes_stream_ready : in  std_logic                    := 'X';             -- ready
			out_bytes_stream_valid : out std_logic;                                       -- valid
			out_bytes_stream_data  : out std_logic_vector(7 downto 0)                     -- data
		);
	end component avalonBus;

	u0 : component avalonBus
		port map (
			clk_clk                => CONNECTED_TO_clk_clk,                --              clk.clk
			reset_reset_n          => CONNECTED_TO_reset_reset_n,          --            reset.reset_n
			in_bytes_stream_ready  => CONNECTED_TO_in_bytes_stream_ready,  --  in_bytes_stream.ready
			in_bytes_stream_valid  => CONNECTED_TO_in_bytes_stream_valid,  --                 .valid
			in_bytes_stream_data   => CONNECTED_TO_in_bytes_stream_data,   --                 .data
			out_bytes_stream_ready => CONNECTED_TO_out_bytes_stream_ready, -- out_bytes_stream.ready
			out_bytes_stream_valid => CONNECTED_TO_out_bytes_stream_valid, --                 .valid
			out_bytes_stream_data  => CONNECTED_TO_out_bytes_stream_data   --                 .data
		);

