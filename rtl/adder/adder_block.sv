`ifndef ADDER_BLOCK_SV
`define ADDER_BLOCK_SV

`include "adder.sv"

// 4bit adder block
module Adder_Block(
    input logic [3:0] i_a,
    input logic [3:0] i_b,
    input logic i_cin,
    output logic [3:0] o_s,
    output logic o_cout
);

wire[4:0] cin;

generate 
    genvar i;
    for(i=0;i<4;i=i+1) begin
        Full_Adder ripple(
            .i_cin(cin[i]),
            .i_a(i_a[i]), .i_b(i_b[i]),
            .o_s(o_s[i]), .o_cout(cin[i+1])
        );
    end
endgenerate

assign cin[0] = i_cin;
assign o_cout = cin[4];

endmodule

`endif 