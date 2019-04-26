/*


SOP = 0x7E
EOP = 0x7E
ESC = 0x7D

Packet will start with a SOP and end with EOP, if there is a SOP,EOP, or ESC in the packet, it will be escaped with ESC.
For example,0x7D will be 0x7D

*/



module decode_protocol_store(
			i_clk,
			i_byte
			i_byte_ready,
			o_pkt_ready,
			
			)




endmodule
