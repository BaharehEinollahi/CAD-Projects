`timescale 1ns/1ns

module matrix_multiplier_dp #(
    parameter DATA_WIDTH = 16,
    parameter SUM_WIDTH = 34,
    parameter ADDR_WIDTH = 7,
    parameter N_REGS = 8,
    parameter VEC_WIDTH = 4
)(
    input clk,
    input rst,

    input en_row_counter,
    input inz_row_counter,
    input en_pe_counter,
    input inz_pe_counter,
    input en_counter_k,
    input inz_counter_k,

    input row_i_shift,

    input load_rf,
    
    input is_lsb,
    input is_valid,

    input write,
    input a_address,
    input b_address,
    input out_address,

    output co_row_counter,
    output co_pe_counter,
    output co_counter_k,

    output reg [SUM_WIDTH-1:0] out
);

    wire [SUM_WIDTH-1:0] r_data;
    wire [DATA_WIDTH*N_REGS-1:0] row_i_out;
    wire [2:0] row_counter_out;
    wire [3:0] pe_counter_out;
    wire [2:0] counter_k_out;

    counter #(
        .WIDTH(3)   
        ) row_counter(
        .clk(clk),
        .rst(rst),
        .en(en_row_counter),
        .inz(inz_row_counter),
        .count(row_counter_out),
        .co2(co_row_counter)
    );

    counter #(
        .WIDTH(4)   
        ) pe_counter(
        .clk(clk),
        .rst(rst),
        .en(en_pe_counter),
        .inz(inz_pe_counter),
        .count(pe_counter_out),
        .co(co_pe_counter)
    );

    counter #(
        .WIDTH(3)   
        ) counter_k(
        .clk(clk),
        .rst(rst),
        .en(en_counter_k),
        .inz(inz_counter_k),
        .count(counter_k_out),
        .co(co_counter_k)
    );

    shift_register row_i_shreg(
        .clk(clk),
        .rst(rst),
        .in(r_data[DATA_WIDTH-1:0]),
        .shift(row_i_shift),
        .out(row_i_out)
    );

    wire [7:0] rf_out;
    register_file rf(
        .clk(clk),
        .rst(rst),
        .load_rf(load_rf),
        .address(counter_k_out),
        .data_in(r_data[DATA_WIDTH-1:0]),
        .select(pe_counter_out),
        .data_out(rf_out)
    );

    wire is_msb;
    assign is_msb = is_valid & (pe_counter_out == 0);
    wire [33:0] pe_out1, pe_out0;
    stripes_pe #(
        .VEC_WIDTH(VEC_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .SUM_WIDTH(SUM_WIDTH)
    ) stripes_pe1(
        .clk(clk),
        .rst(rst),
        .i_vec_a_bits(rf_out[7:4]),
        .b(row_i_out[DATA_WIDTH*N_REGS-1:DATA_WIDTH*N_REGS/2]),
        .init_sum({SUM_WIDTH{1'b0}}),
        .is_msb(is_msb),
        .is_lsb(is_lsb),
        .valid(is_valid),
        .out(pe_out1)
    );

    stripes_pe #(
        .VEC_WIDTH(VEC_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .SUM_WIDTH(SUM_WIDTH)
    ) stripes_pe0(
        .clk(clk),
        .rst(rst),
        .i_vec_a_bits(rf_out[3:0]),
        .b(row_i_out[DATA_WIDTH*N_REGS/2-1:0]),
        .init_sum({SUM_WIDTH{1'b0}}),
        .is_msb(is_msb),
        .is_lsb(is_lsb),
        .valid(is_valid),
        .out(pe_out0)
    );

    wire [SUM_WIDTH-1:0] w_data;
    assign w_data = pe_out1 + pe_out0;

    wire [ADDR_WIDTH-1:0] mem_address;
    assign mem_address = a_address      ? counter_k_out :
                         b_address      ? (row_counter_out * N_REGS + counter_k_out + N_REGS) :
                         out_address    ? (64 + N_REGS + row_counter_out) :
                                          0;
    memory #(
        .WORD_WIDTH(SUM_WIDTH),
        .DEPTH(128),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) memory(
        .clk(clk),
        .rst(rst),
        .write(write),
        .address(mem_address),
        .w_data(w_data),
        .r_data(r_data)
    );




    

endmodule