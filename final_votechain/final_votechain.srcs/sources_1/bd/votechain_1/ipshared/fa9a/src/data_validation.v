`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2019 01:27:55 PM
// Design Name: 
// Module Name: data_validation
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


module data_validation(
    // Axi4Lite signals
    input S_AXI_ACLK ,
    input S_AXI_ARESETN, 

    // IO Controller
    input configQ,
    input enableDV_Q,
    
    input [4:0] vote,
    output reg getVoteQ,
    
    output reg dv_done,
    output reg config_dv_done,
    
    // IO BRAM
    output reg dv_enaQ,
    output reg [31:0] bram_dataQ,
    output reg [15:0] bram_addrQ, 
    
    // IO User

    input [7:0] user_ID, 
    output reg [7:0] LD
    );

//assign LD = user_ID;    
//wire [4:0] vote;

//button_debounce buttons1(
//    .clk(S_AXI_ACLK),
//    .votes(vote)
//    );

//FSM States
parameter WAIT = 0, STOP = 1, COLLECT = 2, RESULT = 3, STORE = 4, CHECK = 5,CONF = 6;
reg [3:0] nextState, currentState;

reg [6:0] numDataD, numDataQ;
reg [6:0] numResultD, numResultQ;
reg timeoutD, timeoutQ;
reg [31:0]  timeoutCount_D, timeoutCount_Q;

reg dv_enaD;
reg [31:0] bram_dataD;
reg [15:0] bram_addrD; 

//Data
reg [31:0] current_voteD,current_voteQ;
reg [31:0] current_addrD,current_addrQ;

//vote
reg [31:0] vote_addrD, vote_addrQ;
reg getVoteD;

//result
reg [31:0] resultD [4:0],resultQ [4:0];

//ID check
reg [31:0] ID_indexD,ID_indexQ;
reg [31:0] ID_arrayD [79:0],ID_arrayQ [79:0];

//loop
reg [31:0] iD, iQ;

integer i,ii,k,kk;           
 
always @ * begin     
    if(resultQ[1][20:0] > resultQ[2][20:0] && resultQ[1][20:0] > resultQ[3][20:0] && resultQ[1][20:0] > resultQ[4][20:0] && resultQ[1][20:0] > resultQ[0][20:0])begin
        LD = (enableDV_Q<<7) + 7'b0000001;
    end else if (resultQ[2][20:0] > resultQ[1][20:0] && resultQ[2][20:0] > resultQ[3][20:0] && resultQ[2][20:0] > resultQ[4][20:0] && resultQ[2][20:0] > resultQ[0][20:0]) begin
        LD = (enableDV_Q<<7) + 7'b0000010;
    end else if (resultQ[3][20:0] > resultQ[2][20:0] && resultQ[3][20:0] > resultQ[1][20:0] && resultQ[3][20:0] > resultQ[4][20:0] && resultQ[3][20:0] > resultQ[0][20:0]) begin
        LD = (enableDV_Q<<7) + 7'b0000100;
    end else if (resultQ[4][20:0] > resultQ[2][20:0] && resultQ[4][20:0] > resultQ[3][20:0] && resultQ[4][20:0] > resultQ[1][20:0] && resultQ[4][20:0] > resultQ[0][20:0]) begin
        LD = (enableDV_Q<<7) + 7'b0001000;
    end else if (resultQ[0][20:0] > resultQ[2][20:0] && resultQ[0][20:0] > resultQ[3][20:0] && resultQ[0][20:0] > resultQ[1][20:0] && resultQ[0][20:0] > resultQ[4][20:0]) begin
        LD = (enableDV_Q<<7) + 7'b0010000;
    end else begin
        LD = (enableDV_Q<<7) + 7'b0010101;
    end
    

end


always @ * begin 
    nextState = currentState; 
    timeoutCount_D = timeoutCount_Q;
    vote_addrD = vote_addrQ;
    timeoutD = timeoutQ;
    iD = iQ;
    numDataD = numDataQ;
    numResultD = numResultQ;
    getVoteD = getVoteQ;
    ID_indexD = ID_indexQ;
    current_addrD = current_addrQ;
    for(ii=0; ii<80; ii=ii+1)begin
        ID_arrayD[ii] = ID_arrayQ[ii];
    end
    current_voteD = current_voteQ;
    
    resultD[0] = resultQ[0];
    resultD[1] = resultQ[1];
    resultD[2] = resultQ[2];
    resultD[3] = resultQ[3];
    resultD[4] = resultQ[4];
    
    config_dv_done = 0;
    dv_done = 0;
    dv_enaD = 0;
    bram_addrD = bram_addrQ;
    bram_dataD = bram_dataQ;
    
    
    case(currentState)
    
    
        WAIT: begin
            if(configQ == 0) begin
                nextState = WAIT;
                
            end else begin
                nextState = CONF;
                iD = 0;
            end
            
        end
        
        
        CONF: begin
            if(iQ < 80 ) begin
                ID_arrayD[iQ] = 0;
                iD = iQ + 1;
                nextState = CONF;
                
            end else begin
                resultD[0] = 32'h00100000;
                resultD[1] = 32'h00200000;
                resultD[2] = 32'h00300000;
                resultD[3] = 32'h00400000;
                resultD[4] = 32'h00500000;
                nextState = STOP;
                ID_indexD = 0;
                current_addrD = 0;
                config_dv_done = 1;
            end
        end
        
        
        STOP: begin
            if(enableDV_Q == 0) begin
                nextState = STOP;
            end else begin
                getVoteD = 1;
                nextState = COLLECT;
                timeoutCount_D = 0;
                numDataD = 0;
            
            end
        end
        
        COLLECT: begin
            // Collect the data <----
            current_voteD = vote;
            if(vote!=0)begin
                nextState = CHECK;
                getVoteD = 0;
                iD = 0;
            end
            else begin
                timeoutCount_D = timeoutCount_Q +1;
                if(timeoutCount_Q == 32'hFFFFFFFF) begin
                    timeoutD = 1;
                    iD = 0;
                    nextState = RESULT;
                end
            end
            
        end
        RESULT: begin
            // Calculate Result <----
            if (iQ < 5) begin
                nextState = RESULT;
                dv_enaD = 1;
                bram_dataD = resultQ[iQ];
                bram_addrD = current_addrQ + 51 + iQ ;
                iD = iQ +1;
            end
            else begin
                current_addrD = current_addrQ + 65;
                nextState = STOP;
                dv_done = 1;
            end
        end
        STORE: begin        
            getVoteD = 0;
            if(numResultQ == 1 || timeoutQ) begin
                iD = 0;
                numDataD = 0;
                numResultD = 0;
//                dv_done = 1;
                timeoutD = 0;
                nextState = RESULT;
            end
            else begin
                // using shift
                bram_dataD[31:28] = 0;
                bram_dataD[27:20] = user_ID;
                if(current_voteQ[0] == 1)begin
                     bram_dataD[19:0] = 20'b00000000000000000001;
                     resultD[0] = resultQ[0] +1;
                end
                if(current_voteQ[1] == 1)begin
                     bram_dataD[19:0] = 20'b00000000000000000010;
                     resultD[1] = resultQ[1] +1;
                end
                if(current_voteQ[2] == 1)begin
                     bram_dataD[19:0] = 20'b00000000000000000011;
                     resultD[2] = resultQ[2] +1;
                end
                if(current_voteQ[3] == 1)begin
                     bram_dataD[19:0] = 20'b00000000000000000100;
                     resultD[3] = resultQ[3] +1;
                end
                if(current_voteQ[4] == 1)begin
                     bram_dataD[19:0] = 20'b00000000000000000101;
                     resultD[4] = resultQ[4] +1;
                end
                //write vote to memory
                dv_enaD = 1;
                bram_addrD = current_addrQ + 11 + numDataQ;
                vote_addrD = vote_addrQ + 1; 
                
                numDataD = numDataQ + 1;
                if (vote_addrQ == 39) begin
                    numResultD = 1;
                    vote_addrD = 0;
                end else begin                
                    getVoteD = 1;
                    nextState = COLLECT;
                end
            end
            
        end
        CHECK: begin
            if(iQ == ID_indexQ ) begin
                ID_arrayD[ID_indexQ] = user_ID;
                ID_indexD = ID_indexQ +1;
                nextState = STORE;
            end
            else begin
                if(ID_arrayQ[iQ]== user_ID)begin
                    getVoteD = 1;
                    nextState = COLLECT;
                end
                iD = iQ + 1;
            end
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
        timeoutCount_Q <= 0;
        vote_addrQ <= 0;
        iQ <= 0;
        timeoutQ <= 0;
        numDataQ <= 0;
        numResultQ <= 0;
        getVoteQ <= 0;
        ID_indexQ <= 0;
        resultQ[0] <= 0;
        resultQ[1] <= 0;
        resultQ[2] <= 0;
        resultQ[3] <= 0;
        resultQ[4] <= 0;
        for(kk=0; kk<80; kk=kk+1)begin
            ID_arrayQ[kk] <= 0;
        end
        current_addrQ <= 0;
        current_voteQ <= 0;
        dv_enaQ <= 0;
        bram_dataQ <= 0;
        bram_addrQ <= 0;
    end else begin
        currentState <= nextState;
        timeoutCount_Q <= timeoutCount_D;
        vote_addrQ <= vote_addrD;
        iQ <= iD;
        timeoutQ <= timeoutD;
        numDataQ <= numDataD;
        numResultQ <= numResultD;
        getVoteQ <= getVoteD;
        ID_indexQ <= ID_indexD;
        resultQ[0] <= resultD[0];
        resultQ[1] <= resultD[1];
        resultQ[2] <= resultD[2];
        resultQ[3] <= resultD[3];
        resultQ[4] <= resultD[4];
        for(kk=0; kk<80; kk=kk+1)begin
            ID_arrayQ[kk] <= ID_arrayD[kk];
        end
        current_addrQ <= current_addrD;
        current_voteQ <= current_voteD;
        dv_enaQ <= dv_enaD;
        bram_dataQ <= bram_dataD;
        bram_addrQ <= bram_addrD;            
    end
end 


endmodule
