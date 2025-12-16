`timescale 1ns/1ns

module rnd_generator_ct
(
    input clk,
    input rst,
    input start_rnd,
    output wire shift_shreg,
    output wire load_shreg,
    output wire done_rnd
);

    wire inz_counter;
    wire en_counter;
    wire co_counter;
    wire q1, q0;
    counter counter( .clk(clk), .rst(rst), .inz(inz_counter), .en(en_counter), .inz_value(3'b010), .cout(co_counter));
    s2 state_reg_q1 (.D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0), .A1(q1), .B1(1'b0), .A0(q0), .B0(1'b1), .clr(rst), .clk(clk), .out(q1));
    s2 state_reg_q0 ( .D00(start_rnd), .D01(1'b0), .D10(co_counter), .D11(1'b0), .A1(q1),.B1(1'b0), .A0(q0),.B0(1'b1), .clr(rst), .clk(clk), .out(q0));

    wire is_state_A;
    c2 decode_state_a (.D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0),.A1(q1), .B1(1'b0), .A0(q0), .B0(1'b1), .out(is_state_A));
    wire is_state_B;
    c2 decode_state_b (.D00(1'b0), .D01(1'b0), .D10(1'b1), .D11(1'b0),.A1(q1), .B1(1'b0), .A0(q0), .B0(1'b1), .out(is_state_B));
    c2 decode_state_c (.D00(1'b0), .D01(1'b0), .D10(1'b0), .D11(1'b1),.A1(q1), .B1(1'b0), .A0(q0), .B0(1'b1), .out(done_rnd));

    assign load_shreg  = is_state_A;
    assign inz_counter = is_state_A;
    assign shift_shreg = is_state_B;
    assign en_counter  = is_state_B;

endmodule