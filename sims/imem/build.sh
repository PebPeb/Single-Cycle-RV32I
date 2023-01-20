iverilog -o imem.out imem_tb.v ~/Desktop/Single-Cycle-RV32I/imem.v
vvp imem.out
gtkwave imem_tb.vcd
rm imem.out
rm imem_tb.vcd
