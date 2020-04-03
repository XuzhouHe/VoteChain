`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 06:17:57 PM
// Design Name: 
// Module Name: blk_mem_gen_1
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


module sram #(parameter ADDR_WIDTH = 16, DATA_WIDTH = 32, DEPTH = 12800) (
    input  i_clk,
    input  [ADDR_WIDTH-1:0] we_addr, 
    input  [ADDR_WIDTH-1:0] rd_addr, 
    input  i_write,
    input  [DATA_WIDTH-1:0] we_data,
    output  [DATA_WIDTH-1:0] rd_data 
    );

    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1]; 
    reg [ADDR_WIDTH-1:0] addr_R_reg;
    
    
    always @ (posedge i_clk)
    begin
        if(i_write) begin
            memory_array[we_addr] <= we_data;
        end
        addr_R_reg <= rd_addr;
    end
    
     assign rd_data = memory_array[addr_R_reg];
endmodule
