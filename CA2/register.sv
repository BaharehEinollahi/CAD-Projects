`timescale 1ns/1ns


module register #(
    parameter WIDTH = 34 
)(
    input  logic              clk,
    input  logic              rst,
    input  logic [WIDTH-1:0]  in,
    input  logic              en,
    output logic [WIDTH-1:0] out
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= '0; 
        end else if (en) begin
            out <= in;
        end
    end

endmodule