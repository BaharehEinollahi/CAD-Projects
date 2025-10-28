`timescale 1ns/1ns

module memory #(
    parameter WORD_WIDTH = 34,
    parameter DEPTH = 128,
    parameter ADDR_WIDTH = 7,
)(
    input clk,
    input rst,
    input write,
    input [ADDR_WIDTH-1:0] address,
    input [WORD_WIDTH-1:0] w_data,
    output reg [WORD_WIDTH-1:0] r_data
);

    reg [WORD_WIDTH-1:0] mem [0:DEPTH-1];

    initial begin
        $readmemh("CAD-CA2/TestCases/input_memory (1).txt", mem);
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            r_data <= {WORD_WIDTH{1'b0}};
        else begin
            if (write)
                mem[address] <= w_data;
            r_data <= mem[address];
        end
    end

endmodule
