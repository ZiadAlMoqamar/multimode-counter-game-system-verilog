//multimode counter
module main_counter (
    init,initial_val,control,clk,winner,loser,rst
);
    //declaration of inputs and outputs
    input  control,clk,init,initial_val,rst;
    output winner,loser;
    //declaration of internal variables
    wire init,rst;
  	wire[1:0] control;
    wire[3:0] initial_val;
    reg winner,loser;
    reg [3:0] count;
    //initialization of internal variables
    initial begin 
      winner=0;
      loser=0;
      count=0;
    end
    always @(posedge init) begin
        if(init) begin
            count = initial_val;
        end
    end
    //process
    always @(posedge clk) begin
        if(loser||winner||rst) begin
            loser = 0;
            winner = 0;
            if (init == 1) begin
            count=initial_val;
            end
            else begin
                count=0;
            end 
        end
        else begin
           case(control)
                0: count = count + 1;
                1: count = count + 2;
                2: count = count - 1;
                3: count = count - 2;
            endcase
          if(count == 0 ) begin
                loser = 1;
            end
          else if(count == 15) begin
                winner = 1;
            end
        end
    end
endmodule