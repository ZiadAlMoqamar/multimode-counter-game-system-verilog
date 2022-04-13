//full game testbench
module full_gametb(
    init,initial_val,control,clk,gameover,who
);
//parameters
parameter CYCLE = 2;
//declaration of inputs and outputs
input gameover,who;
output init,initial_val,control,clk;
//declaration of internal signals
wire gameover,who;
reg init,clk;
reg[1:0] control;
reg[3:0] initial_val;
//initialization of internal signals
initial begin
    init = 0;
    initial_val = 0;
    control = 0;
end
initial begin
  clk = 0;
  forever begin
        #(CYCLE);
        clk = ~clk;
    end
end
//process
full_game fg(
    .init(init),
    .initial_val(initial_val),
    .control(control),
    .clk(clk),
    .gameover(gameover),
    .who(who)
);
initial begin
    $dumpfile("full_game_tb.vcd");
    $dumpvars;
  #(15*70)
    $finish;
end
endmodule