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