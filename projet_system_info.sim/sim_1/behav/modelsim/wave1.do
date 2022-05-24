vsim -voptargs="+acc" -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.CPU

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /cpu/clk
add wave -noupdate -radix decimal /cpu/rst
add wave -noupdate -radix decimal /cpu/ip
add wave -noupdate -radix decimal /cpu/instruction
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/opcode_LIDI_out
add wave -noupdate -radix decimal /cpu/opcode_DIEX_out
add wave -noupdate -radix decimal /cpu/opcode_EXMEM_out
add wave -noupdate -radix decimal /cpu/opcode_MEMRE_out
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal -childformat {{/cpu/registers_i/registers(15) -radix decimal} {/cpu/registers_i/registers(14) -radix decimal} {/cpu/registers_i/registers(13) -radix decimal} {/cpu/registers_i/registers(12) -radix decimal} {/cpu/registers_i/registers(11) -radix decimal} {/cpu/registers_i/registers(10) -radix decimal} {/cpu/registers_i/registers(9) -radix decimal} {/cpu/registers_i/registers(8) -radix decimal} {/cpu/registers_i/registers(7) -radix decimal} {/cpu/registers_i/registers(6) -radix decimal} {/cpu/registers_i/registers(5) -radix decimal} {/cpu/registers_i/registers(4) -radix decimal} {/cpu/registers_i/registers(3) -radix decimal} {/cpu/registers_i/registers(2) -radix decimal} {/cpu/registers_i/registers(1) -radix decimal} {/cpu/registers_i/registers(0) -radix decimal}} -subitemconfig {/cpu/registers_i/registers(15) {-radix decimal} /cpu/registers_i/registers(14) {-radix decimal} /cpu/registers_i/registers(13) {-radix decimal} /cpu/registers_i/registers(12) {-radix decimal} /cpu/registers_i/registers(11) {-radix decimal} /cpu/registers_i/registers(10) {-radix decimal} /cpu/registers_i/registers(9) {-radix decimal} /cpu/registers_i/registers(8) {-radix decimal} /cpu/registers_i/registers(7) {-radix decimal} /cpu/registers_i/registers(6) {-radix decimal} /cpu/registers_i/registers(5) {-radix decimal} /cpu/registers_i/registers(4) {-radix decimal} /cpu/registers_i/registers(3) {-radix decimal} /cpu/registers_i/registers(2) {-radix decimal} /cpu/registers_i/registers(1) {-radix decimal} /cpu/registers_i/registers(0) {-radix decimal}} /cpu/registers_i/registers
add wave -noupdate -radix decimal /cpu/memory_manager_i/ram(8)
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_LIDI_in
add wave -noupdate -radix decimal /cpu/b_LIDI_in
add wave -noupdate -radix decimal /cpu/c_LIDI_in
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_LIDI_out
add wave -noupdate -radix decimal /cpu/b_LIDI_out
add wave -noupdate -radix decimal /cpu/c_LIDI_out
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_LIDI_out
add wave -noupdate -radix decimal /cpu/b_DIEX_in
add wave -noupdate -radix decimal /cpu/c_DIEX_in
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_DIEX_out
add wave -noupdate -radix decimal /cpu/b_DIEX_out
add wave -noupdate -radix decimal /cpu/c_DIEX_out
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_DIEX_out
add wave -noupdate -radix decimal /cpu/b_EXMEM_in
add wave -noupdate -radix decimal /cpu/c_DIEX_out
add wave -noupdate -radix decimal /cpu/alu_to_mux
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_EXMEM_out
add wave -noupdate -radix decimal /cpu/b_EXMEM_out
add wave -noupdate -radix decimal /cpu/c_EXMEM_out
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/a_MEMRE_out
add wave -noupdate -radix decimal /cpu/b_MEMRE_out
add wave -noupdate -radix decimal /cpu/c_MEMRE_out
add wave -noupdate -divider -height 15 <NULL>
add wave -noupdate -radix decimal /cpu/block_ip
add wave -noupdate -radix decimal  sim:/cpu/registers_i/registers
add wave -noupdate -radix decimal  sim:/cpu/alea_manager_i/modified_register
TreeUpdate [SetDefaultTree]
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
