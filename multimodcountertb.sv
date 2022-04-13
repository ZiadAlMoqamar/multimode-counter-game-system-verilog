// Code your testbench here
// or browse Examples
//4 bit counter testbench
module main_counter_tb(
init,initial_val,control,clk,winner,loser
);
    //parameters
    parameter CYCLE = 20;
    //declaration of inputs and outputs
    input  winner,loser;
    output init,initial_val,control,clk;
    //declaration of internal variables
    wire winner,loser;
    reg init,clk;
    reg[1:0] control;
    reg[3:0] initial_val;
    //initialization of internal variables
    initial begin
        initial_val = 0;
        control = 2;
        init = 0;
        clk = 0;
        forever begin
            #(CYCLE);
            clk = ~clk;
        end
    end

    //process
    main_counter m1(
        .init(init),
        .initial_val(initial_val),
        .control(control),
        .clk(clk),
        .winner(winner),
        .loser(loser)
    );

    initial begin
        $dumpfile("main_counter_tb.vcd");
        $dumpvars;
        #1400 
        $finish;
    end
endmodule