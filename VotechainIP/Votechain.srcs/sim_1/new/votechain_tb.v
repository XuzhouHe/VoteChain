`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 12:26:39 PM
// Design Name: 
// Module Name: votechain_tb
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


module votechain_tb( );

    // Axi4Lite Manager instantiation    
    parameter C_S_AXI_ADDR_WIDTH = 4, C_S_AXI_DATA_WIDTH = 32, CLK_PERIOD = 10 ;
    
    // Axi4Lite signals
    reg  S_AXI_ACLK ;
    reg  S_AXI_ARESETN ;
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
    
//    Axi4LiteManager #(.C_M_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH), .C_M_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH)) Axi4LiteManager1
//            (
//                // Simple Bus
//                .wrAddr(wrAddr),                    // input    [C_M_AXI_ADDR_WIDTH-1:0]
//                .wrData(wrData),                    // input    [C_M_AXI_DATA_WIDTH-1:0]
//                .wr(wr),                            // input    
//                .wrDone(wrDone),                    // output
//                .rdAddr(rdAddr),                    // input    [C_M_AXI_ADDR_WIDTH-1:0]
//                .rdData(rdData),                    // output   [C_M_AXI_DATA_WIDTH-1:0]
//                .rd(rd),                            // input
//                .rdDone(rdDone),                    // output
//                // Axi4Lite Bus
//                .M_AXI_ACLK(S_AXI_ACLK),            // input
//                .M_AXI_ARESETN(S_AXI_ARESETN),      // input
//                .M_AXI_AWADDR(S_AXI_AWADDR),        // output   [C_M_AXI_ADDR_WIDTH-1:0] 
//                .M_AXI_AWVALID(S_AXI_AWVALID),      // output
//                .M_AXI_AWREADY(S_AXI_AWREADY),      // input
//                .M_AXI_WDATA(S_AXI_WDATA),          // output   [C_M_AXI_DATA_WIDTH-1:0]
//                .M_AXI_WSTRB(S_AXI_WSTRB),          // output   [3:0]
//                .M_AXI_WVALID(S_AXI_WVALID),        // output
//                .M_AXI_WREADY(S_AXI_WREADY),        // input
//                .M_AXI_BRESP(S_AXI_BRESP),          // input    [1:0]
//                .M_AXI_BVALID(S_AXI_BVALID),        // input
//                .M_AXI_BREADY(S_AXI_BREADY),        // output
//                .M_AXI_ARADDR(S_AXI_ARADDR),        // output   [C_M_AXI_ADDR_WIDTH-1:0]
//                .M_AXI_ARVALID(S_AXI_ARVALID),      // output
//                .M_AXI_ARREADY(S_AXI_ARREADY),      // input
//                .M_AXI_RDATA(S_AXI_RDATA),          // input    [C_M_AXI_DATA_WIDTH-1:0]
//                .M_AXI_RRESP(S_AXI_RRESP),          // input    [1:0]
//                .M_AXI_RVALID(S_AXI_RVALID),        // input
//                .M_AXI_RREADY(S_AXI_RREADY)         // output
//            );    
            

reg receiving;
reg BTNU;
reg BTND;
reg BTNR;
reg BTNL;
reg BTNC;
reg [7:0] user_ID;
reg system_onQ;

votechain1_wrapper  my_votechain (
        .clk(S_AXI_ACLK),            // input
        .S_AXI_ARESETN_0(S_AXI_ARESETN),      // input
        .receiving_0(receiving),
        .BTNU_0(BTNU),
        .BTND_0(BTND),
        .BTNR_0(BTNR),
        .BTNL_0(BTNL),
        .BTNC_0(BTNC),
        .user_ID_0(user_ID),
        .system_onQ_0(system_onQ)
        
                
);

initial begin
    S_AXI_ACLK <= 1;
    S_AXI_ARESETN <= 1;
    #10
    S_AXI_ARESETN <= 0; 
end

always 
    #5 S_AXI_ACLK = !S_AXI_ACLK;

integer i;
initial begin
i = 0;
receiving = 0;
BTNU = 0;
BTND = 0;
BTNC = 0;
BTNL = 0;
BTNR = 0;
user_ID = 0;
system_onQ = 0;
#130000;
system_onQ = 1;


#110;
system_onQ = 0;
#(2500000);
while(i<40)begin
    user_ID = i+1;
    if(i%2==0)begin
        BTNU = 0;
        #50000;
        BTND = 1;
        #2500000;
    end else begin 
        BTND = 0;
        #50000;
        BTNU = 1;
        #2500000;
    end
    i=i+1;
end
BTNU = 0;
BTND = 0;
#1200000;

// Second round of votes
i = 0;
while(i<40)begin
    user_ID = user_ID + 1;
        if(i%2==0)begin
           BTNR = 0;
           #100000;
           BTNL = 1; 
           #3500000;
        end else begin 
           BTNL = 0;
           #100000;
           BTNR = 1;
           #3500000;
        end
        i=i+1;
end
BTNR = 0;
BTNL = 0;
#1200000;

$stop;




end




endmodule
