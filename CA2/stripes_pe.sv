`timescale 1ns/1ns


module stripes_pe #(
    parameter VEC_WIDTH = 4,
    parameter DATA_WIDTH = 16,
    parameter SUM_WIDTH = 34
)(
    input clk,
    input rst,
    input [VEC_WIDTH-1:0] i_vec_a_bits,
    input [DATA_WIDTH*VEC_WIDTH-1:0] b,
    input [SUM_WIDTH-1:0] init_sum,
    input is_msb,
    input is_lsb,
    input valid,
    output [SUM_WIDTH-1:0] out
);
    wire [DATA_WIDTH-1:0] pe_out0, pe_out1, pe_out2, pe_out3;
    pe #(.WIDTH(DATA_WIDTH)) pe3(
        i_vec_a_bits[3],
        b[DATA_WIDTH*4-1:DATA_WIDTH*3],
        is_msb,
        pe_out3
    );
    pe #(.WIDTH(DATA_WIDTH)) pe2(
        i_vec_a_bits[2],
        b[DATA_WIDTH*3-1:DATA_WIDTH*2],
        is_msb,
        pe_out2
    );
    pe #(.WIDTH(DATA_WIDTH)) pe1(
        i_vec_a_bits[1],
        b[DATA_WIDTH*2-1:DATA_WIDTH*1],
        is_msb,
        pe_out1
    );
    pe #(.WIDTH(DATA_WIDTH)) pe0(
        i_vec_a_bits[0],
        b[DATA_WIDTH*1-1:0],
        is_msb,
        pe_out0
    );

    wire [SUM_WIDTH-1:0] input_sum_reg, mux_out;
    assign mux_out = (is_msb ? {SUM_WIDTH{1'b0}} : (out << 1));
    assign input_sum_reg = { {(SUM_WIDTH-DATA_WIDTH){pe_out0[DATA_WIDTH-1]}}, pe_out0 } +
                           { {(SUM_WIDTH-DATA_WIDTH){pe_out1[DATA_WIDTH-1]}}, pe_out1 } +
                           { {(SUM_WIDTH-DATA_WIDTH){pe_out2[DATA_WIDTH-1]}}, pe_out2 } +
                           { {(SUM_WIDTH-DATA_WIDTH){pe_out3[DATA_WIDTH-1]}}, pe_out3 } +
                           mux_out +
                           (is_lsb ? init_sum : {SUM_WIDTH{1'b0}});

    register #(.WIDTH(SUM_WIDTH)) sum_reg(
        .clk(clk),
        .rst(rst),
        .in(input_sum_reg),
        .en(valid),
        .out(out)
    );







endmodule
