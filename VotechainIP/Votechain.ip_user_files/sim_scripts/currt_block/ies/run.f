-makelib ies_lib/xil_defaultlib -sv \
  "C:/Apps/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Apps/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../Votechain.srcs/sources_1/ip/currt_block/sim/currt_block.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

