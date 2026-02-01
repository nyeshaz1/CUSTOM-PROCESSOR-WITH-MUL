module tb_CU();
    
    logic [31:0] instruction;
    logic zero, lt, ltu;
    logic [3:0] ALUCtrl;
    logic RegWrite, ALUSrc, MemWrite, MemRead, Branch, branch_taken;
    logic [1:0] MemtoReg;
    
    CU dut (
        .instruction(instruction),
        .zero(zero),
        .lt(lt),
        .ltu(ltu),
        .ALUCtrl(ALUCtrl),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .branch_taken(branch_taken)
    );
    
    initial begin
        // Initialize all inputs
        instruction = 0;
        zero = 0;
        lt = 0;
        ltu = 0;
        
        // Test R-type: ADD
        #10 instruction = 32'h00000033;  // ADD
        
        // Test R-type: SUB
        #10 instruction = 32'h40000033;  // SUB
        
        // Test I-type: ADDI
        #10 instruction = 32'h00000013;  // ADDI
        
        // Test I-type: ANDI
        #10 instruction = 32'h00007013;  // ANDI
        
        // Test LOAD: LW
        #10 instruction = 32'h00002003;  // LW
        
        // Test STORE: SW
        #10 instruction = 32'h00002023;  // SW
        
        // Test JAL
        #10 instruction = 32'h000000EF;  // JAL
        
        // Test JALR
        #10 instruction = 32'h00000067;  // JALR
        
        // Test B-type: BEQ (branch not taken)
        #10 instruction = 32'h00000063;  // BEQ
        zero = 0;  // rs1 != rs2, branch not taken
        
        // Test BEQ (branch taken)
        #10 instruction = 32'h00000063;  // BEQ
        zero = 1;  // rs1 == rs2, branch taken
        
        // Test BNE (branch taken)
        #10 instruction = 32'h00100063;  // BNE
        zero = 0;  // rs1 != rs2, branch taken
        
        // Test BNE (branch not taken)
        #10 instruction = 32'h00100063;  // BNE
        zero = 1;  // rs1 == rs2, branch not taken
        
        // Test BLT (branch taken)
        #10 instruction = 32'h40000063;  // BLT
        lt = 1;  // rs1 < rs2, branch taken
        
        // Test BLT (branch not taken)
        #10 instruction = 32'h40000063;  // BLT
        lt = 0;  // rs1 >= rs2, branch not taken
        
        // Test BGE (branch taken)
        #10 instruction = 32'h40100063;  // BGE
        lt = 0;  // rs1 >= rs2, branch taken
        
        // Test BGE (branch not taken)
        #10 instruction = 32'h40100063;  // BGE
        lt = 1;  // rs1 < rs2, branch not taken
        
        // Test BLTU (branch taken)
        #10 instruction = 32'h60000063;  // BLTU
        ltu = 1;  // rs1 < rs2 (unsigned), branch taken
        
        // Test BLTU (branch not taken)
        #10 instruction = 32'h60000063;  // BLTU
        ltu = 0;  // rs1 >= rs2 (unsigned), branch not taken
        
        // Test BGEU (branch taken)
        #10 instruction = 32'h60100063;  // BGEU
        ltu = 0;  // rs1 >= rs2 (unsigned), branch taken
        
        // Test BGEU (branch not taken)
        #10 instruction = 32'h60100063;  // BGEU
        ltu = 1;  // rs1 < rs2 (unsigned), branch not taken
        
        // Test LUI (from commented code)
        #10 instruction = 32'h00000037;  // LUI
        zero = 0; lt = 0; ltu = 0;
        
        // Test AUIPC (from commented code)
        #10 instruction = 32'h00000017;  // AUIPC
        zero = 0; lt = 0; ltu = 0;
        
        // Test invalid instruction (default)
        #10 instruction = 32'hFFFFFFFF;  // Invalid
        
        #10 $finish;
    end
endmodule