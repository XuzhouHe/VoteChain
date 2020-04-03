vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../bd/votechain_1/sim/votechain_1.v" \
"../../../bd/votechain_1/ipshared/6464/sim/votechain1_controller_0_0.v" \
"../../../bd/votechain_1/ipshared/6464/sim/votechain1_BRAM_0_0.v" \
"../../../bd/votechain_1/ipshared/6464/sim/votechain1_data_validation_0_0.v" \
"../../../bd/votechain_1/ipshared/6464/sim/votechain1_button_debounce_0_0.v" \
"../../../bd/votechain_1/ipshared/6464/sim/votechain1_data_mining_0_0.v" \
"../../../bd/votechain_1/ipshared/6464/sim/controller.v" \
"../../../bd/votechain_1/ipshared/6464/sim/blk_mem_gen_1.v" \
"../../../bd/votechain_1/ipshared/6464/sim/BRAM.v" \
"../../../bd/votechain_1/ipshared/6464/sim/data_validation.v" \
"../../../bd/votechain_1/ipshared/6464/sim/button_debounce.v" \
"../../../bd/votechain_1/ipshared/6464/sim/addr_timing_ctrl.v" \
"../../../bd/votechain_1/ipshared/6464/sim/extend.v" \
"../../../bd/votechain_1/ipshared/6464/sim/k_rom.v" \
"../../../bd/votechain_1/ipshared/6464/sim/sha256_top.v" \
"../../../bd/votechain_1/ipshared/6464/sim/update_h.v" \
"../../../bd/votechain_1/ipshared/6464/sim/w_ram.v" \
"../../../bd/votechain_1/ipshared/6464/sim/data_mining.v" \
"../../../bd/votechain_1/ipshared/6464/sim/votechain1.v" \
"../../../bd/votechain_1/ip/votechain_1_votechain1_0_1/sim/votechain_1_votechain1_0_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

