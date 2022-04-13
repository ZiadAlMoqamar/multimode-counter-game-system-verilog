//multimode counter
//n is number of bits
parameter n = 4;
module main_counter (
    init,           //init flag to load initial value for the counter
    initial_val,    //initial value of counter will be loaded if init is 1
    control,        //control the mode of counter
    clk,            //clock
    winner,         //winner signal, it will be 1 if the counter == '1
    loser,          //loser signal, it will be 1 if the counter == 0
    rst             //reset signal
);
    //declaration of inputs and outputs
    input  control,clk,init,initial_val,rst;
    output winner,loser;
    //declaration of internal variables
    wire init,rst;
  	wire[1:0] control;
    wire[n-1:0] initial_val;
    reg winner,loser;
    reg [n-1:0] count;
    //initialization of internal variables
    initial begin 
      winner=0;
      loser=0;
      count=0;
    end
//processes
    //parallel load of initial value if init is 1
    always @(posedge init) begin
        if(init) begin
            count = initial_val;
        end
    end
    //lowering loser and winner signals after completing one cycle
    always @(posedge clk) begin
        loser = 0;
        winner = 0;
        //if reset is asserted, reset the counter
        if(rst||winner||loser) begin
            //if init is asserted, load the initial value
            if (init == 1) begin
            count=initial_val;
            end
            //else reset the counter to 0
            else begin
                count=0;
            end 
        end
        //else determine the control mode
        //if control is 0, increment the counter by 1
        //if control is 1, increment the counter by 2
        //if control is 2, decrement the counter by 1
        //if control is 3, decrement the counter by 2
        else begin
           case(control)
                0: count = count + 1;
                1: count = count + 2;
                2: count = count - 1;
                3: count = count - 2;
            endcase
            //if the counter is equal to 0, set loser to 1
            if(count == 0 ) begin
                loser = 1;
            end
            //if the counter is equal to '1, set winner to 1
            else if(count == '1) begin
                winner = 1;
            end
        end
    end
endmodule