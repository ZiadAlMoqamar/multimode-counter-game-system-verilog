//plain binary counter
module flag_counter(
trigger,rst,clk,flag
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
    if(rst) begin
        trigger_count = 0;
        flag = 0;
    end
    else begin
        if(trigger) begin
            trigger_count = trigger_count + 1;
        end
    end
    if(trigger_count == 15) begin
        flag = 1;
    end
    else begin
        flag = 0;
    end
end
endmodule