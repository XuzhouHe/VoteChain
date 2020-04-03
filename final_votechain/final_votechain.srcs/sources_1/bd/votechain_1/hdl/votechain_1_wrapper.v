//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Sun Apr 28 17:33:36 2019
//Host        : Dyon-PC running 64-bit major release  (build 9200)
//Command     : generate_target votechain_1_wrapper.bd
//Design      : votechain_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module votechain_1_wrapper
   (BTNC,
    BTND,
    BTNL,
    BTNR,
    BTNU,
    LD,
    clk,
    receiving,
    rst,
    system_onQ,
    user_ID);
  input BTNC;
  input BTND;
  input BTNL;
  input BTNR;
  input BTNU;
  output [7:0]LD;
  input clk;
  input receiving;
  input rst;
  input system_onQ;
  input [7:0]user_ID;

  wire BTNC;
  wire BTND;
  wire BTNL;
  wire BTNR;
  wire BTNU;
  wire [7:0]LD;
  wire clk;
  wire receiving;
  wire rst;
  wire system_onQ;
  wire [7:0]user_ID;

  votechain_1 votechain_1_i
       (.BTNC(BTNC),
        .BTND(BTND),
        .BTNL(BTNL),
        .BTNR(BTNR),
        .BTNU(BTNU),
        .LD(LD),
        .clk(clk),
        .receiving(receiving),
        .rst(rst),
        .system_onQ(system_onQ),
        .user_ID(user_ID));
endmodule
