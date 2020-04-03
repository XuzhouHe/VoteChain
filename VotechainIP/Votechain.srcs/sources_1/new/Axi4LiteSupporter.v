`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2019 01:49:35 PM
// Design Name: 
// Module Name: Axi4LiteSupporter
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

// Axi4Lite Supporter module declaration
module Axi4LiteSupporter #  (parameter C_S_AXI_ADDR_WIDTH = 6, C_S_AXI_DATA_WIDTH = 32)
    (
        // Simple Bus
        output reg  [C_S_AXI_ADDR_WIDTH-1:0] wrAddr,
        output reg  [C_S_AXI_DATA_WIDTH-1:0] wrData,
        output reg  wr,
        output reg  [C_S_AXI_ADDR_WIDTH-1:0] rdAddr,
        input       [C_S_AXI_DATA_WIDTH-1:0] rdData,
        output reg  rd,
        // Axi4Lite Bus
        input       S_AXI_ACLK,
        input       S_AXI_ARESETN,
        input       [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR,
        input       S_AXI_AWVALID,
        output reg  S_AXI_AWREADY,
        input       [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
        input       [3:0] S_AXI_WSTRB,
        input       S_AXI_WVALID,
        output reg  S_AXI_WREADY,
        output reg  [1:0] S_AXI_BRESP,
        output reg  S_AXI_BVALID,
        input       S_AXI_BREADY,
        input       [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR,
        input       S_AXI_ARVALID,
        output reg  S_AXI_ARREADY,
        output reg  [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
        output reg  [1:0] S_AXI_RRESP,
        output reg  S_AXI_RVALID,
        input       S_AXI_RREADY
    );
    
 //FSM States
       parameter IDLE=0, RD1 = 1, WR1 = 2;
       reg [3:0] nextState, currentState;
       //Read Flops
       reg [C_S_AXI_ADDR_WIDTH-1:0] rdAddrD, rdAddrQ ;
       //Write Flops
       reg [C_S_AXI_ADDR_WIDTH-1:0] wrAddrD, wrAddrQ ;
       reg [C_S_AXI_DATA_WIDTH-1:0] wrDataD, wrDataQ ;
       
       //Combinational Logic
       always @ * begin
           nextState = currentState;
           //Read outputs
           rdAddrD = rdAddrQ;
           rd = 0;
           rdAddr = 0;
        
           S_AXI_ARREADY = 0;
           S_AXI_RDATA = 0;
           S_AXI_RVALID = 0;
           S_AXI_RRESP = 0;
                
           //Write outputs
           wrAddrD = wrAddrQ;
           wrDataD = wrDataQ;
           wr = 0;
           wrAddr = 0;
           wrData = 0;
           
           S_AXI_AWREADY = 0;
           S_AXI_WREADY = 0;
           S_AXI_BVALID= 0;
           S_AXI_BRESP = 0;
           
           case (currentState)
               IDLE: begin
                   if ( S_AXI_ARVALID ) begin
                       rdAddrD = S_AXI_ARADDR;
                       nextState = RD1;
                   end
                   else if ( S_AXI_AWVALID ) begin
                       wrAddrD = S_AXI_AWADDR;
                       wrDataD = S_AXI_WDATA;
                       nextState = WR1;
                   end
               end
               RD1: begin
                   rdAddr = rdAddrQ;
                   rd = 1; // tell regs that read address is on the bus 
                   S_AXI_ARREADY = 1; //address received
                   S_AXI_RDATA = rdData; // send out data from regs to manager
                   S_AXI_RVALID = 1;
                   if(S_AXI_RREADY) begin
                        nextState = IDLE;
                   end
                      
               end
               WR1: begin
               
               
                   wrAddr = wrAddrQ;
                   wrData = wrDataQ;
                   wr = 1;
                   S_AXI_AWREADY = 1;
                   S_AXI_WREADY = 1;
                   S_AXI_BVALID = 1;
                   nextState = IDLE;
                                
              
               end
               default:begin
                   nextState = IDLE;
               end
           endcase
           
       end
       
       //Sequential Logic
       always @ (posedge S_AXI_ACLK) begin
           if (!S_AXI_ARESETN) begin
               currentState <= IDLE;
               rdAddrQ <= 0;
               wrAddrQ <= 0;
               wrDataQ <= 0;
           end else begin
               currentState <= nextState;
               rdAddrQ <= rdAddrD;
               wrAddrQ <= wrAddrD;
               wrDataQ <= wrDataD;
               
           end
       end 
    
    
endmodule