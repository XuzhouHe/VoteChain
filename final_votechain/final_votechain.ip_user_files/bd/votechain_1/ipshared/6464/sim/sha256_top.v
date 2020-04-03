`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2018 10:48:28 PM
// Design Name: 
// Module Name: sha256_top
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

module sha256_top #  (parameter BW = 31, wAddr_BW = 5, nAddr_BW = 5, msgAddr_BW = 16)(
    input clk,
    input rst,
    input [BW:0] msg_data_in,
    
    output [msgAddr_BW-1:0] msg_ram_read_addr,
    output [wAddr_BW:0] extend_w_out_index,
    output [BW:0] extend_w_out,
    output update_h_w_finish,
    output update_h_w_finish_2,
    output [wAddr_BW:0] update_h_h_index_out,
    output [BW:0] h0,
    output [BW:0] h1,
    output [BW:0] h2,
    output [BW:0] h3,
    output [BW:0] h4,
    output [BW:0] h5,
    output [BW:0] h6,
    output [BW:0] h7
    );
    
    
    wire [wAddr_BW:0] w_processing_counter;
    wire [wAddr_BW:0] w_processing_counter_1;
    wire [wAddr_BW:0] w_processing_counter_2;
    // w_ram input
    wire w_ram_we;
    wire [wAddr_BW:0] w_ram_addr_R1;
    wire [wAddr_BW:0] w_ram_addr_R2;
    wire [wAddr_BW:0] w_ram_addr_R3;
    wire [wAddr_BW:0] w_ram_addr_R4;
    
    
addr_timing_ctrl #  (.BW(BW),.wAddr_BW(wAddr_BW),.nAddr_BW(nAddr_BW),.msgAddr_BW(msgAddr_BW)) addr_timing_ctrl1(
    .clk(clk),
    .rst(rst),
    .w_processing_counter(w_processing_counter),
    .w_processing_counter_1(w_processing_counter_1),
    .w_processing_counter_2(w_processing_counter_2),
    .msg_ram_read_addr(msg_ram_read_addr),
    .w_ram_we(w_ram_we),
    .w_ram_addr_R1(w_ram_addr_R1),
    .w_ram_addr_R2(w_ram_addr_R2),
    .w_ram_addr_R3(w_ram_addr_R3),
    .w_ram_addr_R4(w_ram_addr_R4)
        );
    
    // w_ram output
    wire [BW:0] w_ram_data_out1;
    wire [BW:0] w_ram_data_out2;
    wire [BW:0] w_ram_data_out3;
    wire [BW:0] w_ram_data_out4;
    
    
    
w_ram #  (.BW(BW),.wAddr_BW(wAddr_BW),.nAddr_BW(nAddr_BW),.msgAddr_BW(msgAddr_BW)) w_ram1(
    .clk(clk),
    .we(w_ram_we),
    .addr_W(extend_w_out_index),
    .data_in(extend_w_out),
    .addr_R1(w_ram_addr_R1),
    .addr_R2(w_ram_addr_R2),
    .addr_R3(w_ram_addr_R3),
    .addr_R4(w_ram_addr_R4),
    
    .data_out1(w_ram_data_out1),
    .data_out2(w_ram_data_out2),
    .data_out3(w_ram_data_out3),
    .data_out4(w_ram_data_out4)
       );
    
extend # (.BW(BW),.wAddr_BW(wAddr_BW),.nAddr_BW(nAddr_BW),.msgAddr_BW(msgAddr_BW)) extend1(
    .w_in_index(w_processing_counter_1),
    .w_in(msg_data_in),
    .w_j_2(w_ram_data_out1),
    .w_j_7(w_ram_data_out2),
    .w_j_15(w_ram_data_out3),
    .w_j_16(w_ram_data_out4),

    .w_out_index(extend_w_out_index),
    .w_out(extend_w_out)
       );
       
update_h # (.BW(BW),.wAddr_BW(wAddr_BW),.nAddr_BW(nAddr_BW),.msgAddr_BW(msgAddr_BW)) update_h1(
    .clk(clk),
    .rst(rst),
    .w_in_index(extend_w_out_index),
    .w_in_index_2(w_processing_counter_2),
    .w_in(extend_w_out),
    .w_finish(update_h_w_finish),
    .w_finish_2(update_h_w_finish_2),
    .h_out_index(update_h_h_index_out),
    .h0(h0),
    .h1(h1),
    .h2(h2),
    .h3(h3),
    .h4(h4),
    .h5(h5),
    .h6(h6),
    .h7(h7)     
        );
    
endmodule
