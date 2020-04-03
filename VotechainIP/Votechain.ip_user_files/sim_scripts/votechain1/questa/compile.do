vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../bd/votechain1/ip/votechain1_controller_0_0/sim/votechain1_controller_0_0.v" \
"../../../bd/votechain1/ip/votechain1_BRAM_0_0/sim/votechain1_BRAM_0_0.v" \
"../../../bd/votechain1/ip/votechain1_data_validation_0_0/sim/votechain1_data_validation_0_0.v" \
"../../../bd/votechain1/ip/votechain1_button_debounce_0_0/sim/votechain1_button_debounce_0_0.v" \
"../../../bd/votechain1/ip/votechain1_data_mining_0_0/sim/votechain1_data_mining_0_0.v" \
"../../../bd/votechain1/sim/votechain1.v" \


vlog -work xil_defaultlib \
"glbl.v"

