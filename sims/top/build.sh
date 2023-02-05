iverilog -o top_tb.out top_tb.v ~/Desktop/Single-Cycle-RV32I/*.v
vvp top_tb.out
gtkwave top_tb.vcd
rm top_tb.out
rm top_tb.vcd
