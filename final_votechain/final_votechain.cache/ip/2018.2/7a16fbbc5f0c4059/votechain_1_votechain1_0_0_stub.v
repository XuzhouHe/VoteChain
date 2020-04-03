// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Apr 27 22:03:02 2019
// Host        : RDP-SRV1 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ votechain_1_votechain1_0_0_stub.v
// Design      : votechain_1_votechain1_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "votechain1,Vivado 2018.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(BTNC_0, BTND_0, BTNL_0, BTNR_0, BTNU_0, LD_0, 
  S_AXI_ARESETN_0, clk, receiving_0, system_onQ_0, user_ID_0)
/* synthesis syn_black_box black_box_pad_pin="BTNC_0,BTND_0,BTNL_0,BTNR_0,BTNU_0,LD_0[7:0],S_AXI_ARESETN_0,clk,receiving_0,system_onQ_0,user_ID_0[7:0]" */;
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
endmodule
