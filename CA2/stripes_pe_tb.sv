`timescale 1ns/1ns

module stripes_pe_tb;
    // Testbench signals
    reg clk;
    reg rst;
    reg [3:0] i_vec_a_bits;
    reg [63:0] b;
    reg is_msb;
    reg valid;
    wire [33:0] out;

    // Instantiate the DUT
    stripes_pe dut (
        .clk(clk),
        .rst(rst),
        .i_vec_a_bits(i_vec_a_bits),
        .b(b),
        .is_msb(is_msb),
        .valid(valid),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize waveform dumping
        $dumpfile("stripes_pe_tb.vcd");
        $dumpvars(0, stripes_pe_tb);

        // Initialize inputs
        rst = 1;
        i_vec_a_bits = 0;
        b = 0;
        is_msb = 0;
        valid = 0;

        // Wait for 100 ns and release reset
        #10;
        rst = 0;
        
        // Test Case 1: Simple multiplication
        // Testing with a = 4'b0001 and b = 64'h0000_0000_0000_0001
        @(posedge clk);
        i_vec_a_bits = 4'b0001;
        b = 64'b0001000000100000_0001000100111000_001000100001001_0010000010010010;
        is_msb = 0;
        valid = 1;
        #10;

        // Test Case 2: MSB multiplication
        @(posedge clk);
        i_vec_a_bits = 4'b1111;
        b = 64'b0001000000100000_0001000100111000_001000100001001_0010000010010010;
        is_msb = 1;
        valid = 1;
        #10;

        // Test Case 3: Zero input
        @(posedge clk);
        i_vec_a_bits = 4'b0000;
        b = 64'b0001000000100000_0001000100111000_001000100001001_0010000010010010;
        is_msb = 0;
        valid = 1;
        #10;

        // Test Case 4: All ones with valid low
        @(posedge clk);
        i_vec_a_bits = 4'b1111;
        b = 64'b0001000000100000_0001000100111000_001000100001001_0010000010010010;
        is_msb = 1;
        valid = 0;
        #10;

        // Add more test cases here as needed

        // End simulation
        #100;
    end

    // Monitor changes
    always @(posedge clk) begin
        if (!rst) begin
            $display("Time=%0t i_vec_a_bits=%b b=%h is_msb=%b valid=%b out=%h",
                    $time, i_vec_a_bits, b, is_msb, valid, out);
        end
    end

endmodule