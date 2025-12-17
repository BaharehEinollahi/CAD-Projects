`timescale 1ns/1ns

module register
#(parameter WIDTH = 6)
(
    input clk,
    input rst,
    input load,
    input [WIDTH-1:0] parallel_in,
    output wire [WIDTH-1:0] data_out
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : bit_slice
            s2 s2_inst (
                .D00 (data_out[i]),
                .D01 (data_out[i]),
                .D10 (parallel_in[i]),
                .D11 (parallel_in[i]),
                .A1  (load),
                .B1  (1'b0),
                .A0  (1'b1),
                .B0  (1'b1),
                .clr (rst),
                .clk (clk),
                .out (data_out[i])
            );
        end
    endgenerate

endmodule