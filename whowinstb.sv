//who wins module testbench
module who_winstb(
    winner_flag,
    loser_flag,
    gameover,
    clk,
    who
);
//parameters
parameter CYCLE = 20;
//declaration of inputs and outputs
input gameover,who;
output winner_flag,loser_flag,clk;
//declaration of internal signals
wire gameover,who;
reg winner_flag,loser_flag,clk;
//initialization of internal signals
initial begin
    winner_flag = 1;
    loser_flag = 0;
  	#(2*CYCLE) winner_flag=0;
end
initial begin
  clk = 0;
  forever begin
        #(CYCLE);
        clk = ~clk;
    end
end
//process
who_wins ww(
    .winner_flag(winner_flag),
    .loser_flag(loser_flag),
    .gameover(gameover),
    .clk(clk),
    .who(who),
);
initial begin
    $dumpfile("who_wins_tb.vcd");
    $dumpvars;
    #1400
    $finish;
end
endmodule