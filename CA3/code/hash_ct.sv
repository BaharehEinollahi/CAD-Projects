`timescale 1ns/1ns

module hash_ct(
    input clk,
    input rst,
    input start,
    input co_counter_i,
    input done_rnd,

    output inz_counter_i,
    output en_counter_i,
    output start_rnd,
    output load_m,
    
    output load_a,
    output load_b,
    output load_c,
    output load_d,

    output sel_a1,
    output sel_b1,
    output sel_c1,
    output sel_d1,
    
    output sel_a2,
    output sel_b2,
    output sel_c2,
    output sel_d2,

    output load_f,
    output sel_f1,
    output sel_f2,

    output done
);

    wire qa, qb, qc, qd, qe, qf, qg, q_idle;
    wire w_load_common, w_load_f;

    assign inz_counter_i = qa;
    assign sel_a1 = qa;
    assign sel_b1 = qa;
    assign sel_c1 = qa;
    assign sel_d1 = qa;

    assign sel_a2 = qf;
    assign sel_b2 = qf;
    assign sel_c2 = qf;
    assign sel_d2 = qf;
    assign en_counter_i = qf;

    assign load_m = w_load_common;
    assign load_a = w_load_common;
    assign load_b = w_load_common;
    assign load_c = w_load_common;
    assign load_d = w_load_common;

    assign sel_f1 = qc;
    assign start_rnd = qc;

    assign sel_f2 = qe;
    assign load_f = w_load_f;
    assign done = qg;

    s2 r_idle (
        .D00(start),
        .D01(start),
        .D10(1'b1),
        .D11(1'b0),
        .A1(q_idle),
        .B1(1'b0),
        .A0(qg),
        .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(q_idle)
    );

    s2 r_a (
        .D00(1'b0),
        .D01(1'b1),
        .D10(1'b0),
        .D11(1'b0),
        .A1(q_idle),
        .B1(1'b0),
        .A0(start),
        .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(qa)
    );

    s1 r_b (
        .D00(1'b0),
        .D01(1'b0),
        .D10(1'b1),
        .D11(1'b1),
        .A1(qa),
        .B1(qf),
        .A0(1'b0),
        .clr(rst),
        .clk(clk),
        .out(qb)
    );

    s2 r_c (
        .D00(1'b0),
        .D01(1'b0),
        .D10(1'b1),
        .D11(1'b0),
        .A1(qb),
        .B1(1'b0),
        .A0(co_counter_i),
        .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(qc)
    );

    s2 r_d (
        .D00(qc),
        .D01(qc),
        .D10(1'b1),
        .D11(1'b0),
        .A1(qd),
        .B1(1'b0),
        .A0(done_rnd),
        .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(qd)
    );

    s2 r_e (
        .D00(1'b0),
        .D01(1'b0),
        .D10(1'b0),
        .D11(1'b1),
        .A1(qd),
        .B1(1'b0),
        .A0(done_rnd),
        .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(qe)
    );

    s1 r_f (
        .D00(1'b0),
        .D01(1'b0),
        .D10(1'b1),
        .D11(1'b1),
        .A1(qe),
        .B1(1'b0),
        .A0(1'b0),
        .clr(rst),
        .clk(clk),
        .out(qf)
    );

    s2 r_g (
        .D00(1'b0),
        .D01(1'b0),
        .D10(1'b0),
        .D11(1'b1),
        .A1(qb),
        .B1(1'b0),
        .A0(co_counter_i),
        .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(qg)
    );

    logic_or2 or_common (qa, qf, w_load_common);
    logic_or2 or_load_f (qc, qe, w_load_f);

endmodule