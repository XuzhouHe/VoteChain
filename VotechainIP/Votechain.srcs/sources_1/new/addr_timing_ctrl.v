`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2018 11:35:09 PM
// Design Name: 
// Module Name: addr_timing_ctrl
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

module addr_timing_ctrl #  (parameter BW = 31, wAddr_BW = 5, nAddr_BW = 5, msgAddr_BW = 16)(
input clk,
input rst,
output reg [wAddr_BW:0] w_processing_counter,
output reg [wAddr_BW:0] w_processing_counter_1,
output reg [wAddr_BW:0] w_processing_counter_2,
output [msgAddr_BW-1:0] msg_ram_read_addr,
output w_ram_we,
output [wAddr_BW:0] w_ram_addr_R1,
output [wAddr_BW:0] w_ram_addr_R2,
output [wAddr_BW:0] w_ram_addr_R3,
output [wAddr_BW:0] w_ram_addr_R4
    );
    
    
    always @(posedge clk)
    begin
        if(!rst)
            w_processing_counter <= 0;
        else
            begin
                if(w_processing_counter == 63) 
                    w_processing_counter <= 0;
                else
                    w_processing_counter <= w_processing_counter + 1;
            end
    end
    
    always @(posedge clk)
    begin
       if(!rst)
           w_processing_counter_1 <= 0;
       else
           w_processing_counter_1 <= w_processing_counter;
    end
    
    always @(posedge clk)
    begin
        if(!rst)
            w_processing_counter_2 <= 0;
        else
            begin
                if(w_processing_counter_2 == 4 && w_processing_counter == 63) 
                    w_processing_counter_2 <= 0;
                else if(w_processing_counter == 63)
                    w_processing_counter_2 <= w_processing_counter_2 + 1;
            end
    end

    // msg_ram read address
    assign msg_ram_read_addr = (w_processing_counter<16)?w_processing_counter:32'bz;

    // w_ram write enable
    assign w_ram_we = 1;
    // w_ram read address
    assign w_ram_addr_R1 = (w_processing_counter>=16)?(w_processing_counter-2):0;
    assign w_ram_addr_R2 = (w_processing_counter>=16)?(w_processing_counter-7):0;
    assign w_ram_addr_R3 = (w_processing_counter>=16)?(w_processing_counter-15):0;
    assign w_ram_addr_R4 = (w_processing_counter>=16)?(w_processing_counter-16):0;

endmodule
