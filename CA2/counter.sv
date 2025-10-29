`timescale 1ns/1ns

module counter #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input en,
    input inz,
    output reg [WIDTH-1:0] count,
    output co,
    output logic co2
);
    always @(posedge clk or posedge rst) begin
        if (rst)begin
            count <= {WIDTH{1'b0}};
            co2 <= 1'b0;
        end
        else if (inz) begin
            count <= {WIDTH{1'b0}};
            co2 <= 1'b0;
        end
        else if (en)
            {co2, count} <= count + 1'b1;
    end

    assign co = count == ({WIDTH{1'b1}});
endmodule
