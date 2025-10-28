`timescale 1ns/1ns

module counter #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input en,
    input inz,
    output reg [WIDTH-1:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= {WIDTH{1'b0}};
        else if (inz)
            count <= {WIDTH{1'b0}};
        else if (en)
            count <= count + 1'b1;
    end
endmodule
