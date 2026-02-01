module tb_MUX2();
    
    logic [31:0] addr, data1, rs1;
    logic select;
    
    MUX_befALU dut (
        .addr(addr),
        .data1(data1),
        .select(select),
        .rs1(rs1)
    );
    
    initial begin
        // Initialize inputs
        addr = 32'hAAAA_AAAA;
        data1 = 32'h5555_5555;
        select = 0;
        
        // Test select = 0 (should output data1)
        #10 select = 0;
        
        // Test select = 1 (should output addr)
        #10 select = 1;
        
        // Change inputs and test both again
        #10;
        addr = 32'h1234_5678;
        data1 = 32'h8765_4321;
        
        #10 select = 0;
        #10 select = 1;
        
        // Test with all zeros
        #10;
        addr = 32'h0000_0000;
        data1 = 32'h0000_0000;
        select = 0;
        #10 select = 1;
        
        // Test with all ones
        #10;
        addr = 32'hFFFF_FFFF;
        data1 = 32'hFFFF_FFFF;
        select = 0;
        #10 select = 1;
        
        // Test with different values
        #10;
        addr = 32'h0000_0001;
        data1 = 32'h0000_0002;
        select = 0;
        #10 select = 1;
        
        #10 $finish;
    end
endmodule