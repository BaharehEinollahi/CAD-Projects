`timescale 1ns/1ns


module register(
    input clk,
    input rst,
    input [33:0] in,
    input en,
    output reg [33:0] out
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 34'b0;
        end else if (en) begin
            out <= in;
        end
    end

endmodule