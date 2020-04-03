//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Sun Apr 28 17:33:36 2019
//Host        : Dyon-PC running 64-bit major release  (build 9200)
//Command     : generate_target votechain_1.bd
//Design      : votechain_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "votechain_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=votechain_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=1,bdsource=USER,da_clkrst_cnt=1,synth_mode=Global}" *) (* HW_HANDOFF = "votechain_1.hwdef" *) 
module votechain_1
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_RESET rst, CLK_DOMAIN votechain_1_clk, FREQ_HZ 100000000, PHASE 0.000" *) input clk;
  input receiving;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST, POLARITY ACTIVE_LOW" *) input rst;
  input system_onQ;
  input [7:0]user_ID;

  wire BTNC_1;
  wire BTND_1;
  wire BTNL_1;
  wire BTNR_1;
  wire BTNU_1;
  wire clk_1;
  wire receiving_1;
  wire rst_1;
  wire system_onQ_1;
  wire [7:0]user_ID_1;
  wire [7:0]votechain1_0_LD_0;

  assign BTNC_1 = BTNC;
  assign BTND_1 = BTND;
  assign BTNL_1 = BTNL;
  assign BTNR_1 = BTNR;
  assign BTNU_1 = BTNU;
  assign LD[7:0] = votechain1_0_LD_0;
  assign clk_1 = clk;
  assign receiving_1 = receiving;
  assign rst_1 = rst;
  assign system_onQ_1 = system_onQ;
  assign user_ID_1 = user_ID[7:0];
  votechain_1_votechain1_0_1 votechain1_0
       (.BTNC_0(BTNC_1),
        .BTND_0(BTND_1),
        .BTNL_0(BTNL_1),
        .BTNR_0(BTNR_1),
        .BTNU_0(BTNU_1),
        .LD_0(votechain1_0_LD_0),
        .S_AXI_ARESETN_0(rst_1),
        .clk(clk_1),
        .receiving_0(receiving_1),
        .system_onQ_0(system_onQ_1),
        .user_ID_0(user_ID_1));
endmodule
