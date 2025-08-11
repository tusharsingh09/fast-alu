`timescale 1ns/1ns
`include "mult.sv"

module tb();

reg clk, reset, start;
reg [31:0] m, q;
reg [63:0] prod;
reg valid;

Multiplier dut(
    clk, reset,
    m, q, prod,
    valid
);

initial begin
    $dumpfile("mult.vcd");
    $dumpvars(0, tb);

    clk = 1'b0;
    reset = 1'b1;
    #5
    start = 1'b1;
    #4
    // start = 1'b0;
    reset = 1'b0;
    m = 234;
    q = 1243; 
end

always begin
    #1 clk = ~clk;
    if($time == 500) $finish;
end

endmodule