// Design Name: 
// Module Name: tdr_wr_rd_test
// Project Name:
// 
//////////////////////////////////////////////////////////////////////////////////

module tdr_wr_rd_test();

    //INPUT
    integer a = 0;
    reg[7:0] wdata, rdata, address;
    //reg fail_flag=0;
    //testbench
    test_bench top();
    
    initial begin
        //reset depend on system_signal
        #100;
        $display("=================================");
        $display("=======TEST WRITE READ TDR=======");
        $display("=================================");
        
        repeat(20) begin
            a = a + 1;
            $display("\nTest No. %3d",a);
            wdata = $random();
            address = 8'h00;
            top.cpu.apb_write(address, wdata);
            top.cpu.apb_read(address, rdata);
            
            if(wdata != rdata) begin
                $display("At time %4d, wdata = 8'h%2h, rdata = 8'h%2h, -- ERROR --", $time, wdata, rdata);
                top.fail = 1'b1;
            end 
            else begin
                $display("At time %4d, wdata = 8'h%2h, rdata = 8'h%2h, -- PASS --", $time, wdata, rdata);
            end 
        end
        #500;
        top.display_result();
        $finish();
    end 

endmodule
