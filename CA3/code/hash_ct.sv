`timescale 1ns/1ns

module hash_ct(
    input clk,
    input rst,
    input start,
    input co_counter_i,
    input done_rnd,

    output logic inz_counter_i,
    output logic en_counter_i,
    output logic start_rnd,
    output logic load_m,
    
    output logic load_a,
    output logic load_b,
    output logic load_c,
    output logic load_d,

    output logic sel_a1,
    output logic sel_b1,
    output logic sel_c1,
    output logic sel_d1,
    
    output logic sel_a2,
    output logic sel_b2,
    output logic sel_c2,
    output logic sel_d2,

    output logic load_f,
    output logic sel_f1,
    output logic sel_f2,

    output logic done
);

    wire qa, qb, qc, qd, qe, qf, qg, q_nidle;
    wire w_load_common, w_load_f;
    wire w_vcc, w_gnd;

    assign w_vcc = 1'b1;
    assign w_gnd = 1'b0;

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

    s2 r_nidle (
        .D00(start),
        .D01(start),
        .D10(w_vcc),
        .D11(w_gnd),
        .A1(q_nidle),
        .B1(w_gnd),
        .A0(qg),
        .B0(w_vcc),
        .clr(rst),
        .clk(clk),
        .out(q_nidle)
    );

    s2 r_a (
        .D00(w_gnd),
        .D01(w_vcc),
        .D10(w_gnd),
        .D11(w_gnd),
        .A1(q_nidle),
        .B1(w_gnd),
        .A0(start),
        .B0(w_vcc),
        .clr(rst),
        .clk(clk),
        .out(qa)
    );

    s1 r_b (
        .D00(w_gnd),
        .D01(w_gnd),
        .D10(w_vcc),
        .D11(w_vcc),
        .A1(qa),
        .B1(qf),
        .A0(w_gnd),
        .clr(rst),
        .clk(clk),
        .out(qb)
    );

    s2 r_c (
        .D00(w_gnd),
        .D01(w_gnd),
        .D10(w_vcc),
        .D11(w_gnd),
        .A1(qb),
        .B1(w_gnd),
        .A0(co_counter_i),
        .B0(w_vcc),
        .clr(rst),
        .clk(clk),
        .out(qc)
    );

    s2 r_d (
        .D00(qc),
        .D01(qc),
        .D10(w_vcc),
        .D11(w_gnd),
        .A1(qd),
        .B1(w_gnd),
        .A0(done_rnd),
        .B0(w_vcc),
        .clr(rst),
        .clk(clk),
        .out(qd)
    );

    s2 r_e (
        .D00(w_gnd),
        .D01(w_gnd),
        .D10(w_gnd),
        .D11(w_vcc),
        .A1(qd),
        .B1(w_gnd),
        .A0(done_rnd),
        .B0(w_vcc),
        .clr(rst),
        .clk(clk),
        .out(qe)
    );

    s1 r_f (
        .D00(w_gnd),
        .D01(w_gnd),
        .D10(w_vcc),
        .D11(w_vcc),
        .A1(qe),
        .B1(w_gnd),
        .A0(w_gnd),
        .clr(rst),
        .clk(clk),
        .out(qf)
    );

    s2 r_g (
        .D00(w_gnd),
        .D01(w_gnd),
        .D10(w_gnd),
        .D11(w_vcc),
        .A1(qb),
        .B1(w_gnd),
        .A0(co_counter_i),
        .B0(w_vcc),
        .clr(rst),
        .clk(clk),
        .out(qg)
    );

    c1 or_common (
        .A0(qa),
        .A1(w_gnd),
        .SA(w_gnd),
        .B0(w_vcc),
        .B1(w_gnd),
        .SB(w_gnd),
        .S0(qa),
        .S1(qf),
        .f(w_load_common)
    );

    c1 or_load_f (
        .A0(qc),
        .A1(w_gnd),
        .SA(w_gnd),
        .B0(w_vcc),
        .B1(w_gnd),
        .SB(w_gnd),
        .S0(qc),
        .S1(qe),
        .f(w_load_f)
    );

endmodule