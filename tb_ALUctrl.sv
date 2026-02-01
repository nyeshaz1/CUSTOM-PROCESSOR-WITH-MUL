module tb_ALUctrl();
    
    logic [1:0] ALUOp;
    logic [31:0] instruction;
    logic zero, lt, ltu;
    logic branch_taken;
    logic [3:0] ALUCtrl;
    
    ALUctrl dut (
        .ALUOp(ALUOp),
        .instruction(instruction),
        .zero(zero),
        .lt(lt),
        .ltu(ltu),
        .branch_taken(branch_taken),
        .ALUCtrl(ALUCtrl)
    );
    
    initial begin
        // Initialize all inputs
        ALUOp = 0;
        instruction = 0;
        zero = 0;
        lt = 0;
        ltu = 0;
        
        // Test ALUOp = 00 (default to ADD)
        #10 ALUOp = 2'b00;
        
        // Test ALUOp = 01 (Branch operations)
        #10 ALUOp = 2'b01;
        // BEQ: func3=000
        #10 instruction = 32'h0000_0063;  // opcode=1100011, func3=000
        zero = 1;  // Should take branch
        #10 zero = 0;  // Should not take branch
        
        // BNE: func3=001
        #10 instruction = 32'h0010_0063;  // opcode=1100011, func3=001
        zero = 0;  // Should take branch
        #10 zero = 1;  // Should not take branch
        
        // BLT: func3=100
        #10 instruction = 32'h4000_0063;  // opcode=1100011, func3=100
        lt = 1;  // Should take branch
        #10 lt = 0;  // Should not take branch
        
        // BGE: func3=101
        #10 instruction = 32'h4010_0063;  // opcode=1100011, func3=101
        lt = 0;  // Should take branch
        #10 lt = 1;  // Should not take branch
        
        // BLTU: func3=110
        #10 instruction = 32'h6000_0063;  // opcode=1100011, func3=110
        ltu = 1;  // Should take branch
        #10 ltu = 0;  // Should not take branch
        
        // BGEU: func3=111
        #10 instruction = 32'h6010_0063;  // opcode=1100011, func3=111
        ltu = 0;  // Should take branch
        #10 ltu = 1;  // Should not take branch
        
        // Test ALUOp = 10 (R-type and I-type)
        #10 ALUOp = 2'b10;
        
        // Test R-type instructions
        #10 instruction = 32'h00000033;  // ADD: func7=0000000, func3=000
        #10 instruction = 32'h40000033;  // SUB: func7=0100000, func3=000
        #10 instruction = 32'h00007033;  // AND: func7=0000000, func3=111
        #10 instruction = 32'h00006033;  // OR: func7=0000000, func3=110
        #10 instruction = 32'h00004033;  // XOR: func7=0000000, func3=100
        #10 instruction = 32'h00001033;  // SLL: func7=0000000, func3=001
        #10 instruction = 32'h00005033;  // SRL: func7=0000000, func3=101
        #10 instruction = 32'h40005033;  // SRA: func7=0100000, func3=101
        #10 instruction = 32'h00002033;  // SLT: func7=0000000, func3=010
        #10 instruction = 32'h00003033;  // SLTU: func7=0000000, func3=011
        
        // Test I-type instructions
        #10 instruction = 32'h00000013;  // ADDI: func3=000
        #10 instruction = 32'h00007013;  // ANDI: func3=111
        #10 instruction = 32'h00006013;  // ORI: func3=110
        #10 instruction = 32'h00004013;  // XORI: func3=100
        #10 instruction = 32'h00002013;  // SLTI: func3=010
        #10 instruction = 32'h00003013;  // SLTIU: func3=011
        #10 instruction = 32'h00001013;  // SLLI: func3=001
        #10 instruction = 32'h00005013;  // SRLI: func3=101, func7=0000000
        #10 instruction = 32'h40005013;  // SRAI: func3=101, func7=0100000
        
        // Test invalid func3/func7 combinations
        #10 instruction = 32'hFFFFFFFF;  // All ones
        
        #10 $finish;
    end
endmodule