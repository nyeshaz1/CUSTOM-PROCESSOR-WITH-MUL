module tb_ImmGen();
    
    logic [31:0] inst;
    logic [31:0] imm_out;
    
    ImmGen dut (
        .inst(inst),
        .imm_out(imm_out)
    );
    
    initial begin
        // Initialize
        inst = 0;
        
        // Test I-type (ADDI, LW, etc.)
        #10 inst = 32'hFAB0_0013;  // ADDI x0, x1, -1360 (sign-extended negative)
        #10 inst = 32'h0000_0093;  // ADDI x1, x0, 0 (positive)
        #10 inst = 32'h0000_0093;  // LUI x1, 0 (testing opcode 7'b0110111 but not in case)
        
        // Test S-type (SW)
        #10 inst = 32'hFE512E23;  // SW x5, -4(x10) negative offset
        #10 inst = 32'h00552623;  // SW x5, 12(x10) positive offset
        
        // Test B-type (BEQ, BNE, etc.)
        #10 inst = 32'hFE029AE3;  // BNE x5, x0, -12 negative offset
        #10 inst = 32'h00A38863;  // BEQ x7, x10, 16 positive offset
        
        // Test default case (non-matching opcode)
        #10 inst = 32'hFFFFFFFF;  // Invalid opcode (all 1s)
        #10 inst = 32'h00000000;  // All zeros
        
        // Test U-type (not in case - should go to default)
        #10 inst = 32'h12345037;  // LUI x0, 0x12345 (opcode 0110111)
        
        // Test J-type (not in case - should go to default)
        #10 inst = 32'h1234506F;  // JAL x0, 0x12345 (opcode 1101111)
        
        #10 $finish;
    end
endmodule