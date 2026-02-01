module tb_ALU();
    parameter width = 32;
    
    // Test bench signals
    logic [width-1:0] rs1, rs2_MUX;
    logic [3:0] ALUCtrl;
    logic [width-1:0] alu_out;
    logic zero, lt, ltu;
    
    // Instantiate the ALU
    ALU #(width) dut (
        .rs1(rs1),
        .rs2_MUX(rs2_MUX),
        .ALUCtrl(ALUCtrl),
        .alu_out(alu_out),
        .zero(zero),
        .lt(lt),
        .ltu(ltu)
    );
    
    initial begin
        // Initialize inputs
        rs1 = 0;
        rs2_MUX = 0;
        ALUCtrl = 0;
        
        // Test ADD
        #10;
        rs1 = 32'h00000005;
        rs2_MUX = 32'h00000003;
        ALUCtrl = 4'b0010;
        #10;
        
        // Test SUB
        rs1 = 32'h0000000A;
        rs2_MUX = 32'h00000003;
        ALUCtrl = 4'b0110;
        #10;
        
        // Test AND
        rs1 = 32'hF0F0F0F0;
        rs2_MUX = 32'h0F0F0F0F;
        ALUCtrl = 4'b0000;
        #10;
        
        // Test OR
        rs1 = 32'hF0F0F0F0;
        rs2_MUX = 32'h0F0F0F0F;
        ALUCtrl = 4'b0001;
        #10;
        
        // Test XOR
        rs1 = 32'hAAAAAAAA;
        rs2_MUX = 32'h55555555;
        ALUCtrl = 4'b0011;
        #10;
        
        // Test SLL (shift left logical)
        rs1 = 32'h00000001;
        rs2_MUX = 32'h00000004;  // Shift by 4
        ALUCtrl = 4'b0100;
        #10;
        
        // Test SRL (shift right logical)
        rs1 = 32'h80000000;
        rs2_MUX = 32'h00000001;  // Shift by 1
        ALUCtrl = 4'b0101;
        #10;
        
        // Test SRA (shift right arithmetic)
        rs1 = 32'h80000000;
        rs2_MUX = 32'h00000001;  // Shift by 1
        ALUCtrl = 4'b0111;
        #10;
        
        // Test SLT (set less than - signed)
        rs1 = 32'hFFFFFFFE;  // -2 in two's complement
        rs2_MUX = 32'h00000001;  // 1
        ALUCtrl = 4'b1000;
        #10;
        
        // Test SLTU (set less than - unsigned)
        rs1 = 32'h00000001;  // 1
        rs2_MUX = 32'hFFFFFFFF;  // 4294967295
        ALUCtrl = 4'b1001;
        #10;
        
        // Test edge case: zero flag for SUB
        rs1 = 32'h0000000A;
        rs2_MUX = 32'h0000000A;
        ALUCtrl = 4'b0110;
        #10;
        
        // Test default case
        ALUCtrl = 4'b1111;
        #10;
        
        $finish;
    end
endmodule
