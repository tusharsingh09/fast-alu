`ifndef DIV_SV
`define DIV_SV

module Divider#(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic reset,
    input logic a[WIDTH-1:0],
    input logic b[WIDTH-1:0],
    output logic q[WIDTH-1:0],
    output logic r[WIDTH-1:0]
);

endmodule

`endif