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