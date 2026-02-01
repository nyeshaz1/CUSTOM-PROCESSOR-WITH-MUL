module tb_PCWalaMUX();
    
    logic [31:0] addr, sum, res;
    logic branch, zero_flag;
    
    PCWalaMUX dut (
        .addr(addr),
        .sum(sum),
        .branch(branch),
        .zero_flag(zero_flag),
        .res(res)
    );
    
    initial begin
        // Initialize
        addr = 32'h0000_1000;
        sum = 32'h0000_2000;
        branch = 0;
        zero_flag = 0;
        
        // Test 1: branch=0, zero_flag=0 (should output addr)
        #10 branch = 0; zero_flag = 0;
        
        // Test 2: branch=0, zero_flag=1 (should output addr)
        #10 branch = 0; zero_flag = 1;
        
        // Test 3: branch=1, zero_flag=0 (should output addr)
        #10 branch = 1; zero_flag = 0;
        
        // Test 4: branch=1, zero_flag=1 (should output sum)
        #10 branch = 1; zero_flag = 1;
        
        // Change values and test again
        #10;
        addr = 32'hAAAA_AAAA;
        sum = 32'h5555_5555;
        
        #10 branch = 0; zero_flag = 0;
        #10 branch = 0; zero_flag = 1;
        #10 branch = 1; zero_flag = 0;
        #10 branch = 1; zero_flag = 1;
        
        // Test edge cases with zeros
        #10;
        addr = 32'h0000_0000;
        sum = 32'hFFFF_FFFF;
        
        #10 branch = 0; zero_flag = 0;
        #10 branch = 1; zero_flag = 1;
        
        // Test when addr and sum are same
        #10;
        addr = 32'h1234_5678;
        sum = 32'h1234_5678;
        
        #10 branch = 0; zero_flag = 0;
        #10 branch = 1; zero_flag = 1;
        
        #10 $finish;
    end
endmodule