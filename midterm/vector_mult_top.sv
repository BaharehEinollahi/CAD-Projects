module vector_mult_top (
    input clk,
    input rst,
    input start,

    input [7:0] a0,
    input [7:0] w0,
    input [7:0] a1,
    input [7:0] w1,

    output [15:0] result,
    output ready
);

    wire en_a0, en_w0, en_a1, en_w1;
    wire ctrl_a0_in, ctrl_a1_in;
    wire inz_acc;
    wire both_ready;

    vector_mult_dp DP (
        .clk(clk),
        .rst(rst),

        .a0(a0),
        .w0(w0),
        .a1(a1),
        .w1(w1),

        .en_a0(en_a0),
        .en_w0(en_w0),
        .en_a1(en_a1),
        .en_w1(en_w1),

        .ctrl_a0_in(ctrl_a0_in),
        .ctrl_a1_in(ctrl_a1_in),
        .inz_acc(inz_acc),

        .both_ready(both_ready),
        .result(result)
    );

    vector_mult_ctrl CTRL (
        .clk(clk),
        .rst(rst),
        .start(start),
        .both_ready(both_ready),

        .en_a0(en_a0),
        .en_w0(en_w0),
        .en_a1(en_a1),
        .en_w1(en_w1),

        .ctrl_a0_in(ctrl_a0_in),
        .ctrl_a1_in(ctrl_a1_in),
        .inz_acc(inz_acc),
        .ready(ready)
    );

endmodule
