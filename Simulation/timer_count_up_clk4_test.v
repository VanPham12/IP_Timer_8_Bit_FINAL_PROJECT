// Create Date: 12/05/2024 11:18:35 PM
// Design Name: 
// Module Name: timer_count_up_clk4_test
// Project Name: 
//
//////////////////////////////////////////////////////////////////////////////////


module timer_count_up_clk4_test;
    reg [7:0] wdata, address, rdata;
    test_bench top();
    
    //Test process
    initial begin
        #100;
        $display("==================================");
        $display("========COUNT UP TEST CLK4========");
        $display("==================================");
        $display("-STEP1-\n");
        $display("At time = %5d, write_data TCR \n", $time);
        top.cpu.apb_write(8'h01, 8'h11);        //0001_0001 => 0 not load | 0 up | 1 en 01 clk4
        $display("-----------------------------------");
        
        
        $display("--STEP2-- \n");
        $display("At time = %5d, wait OVF \n", $time);
        repeat(1024) begin
            @(posedge top.pclk);
        end
        
        $display("--STEP3--\n");
        $display("At time = %5d, after 256 clk_in, read_data TSR \n", $time);
        top.cpu.apb_read(8'h02, rdata);
        if(rdata == 8'h01)
        $display("At time = %5d, TSR = 8'h%2h, OVERFLOW --PASS--\n", $time, rdata);
        else begin
            top.fail = 1'b1;
            $display("At time = %5d, TSR = 8'h%2h, NOT_OVERFLOW --FAIL--\n", $time, rdata);
        end
        $display("------------------------------------\n");
        $finish();
    end
endmodule
