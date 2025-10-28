`timescale 1ns/1ns

module stripes_pe_tb;
    reg clk;
    reg rst;
    reg [3:0] i_vec_a_bits;
    reg [63:0] b;
    reg [33:0] init_sum;
    reg is_msb;
    reg is_lsb;
    reg valid;
    wire [33:0] out;

    reg [15:0] a[0:3];
    reg [15:0] b_array[0:3];
    int i;


    stripes_pe dut (
        .clk(clk),
        .rst(rst),
        .i_vec_a_bits(i_vec_a_bits),
        .b(b),
        .init_sum(init_sum),
        .is_msb(is_msb),
        .is_lsb(is_lsb),
        .valid(valid),
        .out(out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
    init_sum = 0;
    rst = 1;
    i_vec_a_bits = 0;
    b = 0;
    is_msb = 0;
    is_lsb = 0;
    valid = 0;

    #10;
    rst = 0;

    a[0] = 16'd1;
    a[1] = -16'sd4;
    a[2] = 16'd6;
    a[3] = 16'd3;

    b_array[0] = 16'd2;
    b_array[1] = 16'd6;
    b_array[2] = -16'sd1;
    b_array[3] = 16'd7;

    
    b = {b_array[0], b_array[1], b_array[2], b_array[3]};
    
    for (i = 15; i >= 0; i--) begin
        @(posedge clk);
        i_vec_a_bits = {a[0][i], a[1][i], a[2][i], a[3][i]};
        is_msb = (i == 15);
        is_lsb = (i == 0);
        valid = 1;
        #10;
    end
    #10
    valid = 0;

    #100;
    $stop;
end

endmodule