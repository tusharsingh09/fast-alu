all: 
	cls

std = 2005-sv

.PHONY: carry

adder:
	iverilog -g$(std) -o carry adder/carry_tb.sv
	vvp adder
	gtkwave adder.vcd

carry:
	iverilog -g$(std) -o carry adder/carry_tb.sv
	vvp carry
	gtkwave carry.vcd 

mult:
	iverilog -g$(std) -o mult mult/mult_tb.sv
	vvp mult
	gtkwave mult.vcd