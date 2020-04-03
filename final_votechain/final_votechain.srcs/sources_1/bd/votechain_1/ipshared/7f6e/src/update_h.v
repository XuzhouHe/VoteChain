`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2018 08:49:19 PM
// Design Name: 
// Module Name: update_h
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

module update_h #  (parameter BW = 31, wAddr_BW = 5, nAddr_BW = 5, msgAddr_BW = 6)(
input clk,
input rst,
input [wAddr_BW:0] w_in_index,
input [wAddr_BW:0] w_in_index_2,
input [BW:0] w_in,

output reg w_finish,
output reg w_finish_2,
output reg [wAddr_BW:0] h_out_index,
output reg [BW:0] h0,
output reg [BW:0] h1,
output reg [BW:0] h2,
output reg [BW:0] h3,
output reg [BW:0] h4,
output reg [BW:0] h5,
output reg [BW:0] h6,
output reg [BW:0] h7
    );
    
    // initial hashing value
    parameter h0_ini = 32'h6a09e667;
    parameter h1_ini = 32'hbb67ae85; 
    parameter h2_ini = 32'h3c6ef372; 
    parameter h3_ini = 32'ha54ff53a; 
    parameter h4_ini = 32'h510e527f; 
    parameter h5_ini = 32'h9b05688c; 
    parameter h6_ini = 32'h1f83d9ab; 
    parameter h7_ini = 32'h5be0cd19; 
    
    // k rom
    reg k_rom_read_en;
    reg [wAddr_BW:0] k_rom_read_addr_j;
    wire [BW:0] k_j;
    k_rom k_rom(
    .read_en(k_rom_read_en),
    .address(k_rom_read_addr_j),
    .data(k_j)
        );
    
    // update intermediate registers 
    reg [BW:0] a;
    reg [BW:0] b;
    reg [BW:0] c;
    reg [BW:0] d;
    reg [BW:0] e;
    reg [BW:0] f;
    reg [BW:0] g;
    reg [BW:0] h;
    
    reg [BW:0] S0;
    reg [BW:0] S1;
    reg [BW:0] ch;
    reg [BW:0] maj;
    reg [BW:0] temp1;
    reg [BW:0] temp2;
        
    // update S1, ch, S0, maj, temp1, temp2 <= (a-0, b-1, c-2, e-4, f-5, g-6, h-7)
    always @(*)
    begin
        S1 <= {e[5:0], e[31:6]} ^ {e[10:0], e[31:11]} ^ {e[24:0], e[31:25]};
        ch <= (e & f) ^( (!e) & g );
        k_rom_read_en <= 1;
        k_rom_read_addr_j <= w_in_index;
        temp1 <= h + S1 + ch + k_j + w_in;
        
        S0 <= {a[1:0], a[31:2]} ^ {a[12:0], a[31:13]} ^ {a[21:0], a[31:22]};
        maj <= (a & b) ^ (a & c) ^ (b & c);
        temp2 <= S0 + maj;
    end
    
    // consistent index registers
    reg [wAddr_BW:0] w_in_index_reg1;
    reg [wAddr_BW:0] w_in_index_reg2;
    always @(posedge clk)
    begin
        if(rst)begin
            w_in_index_reg1 <= 0;
            w_in_index_reg2 <= 0;
            end
        else begin
            w_in_index_reg1 <= w_in_index;
            w_in_index_reg2 <= w_in_index_2;
        end
    end

    // update reg (a, ..., h) <= (temp1, temp2)
    always @(posedge clk)
    begin
        if(rst)
        begin
           a <= h0_ini;
           b <= h1_ini;
           c <= h2_ini;
           d <= h3_ini;
           e <= h4_ini;
           f <= h5_ini;
           g <= h6_ini;
           h <= h7_ini;
        end
        else
        begin
            if(w_in_index == 0 && w_in_index == 0)
            begin
                a <= h0_ini;
                b <= h1_ini;
                c <= h2_ini;
                d <= h3_ini;
                e <= h4_ini;
                f <= h5_ini;
                g <= h6_ini;
                h <= h7_ini;
            end
            else if(w_in_index_reg1 == 63)
            begin
                a <= a;
                b <= b;
                c <= c;
                d <= d;
                e <= e;
                f <= f;
                g <= g;
                h <= h;
            end
            else
            begin
                h <= g;
                g <= f;
                f <= e;
                e <= d + temp1;
                d <= c;
                c <= b;
                b <= a;
                a <= temp1 + temp2;
            end
           
        end
    end
       
    
    // reg_out - update (h0, ..., h7) <= (a, ..., h)
    always @(posedge clk)
    begin
        if(rst)
        begin
            h0 <= h0_ini;
            h1 <= h1_ini;
            h2 <= h2_ini;
            h3 <= h3_ini;
            h4 <= h4_ini;
            h5 <= h5_ini;
            h6 <= h6_ini;
            h7 <= h7_ini;
        end
        else
        begin
            if(w_in_index_reg1 == 0 && w_in_index_reg2 == 0)
            begin
                h0 <= h0_ini + a;
                h1 <= h1_ini + b;
                h2 <= h2_ini + c;
                h3 <= h3_ini + d;
                h4 <= h4_ini + e;
                h5 <= h5_ini + f;
                h6 <= h6_ini + g;
                h7 <= h7_ini + h;
            end
            else if(h_out_index == 63)
            begin
                h0 <= h0;
                h1 <= h1;
                h2 <= h2;
                h3 <= h3;
                h4 <= h4;
                h5 <= h5;
                h6 <= h6;
                h7 <= h7;
            end
            else
            begin
                h0 <= h0 + a;
                h1 <= h1 + b;
                h2 <= h2 + c;
                h3 <= h3 + d;
                h4 <= h4 + e;
                h5 <= h5 + f;
                h6 <= h6 + g;
                h7 <= h7 + h;
            end
        end
    end
    
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            h_out_index <= 0;
            w_finish <= 0;
            w_finish_2 <= 0;
        end
        else
        begin
            h_out_index <= w_in_index_reg1;
            if(w_in_index_reg1==63)
                w_finish <= 1;
            else
                w_finish <= 0;
                
            if(w_in_index_reg1==63 && w_in_index_reg2==4)
                w_finish_2 <= 1;
            else
                w_finish_2 <= 0;
        end
    end
    

endmodule