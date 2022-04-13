//winner plain binary counter testbench
//parameters
parameter CYCLE = 20;
module flag_counter_tb(
    winner,
    rst,
    clk,
    winner_gameover
);
    //declaration of declaration of inputs and outputs
    input winner_gameover;
    output winner,rst,clk;
    //declaration of internal variables
    wire winner_gameover;
    reg winner,rst,clk;
    //initialization
    initial begin
        clk = 0;
        rst = 0;
        winner = 0;
        forever begin
                #(CYCLE);
                clk = ~clk;
                winner = ~winner;
            end
    end
    //process
    flag_counter w1(
        .trigger(winner),
        .rst(rst),
        .clk(clk),
        .flag(winner_gameover)
    );
    initial begin
        $dumpfile("flag_counter_tb.vcd");
        $dumpvars;
        #1400
        $finish;
    end
endmodule