`ifndef MUX_SV
`define MUX_SV

module MUX2 #(
    parameter WIDTH = 32
)(
    input logic [WIDTH-1:0] I0, I1,
    input logic s,
    output logic [WIDTH-1:0] z
);
assign s = z?I1:I0;
endmodule

`endif