module tb_BrAdd();
    
    logic [31:0] pc, imm_out, sum;
    
    BranchAdder dut (
        .pc(pc),
        .imm_out(imm_out),
        .sum(sum)
    );
    
    initial begin
        // Initialize inputs
        pc = 32'h0000_0000;
        imm_out = 32'h0000_0000;
        
        // Test basic addition with positive immediate
        #10 pc = 32'h0000_1000;
        imm_out = 32'h0000_0004;  // imm_out << 1 = 8, sum = 0x1008
        
        // Test with negative immediate (two's complement)
        #10 pc = 32'h0000_1000;
        imm_out = 32'hFFFF_FFFC;  // -4, after <<1 = -8, sum = 0x0FF8
        
        // Test larger immediate
        #10 pc = 32'h1000_0000;
        imm_out = 32'h0000_1000;  // <<1 = 0x2000, sum = 0x1000_2000
        
        // Test zero case
        #10 pc = 32'h2000_0000;
        imm_out = 32'h0000_0000;  // <<1 = 0, sum = 0x2000_0000
        
        // Test with maximum positive immediate
        #10 pc = 32'h0000_0000;
        imm_out = 32'h7FFF_FFFF;  // <<1 = 0xFFFF_FFFE, sum = 0xFFFF_FFFE
        
        // Test with minimum negative immediate
        #10 pc = 32'h0000_0000;
        imm_out = 32'h8000_0000;  // <<1 = 0x0000_0000 (overflow), sum = 0x0000_0000
        
        // Test random values
        #10 pc = 32'h1234_5678;
        imm_out = 32'h0000_ABCD;  // <<1 = 0x0001_579A, sum = 0x1235_AE12
        
        #10 $finish;
    end
endmodule