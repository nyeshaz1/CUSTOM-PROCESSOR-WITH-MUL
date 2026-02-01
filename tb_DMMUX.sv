module tb_DMMUX();
    parameter width = 32;
    
    logic [width-1:0] alu_out, dataR, pc_plus_4, dataW;
    logic [1:0] selectLine;
    
    MUX_DM #(width) dut (
        .alu_out(alu_out),
        .dataR(dataR),
        .pc_plus_4(pc_plus_4),
        .selectLine(selectLine),
        .dataW(dataW)
    );
    
    initial begin
        // Initialize inputs
        alu_out = 32'hAAAA_AAAA;
        dataR = 32'h5555_5555;
        pc_plus_4 = 32'h0000_0004;
        selectLine = 2'b00;
        
        // Test all select line cases
        #10 selectLine = 2'b00;  // Select dataR
        #10 selectLine = 2'b01;  // Select alu_out
        #10 selectLine = 2'b10;  // Select pc_plus_4
        #10 selectLine = 2'b11;  // Default case (should select alu_out)
        
        // Change inputs and test again
        #10;
        alu_out = 32'h1234_5678;
        dataR = 32'h8765_4321;
        pc_plus_4 = 32'h0000_0008;
        selectLine = 2'b00;
        #10 selectLine = 2'b01;
        #10 selectLine = 2'b10;
        #10 selectLine = 2'b11;
        
        #10 $finish;
    end
endmodule