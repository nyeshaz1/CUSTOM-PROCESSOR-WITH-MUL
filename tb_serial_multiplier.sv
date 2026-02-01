`timescale 1ns / 1ps

module tb_serial_multiplier;

    // Inputs
    logic clk;
    logic rst;
    logic start;
    logic [2:0] funct3;
    logic signed [31:0] A;
    logic signed [31:0] B;

    // Outputs
    logic [63:0] result_64;
    logic [31:0] result;
    logic ready;
    logic stall;

    // Debug Outputs (Optional - can leave unconnected if not in your DUT)
    logic [31:0] count_out;
    logic [63:0] product_out;
    logic [31:0] multiplier_out;
    logic [31:0] multiplicand_out;

    // ---------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // ---------------------------------------------------------
    serial_multiplier uut (
        .clk(clk), 
        .rst(rst), 
        .start(start), 
        .funct3(funct3), 
        .A(A), 
        .B(B), 
        .result_64(result_64), 
        .result(result), 
        .ready(ready), 
        .stall(stall),
        // Connect debug ports (or remove these lines if you removed them from DUT)
        .count_out(count_out),
        .product_out(product_out),
        .multiplier_out(multiplier_out),
        .multiplicand_out(multiplicand_out)
    );

    // ---------------------------------------------------------
    // Clock Generation (10ns Period)
    // ---------------------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ---------------------------------------------------------
    // Task to Run a Single Test Case
    // ---------------------------------------------------------
    task run_case(input signed [31:0] opA, input signed [31:0] opB, input [2:0] f3);
    begin
        // 1. Setup Inputs
        A = opA;
        B = opB;
        funct3 = f3;

        // 2. Pulse Start (1 Clock Cycle)
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        // 3. Wait for Completion
        @(posedge ready);

        // 4. CRITICAL FIX: Wait 1 extra cycle for 'busy' to drop to 0
        // If we don't do this, the next 'start' might be ignored.
        @(posedge clk);

        // 5. Display Result
        $display("Time=%0t | A=%d, B=%d | Result=%d (Hex: %h)", 
                 $time, A, B, result, result);
    end
    endtask

    // ---------------------------------------------------------
    // Main Test Sequence
    // ---------------------------------------------------------
    initial begin
        // Initialize Inputs
        rst = 1;
        start = 0;
        funct3 = 3'b000; // Standard MUL (Signed x Signed)
        A = 0;
        B = 0;

        // Reset Pulse (Hold for 50ns to clear all 'X' values)
        #50;
        @(negedge clk);
        rst = 0;
        #20;

        $display("=== Starting Multiplier Simulation ===");

        // Case 1: Positive * Positive (5 * 3 = 15)
        run_case(5, 3, 3'b000);

        // Case 2: Negative * Negative (-4 * -4 = 16)
        run_case(-4, -4, 3'b000);

        // Case 3: Positive * Negative (2 * -3 = -6)
        run_case(2, -3, 3'b000);

        // Case 4: Negative * Positive (-10 * 10 = -100)
        run_case(-10, 10, 3'b000);

        // Case 5: Zero Multiplication (123 * 0 = 0)
        run_case(123, 0, 3'b000);

        // Case 6: Large Numbers
        run_case(1000, 1000, 3'b000);

        $display("=== Simulation Complete ===");
        $finish;
    end

endmodule