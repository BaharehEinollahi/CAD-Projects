`timescale 1ns/1ns

module hash_ct(
    input clk,
     rst, 
     start,
    input co_counter_i, 
    done_rnd,

    output inz_counter_i, 
    en_counter_i, 
    start_rnd, 
    load_m,
    output load_a,
    load_b, 
    load_c, 
    load_d,
    output 
    sel_a1, 
    sel_b1, 
    sel_c1, 
    sel_d1,
    output sel_a2, 
    sel_b2, 
    sel_c2, 
    sel_d2,
    output load_f, 
    sel_f1, 
    sel_f2, 
    done
);

    wire q2, q1, q0;
    wire q2_n, q1_n, q0_n;
    wire next_q2, next_q1, next_q0; 

    logic_dff ff0 (.clk(clk), .rst(rst), .d(next_q0), .out(q0));
    logic_dff ff1 (.clk(clk), .rst(rst), .d(next_q1), .out(q1));
    logic_dff ff2 (.clk(clk), .rst(rst), .d(next_q2), .out(q2));

    logic_not not0 (.a(q0), .out(q0_n));
    logic_not not1 (.a(q1), .out(q1_n));
    logic_not not2 (.a(q2), .out(q2_n));

    wire is_IDLE, is_A, is_B, is_C, is_D, is_E, is_F, is_G;

    logic_and3 dec_idle (.a(q2_n), .b(q1_n), .c(q0_n), .out(is_IDLE));
    logic_and3 dec_A    (.a(q2_n), .b(q1_n), .c(q0)  , .out(is_A));
    logic_and3 dec_B    (.a(q2_n), .b(q1)  , .c(q0_n), .out(is_B));
    logic_and3 dec_C    (.a(q2_n), .b(q1)  , .c(q0)  , .out(is_C));
    logic_and3 dec_D    (.a(q2)  , .b(q1_n), .c(q0_n), .out(is_D));
    logic_and3 dec_E    (.a(q2)  , .b(q1_n), .c(q0)  , .out(is_E));
    logic_and3 dec_F    (.a(q2)  , .b(q1)  , .c(q0_n), .out(is_F));
    logic_and3 dec_G    (.a(q2)  , .b(q1)  , .c(q0)  , .out(is_G));

    
    
    wire to_A, to_B, to_C, to_D, to_E, to_F, to_G;
    wire co_counter_n, done_rnd_n;
    
    logic_not not_co (.a(co_counter_i), .out(co_counter_n));
    logic_not not_dn (.a(done_rnd), .out(done_rnd_n));

    logic_and2 tr_idle_a (.a(is_IDLE), .b(start), .out(to_A));

    logic_or2  tr_to_B   (.a(is_A), .b(is_F), .out(to_B));

    logic_and2 tr_b_g    (.a(is_B), .b(co_counter_i), .out(to_G));
    logic_and2 tr_b_c    (.a(is_B), .b(co_counter_n), .out(to_C));

    wire d_stay;
    logic_and2 tr_d_stay (.a(is_D), .b(done_rnd_n), .out(d_stay));
    logic_or2  tr_to_D   (.a(is_C), .b(d_stay), .out(to_D));

    logic_and2 tr_d_e    (.a(is_D), .b(done_rnd), .out(to_E));

    assign to_F = is_E; 



    wire nq0_ac, nq0_eg;
    logic_or2 or_q0_1 (.a(to_A), .b(to_C), .out(nq0_ac));
    logic_or2 or_q0_2 (.a(to_E), .b(to_G), .out(nq0_eg));
    logic_or2 or_q0_f (.a(nq0_ac), .b(nq0_eg), .out(next_q0));

    wire nq1_bc, nq1_fg;
    logic_or2 or_q1_1 (.a(to_B), .b(to_C), .out(nq1_bc));
    logic_or2 or_q1_2 (.a(to_F), .b(to_G), .out(nq1_fg));
    logic_or2 or_q1_f (.a(nq1_bc), .b(nq1_fg), .out(next_q1));

    wire nq2_de, nq2_fg;
    logic_or2 or_q2_1 (.a(to_D), .b(to_E), .out(nq2_de));
    logic_or2 or_q2_2 (.a(to_F), .b(to_G), .out(nq2_fg));
    logic_or2 or_q2_f (.a(nq2_de), .b(nq2_fg), .out(next_q2));

    
    
    assign inz_counter_i = is_A;
    
    assign en_counter_i = is_F;

    assign start_rnd = is_C;

    wire grp_af;
    logic_or2 or_grp_af (.a(is_A), .b(is_F), .out(grp_af));
    
    assign load_m = grp_af;
    assign load_a = grp_af;
    assign load_b = grp_af;
    assign load_c = grp_af;
    assign load_d = grp_af;

    assign sel_a1 = is_A;
    assign sel_b1 = is_A;
    assign sel_c1 = is_A;
    assign sel_d1 = is_A;

    assign sel_a2 = is_F;
    assign sel_b2 = is_F;
    assign sel_c2 = is_F;
    assign sel_d2 = is_F;

    logic_or2 or_load_f (.a(is_C), .b(is_E), .out(load_f));

    assign sel_f1 = is_C;

    assign sel_f2 = is_E;

    assign done = is_G;

endmodule