


all:
	iverilog -o imem_tb.out imem_tb.v ../../imem.v
	vvp imem_tb.out
	gtkwave imem_tb.vcd

clean:
	rm -f imem_tb.out
	rm -f imem_tb.vcd