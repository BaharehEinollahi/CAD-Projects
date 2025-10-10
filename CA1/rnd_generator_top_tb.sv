`timescale 1ns/1ns

module rnd_generator_top_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg start_rnd;
    reg [5:0] parallel_in;
    wire [1:0] rnd_out;
    wire done_rnd;

    // Instantiate the DUT (Device Under Test)
    rnd_generator_top dut (
        .clk(clk),
        .rst(rst),
        .start_rnd(start_rnd),
        .parallel_in(parallel_in),
        .rnd_out(rnd_out),
        .done_rnd(done_rnd)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 0;
        start_rnd = 0;
        parallel_in = 6'b0;

        // Apply reset
        #10 rst = 1;
        #10 rst = 0;

        // Test case 1: Load parallel input and start random generation
        #10 parallel_in = 6'b101010;
        start_rnd = 1;
        #10 start_rnd = 0;

        #200 $stop;
        // // Wait for done signal
        // wait(done_rnd);
        // $display("Random Output: %b", rnd_out);

        // // Test case 2: Another random generation
        // #20 parallel_in = 6'b110011;
        // start_rnd = 1;
        // #10 start_rnd = 0;

        // // Wait for done signal
        // wait(done_rnd);
        // $display("Random Output: %b", rnd_out);

        // // Finish simulation
        // #50 $stop;
    end

endmodule