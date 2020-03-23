`default_nettype none
`timescale 1 ns / 1 ns


module pwm_decode #(
        parameter clockFreq = 50000000)
        (input wire i_clk,
        input wire i_pwm,
        input wire i_reset,
        output wire  o_pwm_ready,
        output wire [15:0] o_pwm_value);


reg [15:0] pwm_on_count;
reg [15:0] pwm_off_count;
reg pwm_ready;
reg [1:0] state;
reg [15:0] clk_counter;
reg [1:0] pwm_sig;

localparam CLK_DIVIDER = (clockFreq/1000000) -1;
localparam GUARD_ERROR 	= 16'h8000;

localparam MEASURING_ON = 2'b1;
localparam MEASURING_OFF = 2'b0;
localparam MEASURE_COMPLETE = 2'b10;


localparam NO_ERROR = 16'h0;
localparam GUARD_TIME_ON_MAX = 16'hA28; //2600
localparam GUARD_TIME_ON_MIN = 16'h320; //800

initial begin
    pwm_ready = 0;
    state = MEASURING_OFF;
    clk_counter =0; 
    pwm_on_count = 0;
    pwm_off_count = 0;
    pwm_sig = 0;
end

assign o_pwm_value = pwm_on_count;
assign o_pwm_ready = pwm_ready;

always @(posedge i_clk or posedge i_reset) begin

    if (i_reset) begin
        pwm_ready <= 0;
        state <= MEASURING_OFF;
        clk_counter <= 0; 
        pwm_on_count <= 0;
        pwm_off_count <= 0;
        pwm_sig <= 0;
    end
    else begin
        //synchronize FF
        pwm_sig = {pwm_sig[0], i_pwm};
        case (state)
            MEASURING_OFF: begin 
                if (pwm_sig[1] == 0) begin
                    if (clk_counter < CLK_DIVIDER )
                        clk_counter <= clk_counter + 1;
                    else begin
                        clk_counter <= 0;
                        if (pwm_off_count < GUARD_TIME_ON_MAX)
                            pwm_off_count <= pwm_off_count + 1;
                        else
                            pwm_off_count <= pwm_off_count | GUARD_ERROR;
                    end
                end
                else begin
                    pwm_on_count <= 0;
                    pwm_ready <= 0;
                    state <= MEASURING_ON;
                    clk_counter <= 0;
                end
            end

            MEASURING_ON: begin 
                if (pwm_sig[1]) begin
                    if (clk_counter < CLK_DIVIDER )
                        clk_counter <= clk_counter + 1;
                    else begin
                        clk_counter <= 0;
                        if (pwm_on_count < GUARD_TIME_ON_MAX)                           
                            pwm_on_count <= pwm_on_count + 1;
                        else
                            pwm_on_count <= pwm_on_count | GUARD_ERROR;
                    end
                end
                else begin
                    if ( pwm_on_count < GUARD_TIME_ON_MIN)
                        pwm_on_count <= pwm_on_count | GUARD_ERROR;
                    pwm_ready <= 1;
                    state <= MEASURE_COMPLETE;
                end
            end
            MEASURE_COMPLETE: begin 
                clk_counter <= 0;
                pwm_ready <= 0;
                state <= MEASURING_OFF;
                pwm_on_count <=0;
                pwm_off_count <= 0;
            end

        endcase 
    end

end


endmodule

