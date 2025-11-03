`timescale 1ns/1ps

module vector_mult_top_tb;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] a0, w0, a1, w1;
    wire [15:0] result;
    wire ready;

    vector_mult_top uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a0(a0),
        .w0(w0),
        .a1(a1),
        .w1(w1),
        .result(result),
        .ready(ready)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        start = 0;
        a0 = 0; w0 = 0;
        a1 = 0; w1 = 0;
        #20 rst = 0;
        #10;
        a0 = 8'd3; w0 = 8'd4;
        a1 = 8'd2; w1 = 8'd5;
        start = 1;
        #10 start = 0;
        wait(ready);
        // #10;
        // a0 = 8'd1; w0 = 8'd2;
        // a1 = 8'd3; w1 = 8'd4;
        // start = 1;
        // #10 start = 0;
        // wait(ready);
        #20;
        $stop;
    end

endmodule
