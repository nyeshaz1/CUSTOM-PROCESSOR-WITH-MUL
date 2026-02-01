module tb_CTRLlgc();
    
    logic [31:0] instruction;
    logic Branch, MemRead, MemWrite, ALUSrc, RegWrite;
    logic [1:0] MemtoReg, ALUOp;
    
    CONTROLlogic dut (
        .instruction(instruction),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );
    
    initial begin
        // Initialize
        instruction = 0;
        
        // Test R-type instructions (ADD, SUB, etc.)
        #10 instruction = 32'h00000033;  // ADD
        #10 instruction = 32'h40000033;  // SUB
        #10 instruction = 32'h00007033;  // AND
        
        // Test I-type instructions (ADDI, ANDI, etc.)
        #10 instruction = 32'h00000013;  // ADDI
        #10 instruction = 32'h00007013;  // ANDI
        #10 instruction = 32'h00002013;  // SLTI
        
        // Test LOAD instruction (LW)
        #10 instruction = 32'h00002003;  // LW
        
        // Test STORE instruction (SW)
        #10 instruction = 32'h00002023;  // SW
        
        // Test JAL (Jump and Link)
        #10 instruction = 32'h000000EF;  // JAL
        
        // Test JALR (Jump and Link Register)
        #10 instruction = 32'h00000067;  // JALR
        
        // Test B-type instructions (branches)
        #10 instruction = 32'h00000063;  // BEQ
        #10 instruction = 32'h00100063;  // BNE
        #10 instruction = 32'h40000063;  // BLT
        
        // Test LUI (Load Upper Immediate) - from commented code
        #10 instruction = 32'h00000037;  // LUI
        
        // Test AUIPC (Add Upper Immediate to PC) - from commented code
        #10 instruction = 32'h00000017;  // AUIPC
        
        // Test default case (invalid opcode)
        #10 instruction = 32'hFFFFFFFF;  // Invalid instruction
        #10 instruction = 32'h00000000;  // All zeros
        
        // Test some edge cases
        #10 instruction = 32'h12345633;  // Custom function
        #10 instruction = 32'h9ABCDEF3;  // Another custom
        
        #10 $finish;
    end
endmodule