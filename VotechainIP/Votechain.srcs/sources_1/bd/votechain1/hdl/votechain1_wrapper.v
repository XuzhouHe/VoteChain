//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Sun Apr 28 17:33:05 2019
//Host        : Dyon-PC running 64-bit major release  (build 9200)
//Command     : generate_target votechain1_wrapper.bd
//Design      : votechain1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module votechain1_wrapper
   (BTNC_0,
    BTND_0,
    BTNL_0,
    BTNR_0,
    BTNU_0,
    LD_0,
    S_AXI_ARESETN_0,
    clk,
    receiving_0,
    system_onQ_0,
    user_ID_0);
  input BTNC_0;
  input BTND_0;
  input BTNL_0;
  input BTNR_0;
  input BTNU_0;
  output [7:0]LD_0;
  input S_AXI_ARESETN_0;
  input clk;
  input receiving_0;
  input system_onQ_0;
  input [7:0]user_ID_0;

  wire BTNC_0;
  wire BTND_0;
  wire BTNL_0;
  wire BTNR_0;
  wire BTNU_0;
  wire [7:0]LD_0;
  wire S_AXI_ARESETN_0;
  wire clk;
  wire receiving_0;
  wire system_onQ_0;
  wire [7:0]user_ID_0;

  votechain1 votechain1_i
       (.BTNC_0(BTNC_0),
        .BTND_0(BTND_0),
        .BTNL_0(BTNL_0),
        .BTNR_0(BTNR_0),
        .BTNU_0(BTNU_0),
        .LD_0(LD_0),
        .S_AXI_ARESETN_0(S_AXI_ARESETN_0),
        .clk(clk),
        .receiving_0(receiving_0),
        .system_onQ_0(system_onQ_0),
        .user_ID_0(user_ID_0));
endmodule
