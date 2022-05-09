######################################################################
#
# File name : CPU_simulate.do
# Created on: Wed May 04 13:52:55 CEST 2022
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.CPU

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

add wave -position end -radix decimal sim:/cpu/pc_reg_to_branch_manager
add wave -position end -radix decimal sim:/cpu/operand_1
add wave -position end -radix decimal sim:/cpu/operand_2
add wave -position end -radix decimal sim:/cpu/operand_3
add wave -position end -divider -height 30
add wave -position end sim:/cpu/opcode
add wave -position end -radix decimal sim:/cpu/addr_reg_1
add wave -position end -radix decimal sim:/cpu/addr_reg_2
add wave -position end -radix decimal sim:/cpu/addr_reg_w
add wave -position end -divider -height 30
add wave -position end -radix decimal sim:/cpu/data_reg_1
add wave -position end -radix decimal sim:/cpu/data_reg_2
add wave -position end -radix decimal sim:/cpu/data_a
add wave -position end -radix decimal sim:/cpu/data_b
add wave -position end -radix decimal sim:/cpu/data_alu
add wave -position end -radix decimal sim:/cpu/w_registers
add wave -position end -radix decimal sim:/cpu/pc_branch_manager_to_reg
add wave -position end -divider -height 30
add wave -position end -radix decimal sim:/cpu/registers_i/registers(15) 
add wave -position end -radix decimal sim:/cpu/registers_i/registers(14)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(13)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(12) 
add wave -position end -radix decimal sim:/cpu/registers_i/registers(11)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(10)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(9) 
add wave -position end -radix decimal sim:/cpu/registers_i/registers(8)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(7)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(6) 
add wave -position end -radix decimal sim:/cpu/registers_i/registers(5)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(4)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(3) 
add wave -position end -radix decimal sim:/cpu/registers_i/registers(2)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(1)
add wave -position end -radix decimal sim:/cpu/registers_i/registers(0)
add wave -position end -divider -height 30
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(8)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(7)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(6)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(5)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(4)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(3)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(2)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(1)
add wave -position end -radix decimal sim:/cpu/memory_manager_i/ram(0) 
view wave
view structure
view signals

do {CPU.udo}

run 500 ns


