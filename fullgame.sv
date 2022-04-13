//multimode counter
// n is number of bits
parameter n = 4;
module main_counter (
    init,
    initial_val,
    control,
    clk,
    winner,
    loser,
    rst
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
    always @(posedge init) begin
        if(init) begin
            count = initial_val;
        end
    end
    //process
    always @(posedge clk) begin
        loser = 0;
        winner = 0;
        if(rst) begin
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
          else if(count == '1) begin
                winner = 1;
            end
        end
    end
endmodule

//plain binary counter
module flag_counter(
trigger,
rst,
clk,
flag
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

//determining the winner module
    module who_wins(
        winner_flag,
        loser_flag,
        gameover,
        clk,
        who
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
    
module full_game(
    init,
    initial_val,
    control,
    clk,
    gameover,
    who);
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
    //who wins
    who_wins ww(
        .winner_flag(winner_flag),
        .loser_flag(loser_flag),
        .gameover(gameover),
        .clk(clk),
        .who(who)
    );
endmodule