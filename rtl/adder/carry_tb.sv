`include "carry_sel_add.sv"

module carry_sel_add_tb();

reg [31:0] a, b;
reg cin, cout;
reg [31:0] sum;

Carry_Select #(.WIDTH(32)) carry(
    .i_a(a),
    .i_b(b),
    .i_cin(cin),
    .o_s(sum),
    .o_cout(cout)
);

initial begin
    $dumpfile("carry.vcd");
    $dumpvars(0, carry_sel_add_tb);
    cin = 1'b0;
    a = 32'd124;
    b = 32'd632;
    #5 
    a = 32'd451;
    b = 32'd344;
    #5
    a = 32'd891;
    b = 32'd10;
    #5
    a = 32'hffffffff;
    b = 32'd1;
    #5;
    $finish;
end

endmodule