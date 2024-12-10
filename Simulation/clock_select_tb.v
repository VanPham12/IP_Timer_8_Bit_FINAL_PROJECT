//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/24/2024 10:49:14 PM
// Design Name: 
// Module Name: clock_select_tb
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module clock_select_tb();
    reg pclk;
    reg presetn;
    reg [1:0]cks;
    wire clk_in;
    
    clock_select uut(
        .pclk(pclk),
        .presetn(presetn),
        .cks(cks),
        .clk_in(clk_in)
    );
    
    initial begin
        pclk = 0;
        presetn = 1;
        #100;
        presetn = 0;
        #100;
        presetn = 1;
        cks = 2'b00;
        #300;
        cks = 2'b01;
        #300;
        cks = 2'b10;
        #500;
        cks = 2'b11;
        #1700;
        $finish();
    end
    
        always
        begin
            pclk=~pclk;
            #10;
        end

endmodule
