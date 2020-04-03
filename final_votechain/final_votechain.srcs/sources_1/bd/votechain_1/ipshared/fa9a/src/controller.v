`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2019 01:27:55 PM
// Design Name: 
// Module Name: controller
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


module controller#(parameter C_S_AXI_ADDR_WIDTH = 6, C_S_AXI_DATA_WIDTH = 32, CLK_PERIOD = 33.33)( 
    // Axi4Lite signals 
    input S_AXI_ACLK ,
    input S_AXI_ARESETN ,
//    input [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR ,
//    input  S_AXI_AWVALID ,
//    output  S_AXI_AWREADY ,
//    input  [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA ,
//    input  [3:0] S_AXI_WSTRB ,
//    input  S_AXI_WVALID ,
//    output S_AXI_WREADY ,
//    output [1:0] S_AXI_BRESP ,
//    output S_AXI_BVALID ,
//    input  S_AXI_BREADY ,
//    input  [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR ,
//    input  S_AXI_ARVALID ,
//    output S_AXI_ARREADY ,
//    output [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA ,
//    output [1:0] S_AXI_RRESP ,
//    output S_AXI_RVALID ,
//    input  S_AXI_RREADY,
    
    input system_onQ,      // System on/off flag
    output reg configQ,         // Enable Configuration of all modules
 
    // IO Data Validation
    input dv_done,              // Validation Complete
    input config_dv_done,       // Configuration of DV complete
    output reg enableDV_Q,      // Enable Data Validation Module
    
    // IO Data Mining
    input dm_done,        // Mining Complete
    output reg enableDM_Q,      // Enable Data Mining Module
    
    // IO BRAM
    input config_bram_done,     // Configuration of BRAM complete
    
    // IO Blockchain memory         (NEEDED?)
    //input config_bm_done,       // Configuration of Block Memory complete
    
    // IO Block Generation/Communication
//    input config_bg_done,       // Configuration of Block Gen/Com complete
    input receiving,            // Receive flag for incoming blocks
//    input received_not_valid,   // Invalid receive block
//    input send_done,            // Sending of Block complete 
//    output reg enableGB_Q,       // Enable Block Gen/Com Module
    
    // IO BRAM
    output reg control_ena,
    output reg [31:0] bram_data,
    output reg [15:0] bram_addr
    );
    
//wire     [C_S_AXI_ADDR_WIDTH-1:0]    wrAddr ;
//wire     [C_S_AXI_DATA_WIDTH-1:0]    wrData ;
//wire                                 wrS ;
//wire     [C_S_AXI_ADDR_WIDTH-1:0]    rdAddr ;
//reg      [C_S_AXI_DATA_WIDTH-1:0]    rdData ;
//wire                                 rdS ;

//Axi4LiteSupporter #(.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH)) Axi4LiteSupporter1 (
//    // Simple Bus
//    .wrAddr(wrAddr),                   // output   [C_S_AXI_ADDR_WIDTH-1:0]
//    .wrData(wrData),                    // output   [C_S_AXI_DATA_WIDTH-1:0]
//    .wr(wrS),                            // output
//    .rdAddr(rdAddr),                    // output   [C_S_AXI_ADDR_WIDTH-1:0]
//    .rdData(rdData),                    // input    [C_S_AXI_ADDR_WIDTH-1:0]
//    .rd(rdS),                            // output   
//    // Axi4Lite Bus
//    .S_AXI_ACLK(S_AXI_ACLK),            // input
//    .S_AXI_ARESETN(S_AXI_ARESETN),      // input
//    .S_AXI_AWADDR(S_AXI_AWADDR),        // input    [C_S_AXI_ADDR_WIDTH-1:0]
//    .S_AXI_AWVALID(S_AXI_AWVALID),      // input
//    .S_AXI_AWREADY(S_AXI_AWREADY),      // output
//    .S_AXI_WDATA(S_AXI_WDATA),          // input    [C_S_AXI_DATA_WIDTH-1:0]
//    .S_AXI_WSTRB(S_AXI_WSTRB),          // input    [3:0]
//    .S_AXI_WVALID(S_AXI_WVALID),        // input
//    .S_AXI_WREADY(S_AXI_WREADY),        // output        
//    .S_AXI_BRESP(S_AXI_BRESP),          // output   [1:0]
//    .S_AXI_BVALID(S_AXI_BVALID),        // output
//    .S_AXI_BREADY(S_AXI_BREADY),        // input
//    .S_AXI_ARADDR(S_AXI_ARADDR),        // input    [C_S_AXI_ADDR_WIDTH-1:0]
//    .S_AXI_ARVALID(S_AXI_ARVALID),      // input
//    .S_AXI_ARREADY(S_AXI_ARREADY),      // output
//    .S_AXI_RDATA(S_AXI_RDATA),          // output   [C_S_AXI_DATA_WIDTH-1:0]
//    .S_AXI_RRESP(S_AXI_RRESP),          // output   [1:0]
//    .S_AXI_RVALID(S_AXI_RVALID),        // output    
//    .S_AXI_RREADY(S_AXI_RREADY)         // input
//    ) ;
    
//FSM States
parameter SETUP = 0, STOP = 1, IDLE = 2, MINING = 3, RECEIVE = 4, SEND = 5;
reg [3:0] nextState, currentState;
    
reg setup_done;
reg enableDV_D;
reg enableDM_D;
reg enableGB_D;
reg configD;

//signals for writing header
reg [3:0]  write_header_doneD;
reg [3:0]  write_header_doneQ;
reg [15:0]  block_addrD, block_addrQ;
reg [31:0] indexD, indexQ;
reg [31:0] timestampD, timestampQ;
reg [31:0] difficultD, difficultQ;
reg [15:0] iD, iQ;
reg [1:0] config_indexD, config_indexQ;

//always @ * begin
//    timestampD = timestampQ;
//    if(iQ > 10000)begin
//        timestampD = timestampQ +1;
//        iD = 0;
//    end else begin
//        iD = iQ +1;
//    end
//end

    
always @ * begin  
    nextState = currentState;
    setup_done = 0;
    enableDV_D = enableDV_Q;
    enableDM_D = enableDM_Q;
    //enableGB_D = enableGB_Q;
    write_header_doneD = write_header_doneQ;
    configD = configQ;
    indexD = indexQ;
    timestampD = timestampQ;
    difficultD = difficultQ;
    block_addrD = block_addrQ;
    config_indexD = config_indexQ;
    control_ena = 0;
    bram_data = 0;
    bram_addr = 0;
            
    if(iQ > 10000)begin
        timestampD = timestampQ +1;
        iD = 0;
    end else begin
        iD = iQ +1;
    end
                
    case(currentState)
        
        
        SETUP: begin
            configD = 1;
            if(config_dv_done == 1 || config_bram_done == 1)begin
                config_indexD = config_indexQ +1 ;
            end
            if(config_indexQ == 2) begin // && config_bm_done == 1) begin
                configD = 0;
                nextState = STOP;
                config_indexD = 0;
            end
        end        
        STOP: begin
            if(system_onQ == 1) begin
                // enable Data Validation
                nextState = IDLE;
                block_addrD = 0;
                indexD = 0;
                timestampD = 0;
                difficultD = 8;
            end
        end        
        IDLE: begin
            //write header to blockchian memory

            if(write_header_doneQ == 0)begin
                //write index
                control_ena = 1;
                bram_data = indexQ;
                bram_addr = block_addrQ;
                write_header_doneD = write_header_doneQ +1;
                indexD = indexQ + 1;
            end
            else if(write_header_doneQ == 1)begin
                //write timestamp
                control_ena = 1;
                bram_data = timestampQ;
                bram_addr = block_addrQ+1;
                write_header_doneD = write_header_doneQ +1;
            end
            else if(write_header_doneQ == 2)begin
                //write difficult
                control_ena = 1;
                bram_data = difficultQ;
                bram_addr = block_addrQ+2;
                write_header_doneD = write_header_doneQ +1;
                enableDV_D = 1;
            end

            if(dv_done == 1 && write_header_doneQ == 3) begin
                enableDV_D = 0;
                // Enable Data Mining
                enableDM_D = 1;
                nextState = MINING;
                write_header_doneD = 0;
                block_addrD = block_addrQ +65;
            end
        end
        MINING: begin
//            if(receiving == 1) begin
//                enableDM_D = 0;
//                nextState = RECEIVE; 
//            end
           if(dm_done == 1) begin
                enableDM_D = 0;
                // Enable Data Com
                enableGB_D = 1;
                nextState = IDLE;
            end
        end
//        RECEIVE: begin
//            // Enable Data Com
//            if(send_done == 1) begin
//                // enable Data Validation
//                enableDV_D = 1;
//                nextState = IDLE;
//            end
//            else if(received_not_valid == 1) begin
//                enableDM_D = 1;
//                nextState = MINING;
//            end
//        end
//        SEND: begin   
//            if(send_done == 1) begin     
//                // enable Data Validation
//                enableDV_D = 1;
//                enableGB_D = 0;
//                nextState = IDLE;
//            end
//        end
        default:begin
            nextState = SETUP; 
        end            
    endcase
    
end    
    
//Sequential Logic
always @ (posedge S_AXI_ACLK) begin
    if (!S_AXI_ARESETN) begin
        currentState <= SETUP;
        enableDV_Q <= 0;
        enableDM_Q <= 0;
        configQ <= 0;
        write_header_doneQ <= 0;
        iQ <= 0;
        config_indexQ <= 0; 
        indexQ <= 0;
        timestampQ <= 0;
        difficultQ <= 0;
        block_addrQ <= 0;
    end else begin
        currentState <= nextState;
        enableDV_Q <= enableDV_D;
        enableDM_Q <= enableDM_D;
        configQ <= configD;
        write_header_doneQ <= write_header_doneD;
        iQ <= iD;
        config_indexQ <= config_indexD;
        indexQ <= indexD;
        timestampQ <= timestampD;
        difficultQ <= difficultD;
        block_addrQ <= block_addrD;

    end
end 
    
endmodule
