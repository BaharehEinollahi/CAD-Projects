`timescale 1ns/1ns

module counter(
    input clk,
    input rst,
    input en,
    input inz,
    output reg [7:0] count
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            count <= 8'b0;
        end else if (inz) begin
            count <= 8'b0;
        end else if (en) begin
            count <= count + 1;
        end
    end

endmodule