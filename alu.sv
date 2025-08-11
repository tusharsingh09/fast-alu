`include "rtl/adder/carry_sel_add.sv"
`include "rtl/mult/mult.sv"

module ALU(
    input logic clk,
    input logic reset,
    input logic [2:0] c_control,
    input logic [31:0] srcA, srcB,
    output logic [31:0] result,
    output logic [31:0] hi
);

reg [31:0] sum;
reg nc;

reg [31:0] diff;
reg carry;

reg [63:0] product;
reg valid;

Carry_Select adder(
    .i_a(srcA),
    .i_b(srcB),
    .i_cin(1'b0),
    .o_s(sum),
    .o_cout(nc)
);

Carry_Select subtractor(
    .i_a(srcA),
    .i_b(~srcB),
    .i_cin(1'b1),
    .o_s(diff),
    .o_cout(carry)
);

Multiplier multiply(
    .clk(clk),
    .reset(reset),
    .M(srcA),
    .Q(srcB),
    .product(product),
    .valid(valid)
);

always@(*) begin
    case(c_control) 
    3'b000: result = sum;
    3'b001: result = diff;
    3'b010: result = product[31:0] & valid;
    3'b011: result = srcA << srcB;
    3'b100: result = srcA >> srcB;
    // division dont exist :cries:
    endcase
end

endmodule