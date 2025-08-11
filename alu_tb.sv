`include "alu.sv"

module tb();

reg clk, reset;
reg [2:0] control;
reg [31:0] srca, srcb, result, hi;

ALU alu(
    clk, reset,
    control,
    srca,
    srcb,
    result,
    hi
);

initial begin

end

clk begin
    #1 clk = ~clk;
    if($time == 100) $finish;
end

endmodule