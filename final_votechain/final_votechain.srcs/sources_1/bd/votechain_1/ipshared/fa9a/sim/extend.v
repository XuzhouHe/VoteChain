`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2018 03:43:49 PM
// Design Name: 
// Module Name: extend
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

module extend #  (parameter BW = 31, wAddr_BW = 5, nAddr_BW = 5, msgAddr_BW = 3)(
input [wAddr_BW:0] w_in_index,
input [BW:0] w_in,
input [BW:0] w_j_2,
input [BW:0] w_j_7,
input [BW:0] w_j_15,
input [BW:0] w_j_16,

output [wAddr_BW:0] w_out_index,
output reg [BW:0] w_out
    );
     
    // update w_out  
    always @(*)
    begin
     if(w_in_index < 16)
        w_out <= w_in;
     else
     begin
        // msg >= 16 (w[0], w[1], w[9], w[14])
        // s0 = (w[j-15] rightrotate 7) xor (w[j-15] rightrotate 18) xor (w[j-15] rightshift 3)
        // s1 = (w[j-2] rightrotate 17) xor (w[j-2] rightrotate 19) xor (w[j-2] rightshift 10)
        // w[j] = w[j-16] + s0 + w[j-7] + s1
        w_out <= w_j_16 + w_j_7
                + ({w_j_15[6:0], w_j_15[31:7]} ^ {w_j_15[17:0], w_j_15[31:18]} ^ {w_j_15[2:0], w_j_15[31:3]})
                + ({w_j_2[16:0], w_j_2[31:17]} ^ {w_j_2[18:0], w_j_2[31:19]} ^ {w_j_2[9:0], w_j_2[31:10]});
     end        
    end
    
    assign w_out_index = w_in_index;
       
endmodule
