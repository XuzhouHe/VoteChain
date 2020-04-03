vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/votechain1/ip/votechain1_controller_0_0/sim/votechain1_controller_0_0.v" \
"../../../bd/votechain1/ip/votechain1_BRAM_0_0/sim/votechain1_BRAM_0_0.v" \
"../../../bd/votechain1/ip/votechain1_data_validation_0_0/sim/votechain1_data_validation_0_0.v" \
"../../../bd/votechain1/ip/votechain1_button_debounce_0_0/sim/votechain1_button_debounce_0_0.v" \
"../../../bd/votechain1/ip/votechain1_data_mining_0_0/sim/votechain1_data_mining_0_0.v" \
"../../../bd/votechain1/sim/votechain1.v" \


vlog -work xil_defaultlib \
"glbl.v"

