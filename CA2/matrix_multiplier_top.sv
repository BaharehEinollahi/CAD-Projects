`timescale 1ns/1ns

module matrix_multiplier_top(
    input clk,
    input rst,
    input start,
    output done
);

    wire en_row_counter, inz_row_counter;
    wire en_pe_counter, inz_pe_counter;
    wire en_counter_k, inz_counter_k;

    wire co_row_counter, co_pe_counter, co_counter_k;

    wire row_i_shift;
    wire load_rf;
    wire is_msb, is_lsb, is_valid;
    wire write;
    wire a_address, b_address, out_address;

    wire [33:0] out_dp;

    matrix_multiplier_dp datapath (
        .clk(clk),
        .rst(rst),

        .en_row_counter(en_row_counter),
        .inz_row_counter(inz_row_counter),
        .en_pe_counter(en_pe_counter),
        .inz_pe_counter(inz_pe_counter),
        .en_counter_k(en_counter_k),
        .inz_counter_k(inz_counter_k),

        .row_i_shift(row_i_shift),

        .load_rf(load_rf),

        
        .is_lsb(is_lsb),
        .is_valid(is_valid),

        .write(write),
        .a_address(a_address),
        .b_address(b_address),
        .out_address(out_address),

        .co_row_counter(co_row_counter),
        .co_pe_counter(co_pe_counter),
        .co_counter_k(co_counter_k),

        .out(out_dp)
    );


    matrix_multiplier_cntrl controller (
        .clk(clk),
        .rst(rst),

        .start(start),

        .co_row_counter(co_row_counter),
        .co_pe_counter(co_pe_counter),
        .co_counter_k(co_counter_k),

        .en_row_counter(en_row_counter),
        .inz_row_counter(inz_row_counter),
        .en_pe_counter(en_pe_counter),
        .inz_pe_counter(inz_pe_counter),
        .en_counter_k(en_counter_k),
        .inz_counter_k(inz_counter_k),

        .row_i_shift(row_i_shift),

        .load_rf(load_rf),

        
        .is_lsb(is_lsb),
        .is_valid(is_valid),

        
        .write(write),
        .a_address(a_address),
        .b_address(b_address),
        .out_address(out_address),
        .done(done)
    );

endmodule
