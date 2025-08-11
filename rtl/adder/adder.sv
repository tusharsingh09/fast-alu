`ifndef ADDER_SV
`define ADDER_SV

module Full_Adder(
    input logic i_cin,
    input logic i_a,
    input logic i_b,
    output logic o_s,
    output logic o_cout
);

assign o_s = i_a^i_b^i_cin;
assign o_cout = ((i_a&i_b) | (i_b&i_cin) | (i_a&i_cin));

endmodule

`endif