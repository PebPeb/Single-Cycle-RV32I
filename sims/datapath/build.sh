iverilog -o datapath.out datapath_tb.v ~/Desktop/Single-Cycle-RV32I/*.v
vvp datapath.out
gtkwave datapath_tb.vcd
rm datapath.out
rm datapath_tb.vcd
