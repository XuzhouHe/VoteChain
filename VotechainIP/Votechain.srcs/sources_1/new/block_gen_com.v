`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2019 01:41:35 PM
// Design Name: 
// Module Name: block_gen_com
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


module block_gen_com#(parameter C_S_AXI_ADDR_WIDTH = 6, C_S_AXI_DATA_WIDTH = 32, CLK_PERIOD = 33.33)( 
    // Axi4Lite signals 
    input S_AXI_ACLK ,
    input S_AXI_ARESETN ,
    input [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR ,
    input  S_AXI_AWVALID ,
    output  S_AXI_AWREADY ,
    input  [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA ,
    input  [3:0] S_AXI_WSTRB ,
    input  S_AXI_WVALID ,
    output S_AXI_WREADY ,
    output [1:0] S_AXI_BRESP ,
    output S_AXI_BVALID ,
    input  S_AXI_BREADY ,
    input  [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR ,
    input  S_AXI_ARVALID ,
    output S_AXI_ARREADY ,
    output [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA ,
    output [1:0] S_AXI_RRESP ,
    output S_AXI_RVALID ,
    input  S_AXI_RREADY,

    // IO BRAM
    
    // IO Data Mining
    
    // IO Controller
    input configQ,
    input system_onQ,
    input enableGB_Q,
    output reg config_bg_done,
    output reg receiving,
    output reg received_not_valid,
    output reg send_done
    
    // IO Blockchain Memory
    
    );
    
wire     [C_S_AXI_ADDR_WIDTH-1:0]    wrAddr ;
wire     [C_S_AXI_DATA_WIDTH-1:0]    wrData ;
wire                                 wrS ;
wire     [C_S_AXI_ADDR_WIDTH-1:0]    rdAddr ;
reg      [C_S_AXI_DATA_WIDTH-1:0]    rdData ;
wire                                 rdS ;

Axi4LiteSupporter #(.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH)) Axi4LiteSupporter1 (
    // Simple Bus
    .wrAddr(wrAddr),                   // output   [C_S_AXI_ADDR_WIDTH-1:0]
    .wrData(wrData),                    // output   [C_S_AXI_DATA_WIDTH-1:0]
    .wr(wrS),                            // output
    .rdAddr(rdAddr),                    // output   [C_S_AXI_ADDR_WIDTH-1:0]
    .rdData(rdData),                    // input    [C_S_AXI_ADDR_WIDTH-1:0]
    .rd(rdS),                            // output   
    // Axi4Lite Bus
    .S_AXI_ACLK(S_AXI_ACLK),            // input
    .S_AXI_ARESETN(S_AXI_ARESETN),      // input
    .S_AXI_AWADDR(S_AXI_AWADDR),        // input    [C_S_AXI_ADDR_WIDTH-1:0]
    .S_AXI_AWVALID(S_AXI_AWVALID),      // input
    .S_AXI_AWREADY(S_AXI_AWREADY),      // output
    .S_AXI_WDATA(S_AXI_WDATA),          // input    [C_S_AXI_DATA_WIDTH-1:0]
    .S_AXI_WSTRB(S_AXI_WSTRB),          // input    [3:0]
    .S_AXI_WVALID(S_AXI_WVALID),        // input
    .S_AXI_WREADY(S_AXI_WREADY),        // output        
    .S_AXI_BRESP(S_AXI_BRESP),          // output   [1:0]
    .S_AXI_BVALID(S_AXI_BVALID),        // output
    .S_AXI_BREADY(S_AXI_BREADY),        // input
    .S_AXI_ARADDR(S_AXI_ARADDR),        // input    [C_S_AXI_ADDR_WIDTH-1:0]
    .S_AXI_ARVALID(S_AXI_ARVALID),      // input
    .S_AXI_ARREADY(S_AXI_ARREADY),      // output
    .S_AXI_RDATA(S_AXI_RDATA),          // output   [C_S_AXI_DATA_WIDTH-1:0]
    .S_AXI_RRESP(S_AXI_RRESP),          // output   [1:0]
    .S_AXI_RVALID(S_AXI_RVALID),        // output    
    .S_AXI_RREADY(S_AXI_RREADY)         // input
    ) ;

//FSM States
parameter WAIT = 0, INIT = 1, LISTEN = 2, RECEIVE = 3, VALID = 4, GENERATE = 5, SEND = 6;
reg [3:0] nextState, currentState;

always @ * begin  
    nextState = currentState;
    
    case(currentState)
        WAIT: begin
            if(configQ == 1) begin
                // configure buffers <----
                config_bg_done = 1;
                nextState = INIT;
            end
        end
        INIT: begin
          if(system_onQ == 1)begin
            nextState = LISTEN;
          end
        end
        LISTEN: begin
//            if(we are receiving a block)begin <----
//                output receiving = 1;
//                nextState = RECEIVE;
//            end
            if(enableGB_Q == 1)begin
                nextState = GENERATE;
            end
//            if(listening is turned off)begin <----
//                nextState = INIT;
//            end
        end
        RECEIVE: begin
           // Receive the incoming block <----
           nextState = VALID;
        end
        VALID: begin
//            if(received block is valid)begin <----
//                nextState = SEND;
//            end
//            else if(received block is not valid) begin <----
//                received_not_valid = 1;
//                nextState = LISTEN;
//            end
        end
        GENERATE: begin
            // Generate the new block <----
            nextState = SEND;
        end
        SEND: begin
           // Send data <----
           send_done = 1;
           nextState = LISTEN;
        end
        default:begin
            nextState = WAIT; 
        end     
    endcase
end



//Sequential Logic
always @ (posedge S_AXI_ACLK) begin
    if (!S_AXI_ARESETN) begin
        currentState <= WAIT;
    end else begin
        currentState <= nextState;
    end
end 

endmodule
