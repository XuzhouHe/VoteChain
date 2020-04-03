-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Sat Apr 27 22:20:17 2019
-- Host        : RDP-SRV1 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ votechain_1_votechain1_0_0_stub.vhdl
-- Design      : votechain_1_votechain1_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    BTNC_0 : in STD_LOGIC;
    BTND_0 : in STD_LOGIC;
    BTNL_0 : in STD_LOGIC;
    BTNR_0 : in STD_LOGIC;
    BTNU_0 : in STD_LOGIC;
    LD_0 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_ARESETN_0 : in STD_LOGIC;
    clk : in STD_LOGIC;
    receiving_0 : in STD_LOGIC;
    system_onQ_0 : in STD_LOGIC;
    user_ID_0 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "BTNC_0,BTND_0,BTNL_0,BTNR_0,BTNU_0,LD_0[7:0],S_AXI_ARESETN_0,clk,receiving_0,system_onQ_0,user_ID_0[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "votechain1,Vivado 2018.2";
begin
end;
