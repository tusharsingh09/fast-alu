`ifndef CARRY_SELECT_ADDER_SV
`define CARRY_SELECT_ADDER_SV

`include "adder_block.sv"

// PROBLEM(fiexd): Carry propogate nhi ho rha nibble to nibble
// PROBELM(fixed): Last carry bahar na a rha

// WIDTH may only be multiples of 4
module Carry_Select #(
    parameter WIDTH = 32
)(
    input logic [WIDTH-1:0] i_a,
    input logic [WIDTH-1:0] i_b,
    input logic i_cin,
    output logic [WIDTH-1:0] o_s,
    output logic o_cout
);

logic [WIDTH-1:0] sum0;
logic [WIDTH-1:0] sum1;

logic [WIDTH/4+1:0] carries;
logic [WIDTH/4+1:1] carries0;
logic [WIDTH/4+1:1] carries1;

Adder_Block initial_nibble(
    .i_a(i_a[3:0]),
    .i_b(i_b[3:0]),
    .i_cin(i_cin),
    .o_s(o_s[3:0]),
    .o_cout(carries[0])
);

generate
    genvar i;
    for(i=1;i<WIDTH/4;i=i+1) begin
        Adder_Block nibbles_0(
            .i_a(i_a[4*i+3:4*i]),
            .i_b(i_b[4*i+3:4*i]),
            .i_cin(1'b0),
            .o_s(sum0[4*i+3:4*i]),
            .o_cout(carries0[i])
        );

        Adder_Block nibbles_1(
            .i_a(i_a[4*i+3:4*i]),
            .i_b(i_b[4*i+3:4*i]),
            .i_cin(1'b1),
            .o_s(sum1[4*i+3:4*i]),
            .o_cout(carries1[i])
        );

        assign carries[i] = carries[i-1]?carries1[i]:carries0[i];
        assign o_s[4*i+3:4*i] = carries[i-1]?sum1[4*i+3:4*i]:sum0[4*i+3:4*i];
    end
endgenerate
assign o_cout = carries[WIDTH/4-1];

endmodule

`endif