//multimode counter
// n is number of bits
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

//determining the winner module
//determines the state of each game winner or loser
module game_state(
    winner_flag,        //when winner_flag is 1, the game is over and the who is set to 2
    loser_flag,         //when loser_flag is 1, the game is over and the who is set to 1
    gameover,           //gameover signal, it is 1 when the game is over
    clk,                //clock
    who                 //who signal
);
    //declaration of inputs and outputs
    input winner_flag, loser_flag,clk;
    output who,gameover;
    //declaration of internal signals
    wire winner_flag,loser_flag,clk;
    reg[1:0] who;
    reg gameover;
    //initialization of internal signals
    initial begin
        who=0;
        gameover=0;
    end
    //process
    //who signal is 0 by default
    //who signal is 1 if the game is over and the loser_flag is 1
    //who signal is 2 if the game is over and the winner_flag is 2
    //gameover signal is 1 if the game is over
    always @(posedge clk) begin
            gameover=0;
            who=0;
            if(winner_flag) begin
                 who=2;
                 gameover=1;
            end
            else if(loser_flag) begin 
                who=1;
                gameover=1;
            end
            else begin
                who=0;
                gameover=0;
            end
    end
endmodule

//integrating the modules    
module full_game(
    init,           //init flag to load initial value for the counter
    initial_val,    //initial value of counter will be loaded if init is 1
    control,        //control the mode of counter
    clk,            //clock
    gameover,       //gameover signal, it is 1 when the game is over
    who             //who signal, determines the state of the game (winner or loser)
    );
    //declaration of inputs and outputs
    input init,initial_val,control,clk;
    output gameover,who;
    //declaration of internal signals
    wire init,clk;
  	wire[1:0] control;
    wire[3:0] initial_val;
    reg[1:0] who;
    reg gameover,winner,loser,winner_flag,loser_flag;
    //processes
    //multimode counter
    main_counter mc(
        .init(init),
        .clk(clk),
        .control(control),
        .initial_val(initial_val),
        .winner(winner),
        .loser(loser),
        .rst(gameover)
    );
    //winner flag counter
    flag_counter winner_fc(
        .trigger(winner),
        .clk(clk),
        .rst(gameover),
        .flag(winner_flag)
    );
    //losers flag counter
    flag_counter loser_fc(
        .trigger(loser),
        .clk(clk),
        .rst(gameover),
        .flag(loser_flag)
    );
    //game state detector
    game_state gs(
        .winner_flag(winner_flag),
        .loser_flag(loser_flag),
        .gameover(gameover),
        .clk(clk),
        .who(who)
    );
endmodule