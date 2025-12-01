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
    
    //-------------------------------------------------------------------------
    // 1. Counter Instantiation (Provided in original code)
    //-------------------------------------------------------------------------
    counter counter(
        .clk(clk),
        .rst(rst),
        .inz(inz_counter),
        .en(en_counter),
        .inz_value(3'b010),
        .cout(co_counter)
    );

    //-------------------------------------------------------------------------
    // 2. Next State Logic & State Registers
    //    Using module 's2' (Registered MUX)
    //    Select Logic: S1 = q1, S0 = q0
    //-------------------------------------------------------------------------
    
    // State Bit 1 (Q1)
    // Sequence: IDLE(0)->0, A(1)->1, B(2)->1, C(3)->0
    s2 state_reg_q1 (
        .D00(1'b0),       // Next Q1 if IDLE
        .D01(1'b1),       // Next Q1 if A
        .D10(1'b1),       // Next Q1 if B
        .D11(1'b0),       // Next Q1 if C
        .A1(q1), .B1(1'b0), // S1 = Q1 | 0 = Q1
        .A0(q0), .B0(1'b1), // S0 = Q0 & 1 = Q0
        .clr(rst), 
        .clk(clk), 
        .out(q1)
    );

    // State Bit 0 (Q0)
    // Sequence: IDLE(0)->start, A(1)->0, B(2)->co_counter, C(3)->0
    s2 state_reg_q0 (
        .D00(start_rnd),  // Next Q0 if IDLE
        .D01(1'b0),       // Next Q0 if A
        .D10(co_counter), // Next Q0 if B
        .D11(1'b0),       // Next Q0 if C
        .A1(q1), .B1(1'b0), // S1 = Q1
        .A0(q0), .B0(1'b1), // S0 = Q0
        .clr(rst), 
        .clk(clk), 
        .out(q0)
    );

    //-------------------------------------------------------------------------
    // 3. Output Decoding
    //    Using module 'c2' (Combinational MUX)
    //-------------------------------------------------------------------------

    // Decode State A (01) -> Generates load_shreg and inz_counter
    // D01 is high, others low
    wire is_state_A;
    c2 decode_state_a (
        .D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0),
        .A1(q1), .B1(1'b0), 
        .A0(q0), .B0(1'b1), 
        .out(is_state_A)
    );
    
    // Decode State B (10) -> Generates shift_shreg and en_counter
    // D10 is high, others low
    wire is_state_B;
    c2 decode_state_b (
        .D00(1'b0), .D01(1'b0), .D10(1'b1), .D11(1'b0),
        .A1(q1), .B1(1'b0), 
        .A0(q0), .B0(1'b1), 
        .out(is_state_B)
    );

    // Decode State C (11) -> Generates done_rnd
    // D11 is high, others low
    c2 decode_state_c (
        .D00(1'b0), .D01(1'b0), .D10(1'b0), .D11(1'b1),
        .A1(q1), .B1(1'b0), 
        .A0(q0), .B0(1'b1), 
        .out(done_rnd)
    );

    //-------------------------------------------------------------------------
    // 4. Output Assignments
    //-------------------------------------------------------------------------
    assign load_shreg  = is_state_A;
    assign inz_counter = is_state_A;
    assign shift_shreg = is_state_B;
    assign en_counter  = is_state_B;

endmodule