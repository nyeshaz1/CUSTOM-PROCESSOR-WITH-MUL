`timescale 1ns / 1ps

module tb_TOPMODULE;
    // Parameters matching your TOPMODULE
    parameter width = 32;
    parameter depth = 1024; // Instruction Memory Depth
    parameter D = 32;       // Register File Depth
    parameter OP = 7;
    parameter MEM_BYTES = 1024; // Data Memory Size
    parameter CLK_PERIOD = 10;  // 10ns Clock

    // Inputs
    logic clk;
    logic rst;

    // Outputs (Debug Signals from TOPMODULE)
    logic branch_taken;
    logic [width-1:0] addr;        // PC
    logic [width-1:0] instruction;
    logic [31:0] mul_debug;
    logic [width-1:0] dataW, dataR, data1, data2, imm_out, data2_MUX;
    logic [1:0] MemtoReg; 
    logic RegWrite, MemWrite, ALUSrc, MemRead, Branch;
    logic [3:0] ALUCtrl;
    logic [width-1:0]  pc_next, rs1_MUX, branch_target;
    
    // Instantiate the Device Under Test (DUT)
    TOPMODULE #(
        .width(width),
        .depth(depth),
        .D(D),
        .OP(OP),
        .MEM_BYTES(MEM_BYTES)
    ) dut (
        .clk(clk),
        .rst(rst),
        .branch_taken(branch_taken),
        .addr(addr),
        .instruction(instruction),
        .dataW(dataW),
        .dataR(dataR),
        .data1(data1),
        .data2(data2),
        .imm_out(imm_out),
        .data2_MUX(data2_MUX),
        
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .Branch(Branch),
        .ALUCtrl(ALUCtrl),
       
        .pc_next(pc_next),        
        .rs1_MUX(rs1_MUX),
        .branch_target(branch_target),
        .mul_debug(mul_debug)
    );

    // Clock Generation (10ns period)
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Test Stimulus
    initial begin
        // 1. Start with Reset Active
        rst = 1;

        // 2. Hold Reset for 5 Clock Cycles
        // This is CRITICAL to clear the Multiplier's 'X' states
        repeat(5) @(posedge clk);

        // 3. Release Reset on Negative Edge
        // This prevents race conditions at the clock edge
        @(negedge clk);
        rst = 0;

        // 4. Run Simulation
        // The multiplication instruction takes ~340ns (34 cycles).
        // We run for 1000ns to ensure the whole program finishes.
        #1000;

        // 5. End Simulation
        $finish;
    end

endmodule