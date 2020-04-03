onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+votechain1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.votechain1 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {votechain1.udo}

run -all

endsim

quit -force
