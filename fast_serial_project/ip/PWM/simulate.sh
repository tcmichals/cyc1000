iverilog -o pwm pwm_decode_tb.v pwm_decode.v
vvp pwm
gtkwave pwm_decode_tb.vcd 