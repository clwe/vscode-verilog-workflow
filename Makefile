all: testbench
 
.PHONY: vvp waveform clean
 
testbench: testbench.v
	iverilog -g2001 -o testbench.out testbench.v

testbench.vcd: testbench
	vvp testbench.out
 
vvp: testbench.vcd
 
waveform: testbench.vcd
	gtkwave testbench.vcd
 
clean::
	rm -f testbench.out testbench.vcd