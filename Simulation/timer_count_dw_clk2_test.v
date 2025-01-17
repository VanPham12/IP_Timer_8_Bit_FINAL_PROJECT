// Create Date: 12/05/2024 09:37:32 PM
// Design Name: 
// Module Name: timer_count_dw_clk2_test
// Project Name: 
// 
//////////////////////////////////////////////////////////////////////////////////


module timer_count_dw_clk2_test;
    reg [7:0] wdata, address, rdata;
    test_bench top();
    
    //Test process
    initial begin
        #40;
        $display("=========================================");
        $display("==========TEST WRITE READ TSR============");
        $display("=========================================");
        $display("-STEP1-\n");
        $display("At time = %5d, write_data TCR \n", $time);
        //load data in TDR=> load TDR in COUNTER (TCR)
        
        top.cpu.apb_write(8'h00, 8'h05);
        #1;
        top.cpu.apb_write(8'h01, 8'h80); //1000_0000 => 1 load | 0 dw | 0 en | 00 clk2
        top.cpu.apb_write(8'h01, 8'h30); //0011_0000 => 0 not load | 1 dw | 1 en | 00 clk2
        $display("-----------------------------------"); 
        
        
        $display("--STEP2-- \n");
        $display("At time = %5d, wait UDF \n", $time);
        repeat(12) begin
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
        
        
        $display("--STEP4--\n");
        $display("At time = %5d, clear TSR \n", $time);
        top.cpu.apb_write(8'h02, 8'h00);
        $display("------------------------------------\n");
        
        $display("--STEP5--\n");
        $display("At time = %5d, read_data TSR \n", $time);
        top.cpu.apb_read(8'h02, rdata);
        if(rdata == 8'h00) begin
            $display("At time = %5d, TSR = 8'h%2h \n", $time, rdata);
            $display("BIT UNDERFLOW CLEAR --PASS-- \n");
        end 
        else begin
            $display("At time = %5d, TSR = 8'h%2h \n", $time, rdata);
            top.fail = 1'b1;
            $display("BIT UNDERFLOW NOT CLEAR --FAIL--\n");
        end
        $display("--------------------------------");
        #100;
        top.display_result();
        #100;
        $finish();
    end
endmodule
