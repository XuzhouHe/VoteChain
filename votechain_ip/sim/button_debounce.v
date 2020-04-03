`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2019 01:21:48 PM
// Design Name: 
// Module Name: test_button
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module button_debounce(
    input BTNU,
    input BTND,
    input BTNR,
    input BTNL,
    input BTNC,
    input clk,
    input rst,
    input getVote,
    output reg [4:0] votes
    );

reg slow_clk;
reg Q1a,Q1b;
reg Q2a,Q2b;
reg Q3a,Q3b;
reg Q4a,Q4b;
reg Q5a,Q5b;

reg newVote;

reg [26:0]counter=0;

wire [4:0] vote;

always @(posedge clk) begin     
    counter <= (counter>=249999)?0:counter+1;
    slow_clk <= (counter < 125000)?1'b1:1'b0;
    
    newVote <= (counter == 0 && getVote == 1)?1'b1:1'b0;
    
    votes <= (newVote==1)? vote:0;
      
end

always @ (posedge slow_clk) begin
    Q1a <= BTNU;
    Q1b <= Q1a;
    
    Q2a <= BTNC;
    Q2b <= Q2a;
    
    Q3a <= BTND;
    Q3b <= Q3a;
    
    Q4a <= BTNL;
    Q4b <= Q4a;
    
    Q5a <= BTNR;
    Q5b <= Q5a;
end

assign vote[0] = Q1a & ~Q1b;
assign vote[1] = Q2a & ~Q2b;
assign vote[2] = Q3a & ~Q3b;
assign vote[3] = Q4a & ~Q4b;
assign vote[4] = Q5a & ~Q5b;
    
endmodule

//module debounce(
//    input BTNU,
//    clk,
//    output LD0
//    );

//wire slow_clk;
//wire Q1,Q2,Q2_bar;

//clock_div u1(clk,slow_clk);
//my_dff d1(slow_clk, BTNU,Q1 );
//my_dff d2(slow_clk, Q1,Q2 );
//assign Q2_bar = ~Q2;
//assign LD0 = Q1 & Q2_bar;
//endmodule
//// Slow clock for debouncing 
//module clock_div(input Clk_100M, output reg slow_clk

//    );
//    reg [26:0]counter=0;
//    always @(posedge Clk_100M)
//    begin
//        counter <= (counter>=249999)?0:counter+1;
//        slow_clk <= (counter < 125000)?1'b0:1'b1;
//    end
//endmodule
//// D-flip-flop for debouncing module 
//module my_dff(input DFF_CLOCK, D, output reg Q);

//    always @ (posedge DFF_CLOCK) begin
//        Q <= D;
//    end

//endmodule

//https://www.fpga4student.com/2017/04/simple-debouncing-verilog-code-for.html


