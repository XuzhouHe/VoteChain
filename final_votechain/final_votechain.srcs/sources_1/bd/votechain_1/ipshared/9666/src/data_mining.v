`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2019 01:27:55 PM
// Design Name: 
// Module Name: data_mining
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

module data_mining # (parameter BW = 31, wAddr_BW = 5, nAddr_BW = 5, msgAddr_BW = 16)(
    // Axi4Lite signals
    input S_AXI_ACLK ,
    input S_AXI_ARESETN,
   
    // IO Controller
    input configQ,
    output reg dm_done,
    input enableDM_Q,
    
    // IO BRAM
    input [BW:0] dm_read_data,
    output [msgAddr_BW-1:0] dm_read_addr,
    output reg dm_enaQ,
    output reg [msgAddr_BW-1:0] bram_addrQ,
    output reg [BW:0] bram_dataQ
    
    //input reg difficulty
        
    );
        
    // SHA 256
    reg enSHA_D,enSHA_Q;
    
    wire [wAddr_BW:0] extend_w_out_index;
    wire [BW:0] extend_w_out;
    
    wire update_h_w_finish;
    wire update_h_w_finish_2;
    wire [wAddr_BW:0] update_h_h_index_out;
    wire [BW:0] h0;
    wire [BW:0] h1;
    wire [BW:0] h2;
    wire [BW:0] h3;
    wire [BW:0] h4;
    wire [BW:0] h5;
    wire [BW:0] h6;
    wire [BW:0] h7;

    // Nonce
    reg enNonceD,enNonceQ;    
    reg [BW:0] seed_data_D,seed_data_Q;    
    reg [BW:0] nonce_Data_D,nonce_Data_Q;
    reg [BW+1:1] r_LFSR_D,r_LFSR_Q;
    
    reg [3:0] chunkCountD, chunkCountQ;
    reg [BW:0] hashD [0:7],hashQ [0:7];
    reg [BW:0] hashCheck_D,hashCheck_Q;
    
    //Data
    reg [msgAddr_BW-1:0] current_addr_D,current_addr_Q;
    
    reg dm_enaD;
    reg [BW:0] bram_dataD;
    reg [msgAddr_BW-1:0] bram_addrD; 
    
    //loop
    reg [31:0] i_D, i_Q;
    
    integer i,k;
    
    parameter difficulty = 20;
    
    // msg ram input
    wire [msgAddr_BW-1:0] msg_ram_read_addr; 
    assign dm_read_addr = msg_ram_read_addr + (chunkCountQ*16) + current_addr_Q ;
    
    // msg ram output
    wire [BW:0] msg_ram_data_out;
    assign msg_ram_data_out = dm_read_data;
             
sha256_top #  (.BW(BW),.wAddr_BW(wAddr_BW),.nAddr_BW(nAddr_BW),.msgAddr_BW(msgAddr_BW)) sha256_top1(
    .clk(S_AXI_ACLK),
    .rst(enSHA_Q),
    .msg_data_in(msg_ram_data_out),
    
    .msg_ram_read_addr(msg_ram_read_addr),
    .extend_w_out_index(extend_w_out_index),
    .extend_w_out(extend_w_out),
    .update_h_w_finish(update_h_w_finish),
    .update_h_w_finish_2(update_h_w_finish_2),
    .update_h_h_index_out(update_h_h_index_out),
    .h0(h0),
    .h1(h1),
    .h2(h2),
    .h3(h3),
    .h4(h4),
    .h5(h5),
    .h6(h6),
    .h7(h7)
    );
  
//FSM States
parameter IDLE = 0, CHECK = 1, SHA = 2, STORE = 3;
reg [3:0] nextState, currentState;
   
always @ * begin  
    dm_done = 0;
    dm_enaD = 0;
    bram_addrD = bram_addrQ;
    bram_dataD = bram_dataQ;
    nextState = currentState;
    chunkCountD = chunkCountQ;
    hashCheck_D = hashCheck_Q;
    current_addr_D = current_addr_Q;
    enSHA_D = enSHA_Q;
    for(i=0; i<8; i=i+1)begin
        hashD[i] = hashQ[i];
    end
    nonce_Data_D = nonce_Data_Q;
    enNonceD = enNonceQ;
    seed_data_D = seed_data_Q;
    r_LFSR_D = r_LFSR_Q;
    i_D = i_Q; 
    
    case(currentState)
        IDLE: begin
            if(enableDM_Q)begin
                hashD[0] = 0;
                hashD[1] = 0;
                hashD[2] = 0;
                hashD[3] = 0;
                hashD[4] = 0;
                hashD[5] = 0;
                hashD[6] = 0;
                hashD[7] = 1;
                hashCheck_D = 1;
                nonce_Data_D = 0;
                nextState = CHECK;
            end
        end
        CHECK: begin  
            if (hashCheck_Q[difficulty-1:0] == 0) begin
                i_D = 0;
                nextState = STORE;
            end else begin
                dm_enaD = 1;
                bram_dataD = nonce_Data_Q;
                bram_addrD = current_addr_Q + 56; 
                seed_data_D = nonce_Data_Q;
                enNonceD = 1;                   
                enSHA_D = 1;
                nextState = SHA; 
            end      
               
        end
        SHA: begin     
            if(extend_w_out_index==62)begin
                chunkCountD = chunkCountQ + 1;
            end                    
            
            if(update_h_w_finish_2)begin//when SHA256 is done
                hashD[0] = h0;
                hashD[1] = h1;
                hashD[2] = h2;
                hashD[3] = h3;
                hashD[4] = h4;
                hashD[5] = h5;
                hashD[6] = h6;
                hashD[7] = h7;
                hashCheck_D = h7;
                
                chunkCountD = 0;
                enSHA_D = 0;
                nextState = CHECK;
            end
        end
        STORE: begin
            dm_enaD = 1;
            if(i_Q<8)begin
                bram_dataD = hashQ[i_Q];
                bram_addrD = current_addr_Q + 57 + i_Q;    
            end else begin
                bram_dataD = hashQ[i_Q-8];
                bram_addrD = current_addr_Q + 65 + 3 + i_Q - 8;    
            end
            
            if(i_Q==15)begin
                current_addr_D = current_addr_Q + 65;
                dm_done = 1;
                enNonceD = 0;
                nextState = IDLE;
            end 
            i_D = i_Q + 1;
        end     
    endcase
    
    if (enNonceQ) begin
        r_LFSR_D = {r_LFSR_Q[BW:1], r_LFSR_Q[32] ^~ r_LFSR_Q[22] ^~ r_LFSR_Q[2] ^~ r_LFSR_Q[1]};     
        nonce_Data_D = r_LFSR_Q[BW+1:1];
        if({r_LFSR_Q[BW:1], r_LFSR_Q[32] ^~ r_LFSR_Q[22] ^~ r_LFSR_Q[2] ^~ r_LFSR_Q[1]} > seed_data_Q)begin
            enNonceD = 0;
        end
    end
end   

//Sequential Logic
always @ (posedge S_AXI_ACLK) begin
   if (S_AXI_ARESETN) begin
        currentState <= IDLE;
        enSHA_Q <= 0;
        enNonceQ <= 0;
        r_LFSR_Q <= 0;
        current_addr_Q <= 0;
        chunkCountQ <= 0;   
        i_Q <= 0;
        hashCheck_Q <= 0;   
        nonce_Data_Q <= 0;
        seed_data_Q <= 0;
        hashQ[7] <= 1;
        for(k=0; k<7; k=k+1)begin
            hashQ[k] <= 0;
        end
        dm_enaQ <= 0;
        bram_dataQ <= 0;
        bram_addrQ <= 0;
   end else begin
        currentState <= nextState;
        chunkCountQ <= chunkCountD;
        hashCheck_Q <= hashCheck_D;
        current_addr_Q <= current_addr_D;
        enSHA_Q <= enSHA_D;
        for(k=0; k<8; k=k+1)begin
            hashQ[k] <= hashD[k] ;
        end
        nonce_Data_Q <= nonce_Data_D;
        enNonceQ <= enNonceD;
        seed_data_Q <= seed_data_D;
        r_LFSR_Q <= r_LFSR_D;
        i_Q <= i_D;
        dm_enaQ <= dm_enaD;
        bram_dataQ <= bram_dataD;
        bram_addrQ <= bram_addrD;   
   end
end 

endmodule
