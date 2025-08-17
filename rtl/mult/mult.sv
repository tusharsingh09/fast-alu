`ifndef MULTIPLY_SV
`define MULTIPLY_SV

module Multiplier#(
    parameter WIDTH=32
)(
    input logic clk,
    input logic reset,
    input logic [WIDTH-1:0] M, Q,
    output logic [2*WIDTH-1:0] product,
    output logic valid
);

parameter START = 2'b00;
parameter CHECK = 2'b01;
parameter CHECK_COUNT = 2'b10;
parameter STOP = 2'b11;

reg [1:0] state, next_state;
reg [2*WIDTH:0] z;

integer count;

always@(posedge clk or posedge reset) begin
    if(reset) state <= START;
    else state <= next_state;
end

always@(*) begin
    case(state)
    START: begin
        z = 0;
        z[WIDTH:1] = Q;
        count = WIDTH;
        next_state = CHECK;
    end

    CHECK: begin
        if(z[1:0] == 2'b01)  z[2*WIDTH:WIDTH+1] = z[2*WIDTH:WIDTH+1] + M;
        else if(z[1:0] == 2'b10)  z[2*WIDTH:WIDTH+1] = z[2*WIDTH:WIDTH+1] - M;
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
z = { z[2*WIDTH], z[2*WIDTH-1:1] };
endtask

assign product = (z[WIDTH:1]);
assign valid = (state == STOP);

endmodule

`endif