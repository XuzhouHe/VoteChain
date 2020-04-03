onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib votechain1_opt

do {wave.do}

view wave
view structure
view signals

do {votechain1.udo}

run -all

quit -force
