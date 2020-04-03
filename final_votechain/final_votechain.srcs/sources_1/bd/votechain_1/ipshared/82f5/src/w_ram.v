`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2018 03:42:27 PM
// Design Name: 
// Module Name: w_ram
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

module w_ram #  (parameter BW = 31, wAddr_BW = 5, nAddr_BW = 5, msgAddr_BW = 6)(
input clk,
input we,
input [wAddr_BW:0] addr_W,
input [BW:0] data_in,
input [wAddr_BW:0] addr_R1,
input [wAddr_BW:0] addr_R2,
input [wAddr_BW:0] addr_R3,
input [wAddr_BW:0] addr_R4,

output [BW:0] data_out1,
output [BW:0] data_out2,
output [BW:0] data_out3,
output [BW:0] data_out4
    );
        
    parameter ram_size = 63;
    reg [BW:0] ram[ram_size:0];
    
    reg [wAddr_BW:0] addr_R1_reg;
    reg [wAddr_BW:0] addr_R2_reg;
    reg [wAddr_BW:0] addr_R3_reg;
    reg [wAddr_BW:0] addr_R4_reg;
    
    always @(posedge clk)
    begin
        if(we)
            ram[addr_W] <= data_in;
        
        addr_R1_reg <= addr_R1;
        addr_R2_reg <= addr_R2;
        addr_R3_reg <= addr_R3;
        addr_R4_reg <= addr_R4;
    end
    
    assign data_out1 = ram[addr_R1_reg];
    assign data_out2 = ram[addr_R2_reg]; 
    assign data_out3 = ram[addr_R3_reg]; 
    assign data_out4 = ram[addr_R4_reg];    
    
endmodule
