

module decoder_7_seg(
	input CLK,
   input [3:0] D,
   output reg [6:0] SEG
   );

initial SEG = 0;

always @(posedge CLK) 
begin
	case(D)
		4'd0: SEG <= 7'b1000000;
		4'd1: SEG <= 7'b1110011; 
		4'd2: SEG <= 7'b0100100;
		4'd3: SEG <= 7'b0100001;
		4'd4: SEG <= 7'b0010011;
		4'd5: SEG <= 7'b0001001;
		4'd6: SEG <= 7'b0001000;
		4'd7: SEG <= 7'b1100011;
		4'd8: SEG <= 7'b0000000;
		4'd9: SEG <= 7'b0000011;		
		4'hA: SEG <= 7'b0000011;		
		4'hB: SEG <= 7'b0000011;		
		4'hB: SEG <= 7'b0000011;		
		4'hD: SEG <= 7'b0000011;		
		4'hE: SEG <= 7'b0000011;	
		4'hF: SEG <= 7'b0000011;	
		default: SEG <= 7'b1111111;
	endcase
end

endmodule
