`timescale 1ns/1ns
module shift_register(
    input clk,
    input rst,
    input [15:0] in,
    input shift,
    output reg [127:0] out
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 34'b0;
        end else if (en) begin
            out <={112'b0, in};
        end else if (shift) begin
            out <= {out[111:0], in};
        end
    end

endmodule