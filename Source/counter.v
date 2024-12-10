// Create Date: 12/03/2024 10:57:44 PM
// Design Name: 
// Module Name: counter
// Project Name: 
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input clk_in, presetn,
    input en, load, ud,
    input[7:0] reg_tdr,
    output reg [7:0] cnt,
    output reg [7:0] last_cnt
    );
    
    //COUNTER 
    always @(posedge clk_in or negedge presetn) begin
        if(!presetn)
            cnt <= 1'b0;
        else begin
            if(load == 1'b1)
                cnt <= reg_tdr;
                else begin
                    if(en == 1'b0)          //TCR[4]
                        cnt <= cnt;
                    else 
                        if(ud == 1'b1)
                            cnt <= cnt - 1'b1;
                        else
                            cnt <= cnt + 1'b1;
                end 
        end
    end 
    
    //LAST_CNT
    always @(posedge clk_in or negedge presetn)
        if(!presetn)
            last_cnt <= 8'h00;
        else 
            last_cnt <= cnt;
    
endmodule
