module tb_PC();
    parameter width = 32;
    
    logic clk, rst;
    logic [width-1:0] addr, pc_next;
    
    PC #(width) dut (
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .pc_next(pc_next)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        addr = 0;
        
        // Test reset
        #10;
        rst = 0;
        
        // Test normal operation with sequential addresses
        #10 addr = 32'h0000_0004;
        #10 addr = 32'h0000_0008;
        #10 addr = 32'h0000_000C;
        #10 addr = 32'h0000_0010;
        
        // Test jump to arbitrary address
        #10 addr = 32'h1000_0000;
        
        // Test reset in middle of operation
        #10 rst = 1;
        #10 rst = 0;
        
        // Test more addresses after reset
        #10 addr = 32'h2000_0000;
        #10 addr = 32'h2000_0004;
        
        #10 $finish;
    end
endmodule