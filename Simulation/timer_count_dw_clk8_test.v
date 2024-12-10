// Create Date: 12/07/2024 02:11:53 PM
// Design Name: 
// Module Name: timer_count_dw_clk8_test
// Project Name: 
// 
//////////////////////////////////////////////////////////////////////////////////


module timer_count_dw_clk8_test;
    reg [7:0] wdata, address, rdata;
    test_bench top();
    
    //Test process
    initial begin
        #40;
        $display("==================================");
        $display("========COUNT DW TEST CLK8=============");
        $display("==================================");
        $display("-STEP-\n");
        $display("At time = %5d, write_data TCR \n", $time);
        top.cpu.apb_write(8'h00, 8'hff);
        #1;
        top.cpu.apb_write(8'h01, 8'h82); //1000_0010 => 1 load | 0 dw | 0 en |10 clk8
        
        top.cpu.apb_write(8'h01, 8'h32); //0011_0010 => 0 not load | 1 dw | 1 en | 10 clk8
        $display("-----------------------------------");
        $display("--STEP2-- \n");
        $display("At time = %5d, wait UDF \n", $time);
        repeat(2048) begin
            @(posedge top.pclk);
        end
        
        $display("--STEP3--\n");
        $display("At time = %5d, after 256 clk_in, read_data TSR \n", $time);
        top.cpu.apb_read(8'h02, rdata);
        if(rdata == 8'h02)
            $display("At time = %5d, TSR = 8'h%2h, UNDERFLOW --PASS--\n", $time, rdata);
        else begin
            top.fail = 1'b1;
            $display("At time = %5d, TSR = 8'h%2h, NOT_UNDERFLOW --FAIL--\n", $time, rdata);
        end
        $display("------------------------------------\n");
        $finish();
    end
endmodule
