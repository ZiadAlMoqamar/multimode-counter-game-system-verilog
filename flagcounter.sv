//plain binary counter
//counts the number of winner and loser signals raised to 1
//it is instantiated two times for both winner and loser signals
module flag_counter(
trigger,        //trigger signal, either winner or loser
rst,            //reset signal to reset the counter when the game is over
clk,            //clock
flag            //flag signal, to indicate either winner or loser counted 15 times
);
//declaration of inputs and outputs
input trigger,clk,rst;
output flag;
//declaration of internal variables
wire trigger,rst;
reg [3:0] trigger_count;
reg flag;
//initialization of internal variables
initial begin 
    trigger_count = 0;
  	flag = 0;
end
//process
always @(posedge clk) begin
    //synchronous reset for the counter
    if(rst) begin
        trigger_count = 0;
        flag = 0;
    end
    //if trigger is asserted, increment the counter by 1
    else begin
        if(trigger) begin
            trigger_count = trigger_count + 1;
        end
    end
    //if the counter is equal to 15, set flag to 1
    if(trigger_count == 15) begin
        flag = 1;
    end
    //else lower the flag
    else begin
        flag = 0;
    end
end
endmodule