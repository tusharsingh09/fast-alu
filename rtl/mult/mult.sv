`ifndef MULTIPLY_SV
`define MULTIPLY_SV

module Multiplier(
    input logic clk,
    input logic reset,
    input logic [31:0] M, Q,
    output logic [63:0] product,
    output logic valid
);

parameter START = 2'b00;
parameter CHECK = 2'b01;
parameter CHECK_COUNT = 2'b10;
parameter STOP = 2'b11;

reg [1:0] state, next_state;
reg [64:0] z;

integer count;

always@(posedge clk or posedge reset) begin
    if(reset) state <= START;
    else state <= next_state;
end

always@(*) begin
    case(state)
    START: begin
        z = 65'd0;
        z[32:1] = Q;
        count = 32;
        next_state = CHECK;
    end

    CHECK: begin
        if(z[1:0] == 2'b01)  z[64:33] = z[64:33] + M;
        else if(z[1:0] == 2'b10)  z[64:33] = z[64:33] - M;
        asr();
        count = count - 1;
        next_state = CHECK_COUNT;
    end

    CHECK_COUNT: begin
        next_state = (count == 0)?STOP:CHECK;
    end

    STOP: next_state = START;
    endcase
end

task asr();
z = { z[64], z[63:1] };
endtask

assign product = (z[32:1]);
assign valid = (state == STOP);

endmodule

`endif