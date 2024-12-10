// Create Date: 12/01/2024 11:12:43 PM
// Design Name: 
// Module Name: system_signal
//////////////////////////////////////////////////////////////////////////////////


module system_signal(
    output reg pclk,
    output reg presetn
    );
    
    initial begin
        pclk = 0;
        #10;
        forever #10 pclk = ~pclk;
    end 
    
    initial begin
        presetn = 1;
        #20;
        presetn = 0;
        #20;
        presetn = 1;
    end 
    
endmodule
