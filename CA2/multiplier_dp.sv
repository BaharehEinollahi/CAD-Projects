`timescale 1ns/1ns

module multiplier_dp(
    input clk,
    input rst,
    input row_i_shift,
    input is_msb,
    output reg [33:0] out
);

    wire [33:0] r_data;

    wire [127:0] row_i_out;
    shift_register row_i_shreg(
        .clk(clk),
        .rst(rst),
        .in(r_data),
        .shift(row_i_shift),
        .out(row_i_out)
    );

    

    

endmodule