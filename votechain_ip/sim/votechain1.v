//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Sun Apr 28 17:33:05 2019
//Host        : Dyon-PC running 64-bit major release  (build 9200)
//Command     : generate_target votechain1.bd
//Design      : votechain1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "votechain1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=votechain1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "votechain1.hwdef" *) 
module votechain1
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXI_ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXI_ARESETN_0, POLARITY ACTIVE_LOW" *) input S_AXI_ARESETN_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_RESET S_AXI_ARESETN_0, CLK_DOMAIN votechain1_clk, FREQ_HZ 100000000, PHASE 0.000" *) input clk;
  input receiving_0;
  input system_onQ_0;
  input [7:0]user_ID_0;

  wire BRAM_0_config_bram_done;
  wire [31:0]BRAM_0_dm_read_data;
  wire BTNC_0_1;
  wire BTND_0_1;
  wire BTNL_0_1;
  wire BTNR_0_1;
  wire BTNU_0_1;
  wire S_AXI_ACLK_0_1;
  wire S_AXI_ARESETN_0_1;
  wire [4:0]button_debounce_0_votes;
  wire [15:0]controller_0_bram_addr;
  wire [31:0]controller_0_bram_data;
  wire controller_0_configQ;
  wire controller_0_control_ena;
  wire controller_0_enableDM_Q;
  wire controller_0_enableDV_Q;
  wire [15:0]data_mining_0_bram_addrQ;
  wire [31:0]data_mining_0_bram_data;
  wire data_mining_0_dm_done;
  wire data_mining_0_dm_enaQ;
  wire [15:0]data_mining_0_dm_read_addr;
  wire [7:0]data_validation_0_LD;
  wire [15:0]data_validation_0_bram_addr;
  wire [31:0]data_validation_0_bram_data;
  wire data_validation_0_config_dv_done;
  wire data_validation_0_dv_done;
  wire data_validation_0_dv_ena;
  wire data_validation_0_getVoteQ;
  wire receiving_0_1;
  wire system_onQ_0_1;
  wire [7:0]user_ID_0_1;

  assign BTNC_0_1 = BTNC_0;
  assign BTND_0_1 = BTND_0;
  assign BTNL_0_1 = BTNL_0;
  assign BTNR_0_1 = BTNR_0;
  assign BTNU_0_1 = BTNU_0;
  assign LD_0[7:0] = data_validation_0_LD;
  assign S_AXI_ACLK_0_1 = clk;
  assign S_AXI_ARESETN_0_1 = S_AXI_ARESETN_0;
  assign receiving_0_1 = receiving_0;
  assign system_onQ_0_1 = system_onQ_0;
  assign user_ID_0_1 = user_ID_0[7:0];
  votechain1_BRAM_0_0 BRAM_0
       (.S_AXI_ACLK(S_AXI_ACLK_0_1),
        .S_AXI_ARESETN(S_AXI_ARESETN_0_1),
        .configQ(controller_0_configQ),
        .config_bram_done(BRAM_0_config_bram_done),
        .controller_addr(controller_0_bram_addr),
        .controller_data(controller_0_bram_data),
        .controller_ena(controller_0_control_ena),
        .dm_addr(data_mining_0_bram_addrQ),
        .dm_data(data_mining_0_bram_data),
        .dm_done(data_mining_0_dm_done),
        .dm_ena(data_mining_0_dm_enaQ),
        .dm_read_addr(data_mining_0_dm_read_addr),
        .dm_read_data(BRAM_0_dm_read_data),
        .dv_addr(data_validation_0_bram_addr),
        .dv_data(data_validation_0_bram_data),
        .dv_ena(data_validation_0_dv_ena));
  votechain1_button_debounce_0_0 button_debounce_0
       (.BTNC(BTNC_0_1),
        .BTND(BTND_0_1),
        .BTNL(BTNL_0_1),
        .BTNR(BTNR_0_1),
        .BTNU(BTNU_0_1),
        .clk(S_AXI_ACLK_0_1),
        .getVote(data_validation_0_getVoteQ),
        .rst(S_AXI_ARESETN_0_1),
        .votes(button_debounce_0_votes));
  votechain1_controller_0_0 controller_0
       (.S_AXI_ACLK(S_AXI_ACLK_0_1),
        .S_AXI_ARESETN(S_AXI_ARESETN_0_1),
        .bram_addr(controller_0_bram_addr),
        .bram_data(controller_0_bram_data),
        .configQ(controller_0_configQ),
        .config_bram_done(BRAM_0_config_bram_done),
        .config_dv_done(data_validation_0_config_dv_done),
        .control_ena(controller_0_control_ena),
        .dm_done(data_mining_0_dm_done),
        .dv_done(data_validation_0_dv_done),
        .enableDM_Q(controller_0_enableDM_Q),
        .enableDV_Q(controller_0_enableDV_Q),
        .receiving(receiving_0_1),
        .system_onQ(system_onQ_0_1));
  votechain1_data_mining_0_0 data_mining_0
       (.S_AXI_ACLK(S_AXI_ACLK_0_1),
        .S_AXI_ARESETN(S_AXI_ARESETN_0_1),
        .bram_addrQ(data_mining_0_bram_addrQ),
        .bram_dataQ(data_mining_0_bram_data),
        .configQ(controller_0_configQ),
        .dm_done(data_mining_0_dm_done),
        .dm_enaQ(data_mining_0_dm_enaQ),
        .dm_read_addr(data_mining_0_dm_read_addr),
        .dm_read_data(BRAM_0_dm_read_data),
        .enableDM_Q(controller_0_enableDM_Q));
  votechain1_data_validation_0_0 data_validation_0
       (.LD(data_validation_0_LD),
        .S_AXI_ACLK(S_AXI_ACLK_0_1),
        .S_AXI_ARESETN(S_AXI_ARESETN_0_1),
        .bram_addrQ(data_validation_0_bram_addr),
        .bram_dataQ(data_validation_0_bram_data),
        .configQ(controller_0_configQ),
        .config_dv_done(data_validation_0_config_dv_done),
        .dv_done(data_validation_0_dv_done),
        .dv_enaQ(data_validation_0_dv_ena),
        .enableDV_Q(controller_0_enableDV_Q),
        .getVoteQ(data_validation_0_getVoteQ),
        .user_ID(user_ID_0_1),
        .vote(button_debounce_0_votes));
endmodule
