`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 02:20:30 PM
// Design Name: 
// Module Name: votechain_wapper
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


module votechain_wapper
(
    S_AXI_ACLK ,
    S_AXI_ARESETN ,
//    S_AXI_AWADDR ,
//    S_AXI_AWVALID ,
//    S_AXI_AWREADY ,
//    S_AXI_WDATA ,
//    S_AXI_WSTRB ,
//    S_AXI_WVALID ,
//    S_AXI_WREADY ,
//    S_AXI_BRESP ,
//    S_AXI_BVALID ,
//    S_AXI_BREADY ,
//    S_AXI_ARADDR ,
//    S_AXI_ARVALID ,
//    S_AXI_ARREADY ,
//    S_AXI_RDATA ,
//    S_AXI_RRESP ,
//    S_AXI_RVALID ,
//    S_AXI_RREADY,
    receiving,
    BTNU,
    BTND,
    BTNR,
    BTNL,
    BTNC,
    user_ID,
    system_onQ
);
    parameter C_S_AXI_ADDR_WIDTH = 4, C_S_AXI_DATA_WIDTH = 32; 

    // Axi4Lite signals 
    input S_AXI_ACLK ;
    input S_AXI_ARESETN ;
//    input [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR ;
//    input  S_AXI_AWVALID ;
//    output  S_AXI_AWREADY ;
//    input  [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA ;
//    input  [3:0] S_AXI_WSTRB ;
//    input  S_AXI_WVALID ;
//    output S_AXI_WREADY ;
//    output [1:0] S_AXI_BRESP ;
//    output S_AXI_BVALID ;
//    input  S_AXI_BREADY ;
//    input  [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR ;
//    input  S_AXI_ARVALID ;
//    output S_AXI_ARREADY ;
//    output [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA ;
//    output [1:0] S_AXI_RRESP ;
//    output S_AXI_RVALID ;
//    input  S_AXI_RREADY;
    
    input  receiving;
    input BTNU;
    input BTND;
    input BTNR;
    input BTNL;
    input BTNC;
    input [7:0] user_ID;
    input system_onQ;
    
    wire S_AXI_ACLK ;
    wire S_AXI_ARESETN ;
//    wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR ;
//    wire S_AXI_AWVALID ;
//    wire S_AXI_AWREADY ;
//    wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA ;
//    wire [3:0] S_AXI_WSTRB ;
//    wire S_AXI_WVALID ;
//    wire S_AXI_WREADY ;
//    wire [1:0] S_AXI_BRESP ;
//    wire S_AXI_BVALID ;
//    wire S_AXI_BREADY ;
//    wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR ;
//    wire S_AXI_ARVALID ;
//    wire S_AXI_ARREADY ;
//    wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA ;
//    wire [1:0] S_AXI_RRESP ;
//    wire S_AXI_RVALID ;
//    wire S_AXI_RREADY;
    wire receiving;
    wire BTNU;
    wire BTND;
    wire BTNR;
    wire BTNL;
    wire BTNC;
    wire userID;
    wire system_onQ;
//// Axi4Lite Manager instantiation    
//    parameter C_S_AXI_ADDR_WIDTH = 4, C_S_AXI_DATA_WIDTH = 32, CLK_PERIOD = 33.33 ;
    
//    // Axi4Lite signals
//    reg  S_AXI_ACLK ;
//    reg  S_AXI_ARESETN ;
//    wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR ;
//    wire  S_AXI_AWVALID ;
//    wire S_AXI_AWREADY ;
//    wire  [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA ;
//    wire  [3:0] S_AXI_WSTRB ;
//    wire  S_AXI_WVALID ;
//    wire S_AXI_WREADY ;
//    wire [1:0] S_AXI_BRESP ;
//    wire S_AXI_BVALID ;
//    wire  S_AXI_BREADY ;
//    wire  [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR ;
//    wire  S_AXI_ARVALID ;
//    wire S_AXI_ARREADY ;
//    wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA ;
//    wire [1:0] S_AXI_RRESP ;
//    wire S_AXI_RVALID ;
//    wire  S_AXI_RREADY ;
//    // Simple Bus signals
//    reg     [C_S_AXI_ADDR_WIDTH-1:0]    wrAddr ;
//    reg     [C_S_AXI_DATA_WIDTH-1:0]    wrData ;
//    reg                                 wr ;
//    wire                                wrDone ;
//    reg     [C_S_AXI_ADDR_WIDTH-1:0]    rdAddr ;
//    wire    [C_S_AXI_DATA_WIDTH-1:0]    rdData ;
//    reg                                 rd ;
//    wire                                rdDone ;
   
            

//reg receiving;
//reg BTNU;
//reg BTND;
//reg BTNR;
//reg BTNL;
//reg BTNC;
//reg [7:0] user_ID;
//reg system_onQ;

votechain1 my_votechain(
        .S_AXI_ACLK_0(S_AXI_ACLK),            // input
        .S_AXI_ARESETN_0(S_AXI_ARESETN),      // input
//        .S_AXI_0_AWADDR(S_AXI_AWADDR),        // input    [C_S_AXI_ADDR_WIDTH-1:0]
//        .S_AXI_0_AWVALID(S_AXI_AWVALID),      // input
//        .S_AXI_0_AWREADY(S_AXI_AWREADY),      // output
//        .S_AXI_0_WDATA(S_AXI_WDATA),          // input    [C_S_AXI_DATA_WIDTH-1:0]
//        .S_AXI_0_WSTRB(S_AXI_WSTRB),          // input    [3:0]
//        .S_AXI_0_WVALID(S_AXI_WVALID),        // input
//        .S_AXI_0_WREADY(S_AXI_WREADY),        // output        
//        .S_AXI_0_BRESP(S_AXI_BRESP),          // output   [1:0]
//        .S_AXI_0_BVALID(S_AXI_BVALID),        // output
//        .S_AXI_0_BREADY(S_AXI_BREADY),        // input
//        .S_AXI_0_ARADDR(S_AXI_ARADDR),        // input    [C_S_AXI_ADDR_WIDTH-1:0]
//        .S_AXI_0_ARVALID(S_AXI_ARVALID),      // input
//        .S_AXI_0_ARREADY(S_AXI_ARREADY),      // output
//        .S_AXI_0_RDATA(S_AXI_RDATA),          // output   [C_S_AXI_DATA_WIDTH-1:0]
//        .S_AXI_0_RRESP(S_AXI_RRESP),          // output   [1:0]
//        .S_AXI_0_RVALID(S_AXI_RVALID),        // output    
//        .S_AXI_0_RREADY(S_AXI_RREADY),         // input
        .receiving_0(receiving),
        .BTNU_0(BTNU),
        .BTND_0(BTND),
        .BTNR_0(BTNR),
        .BTNL_0(BTNL),
        .BTNC_0(BTNC),
        .user_ID_0(user_ID),
        .system_onQ_0(system_onQ)
        
                
);

endmodule
