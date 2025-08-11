`include "adder_block.sv"

module Adder_tb();

reg [3:0] a, b;
reg cin, cout;
reg [3:0] sum;

Adder_Block block(a, b, cin, sum, cout);

initial begin
    $dumpfile("adder.vcd");
    $dumpvars(0, Adder_tb);
    cin = 1'b0;
    #2
    a = 4'd1;
    b = 4'd2;
    #2 
    a = 4'd15;
    b = 4'd2;
end

always
    #1 if($time == 10) $finish;

endmodule