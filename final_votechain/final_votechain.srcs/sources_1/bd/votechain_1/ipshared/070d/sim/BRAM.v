`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2019 02:11:46 PM
// Design Name: 
// Module Name: BRAM
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


module BRAM#(parameter ADDR_WIDTH = 16, DATA_WIDTH = 32 )
 (
 input S_AXI_ACLK ,
 input S_AXI_ARESETN ,
 // IO Controller
input configQ,
output reg config_bram_done,
// input config_bram_done,
 
input dm_done,

 
 // controller signals
 input controller_ena,
 input [ADDR_WIDTH-1:0] controller_addr,
 input [DATA_WIDTH-1:0] controller_data,
 
  // data validation signals
 input dv_ena,
 input [ADDR_WIDTH-1:0] dv_addr,
 input [DATA_WIDTH-1:0] dv_data,
 
  // data mining signals
 input dm_ena,
 input [ADDR_WIDTH-1:0] dm_addr,
 input [ADDR_WIDTH-1:0] dm_read_addr,
 input [DATA_WIDTH-1:0]  dm_data,
 output [DATA_WIDTH-1:0] dm_read_data
 
//  // gen comm signals
// input gc_rd_ena,
// input gc_wr_ena,
// input [ADDR_WIDTH-1:0] gc_addr,
// input [DATA_WIDTH-1:0] gc_data_in,
// output reg [DATA_WIDTH-1:0] gc_data_out

 
 
 );
 
 
 reg write_ena;
 reg [ADDR_WIDTH-1:0] write_addr;
 reg [DATA_WIDTH-1:0]write_data;

parameter WAIT = 0, CONFIG = 1, NORMAL = 2, SEND = 3;
reg [3:0] nextState, currentState;

reg [31:0] config_indexQ, config_indexD;

 sram blockchain_memory(
 .i_clk (S_AXI_ACLK),
 .we_addr (write_addr),
 .rd_addr (dm_read_addr),
 .i_write (write_ena),
 .we_data (write_data),
 .rd_data (dm_read_data)
 
 );
 
 always @ * begin 
     nextState = currentState;
     write_ena = 0;
     write_addr = 0;
     write_data = 0;
     config_bram_done = 0;
     config_indexD = config_indexQ;
     
     case(currentState)
         WAIT: begin
            if(configQ ==1)begin
                nextState = CONFIG;
                config_indexD = 0;
            end else begin
                nextState = WAIT;
            end    
         end
         CONFIG: begin
            if(config_indexQ < 12800)begin
                write_ena = 1;
                write_addr = config_indexQ;
                write_data = 0;
                config_indexD = config_indexQ +1;
            end else begin
                config_bram_done = 1;
                nextState = NORMAL;
            end
         end
         NORMAL: begin
//            if(dm_done ==1)begin
//                nextState = SEND;
//            end else begin
//                nextState = NORMAL;
//            end
            if (controller_ena || dv_ena || dm_ena) begin
                 write_ena = 1;
             end
             if (controller_ena) begin
                 write_addr = controller_addr;
                 write_data = controller_data;
             end else begin
                 if (dv_ena) begin
                     write_addr = dv_addr;
                     write_data = dv_data;
                 end else begin
                     if (dm_ena) begin
                         write_addr = dm_addr;
                         write_data = dm_data;
                     end
                 end
             end
         
         end
         SEND: begin
            nextState = NORMAL;
         end
         default:begin
             nextState = WAIT; 
         end
     
     
     endcase
     
     
end

always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN) begin
        currentState <= WAIT;
        config_indexQ <= 0;
    end else begin
        currentState <= nextState;
        config_indexQ <= config_indexD;
    end
end
 
 

 
endmodule
