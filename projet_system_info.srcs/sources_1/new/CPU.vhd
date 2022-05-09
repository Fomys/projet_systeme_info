library ieee;
use ieee.std_logic_1164.all;

use work.ALU;
use work.registers;
use work.decoder;
use work.write_back;
use work.rom;
use work.branch_manager;
use work.data_fetch;
use work.memory_manager;
use work.types.data_t;
use work.types.opcode_t;
use work.types.instruction_t;
use work.types.immediate_t;
use work.types.address_t;
use work.types.operand_t;
use work.types.register_t;
use work.types.clk_t;
use work.types.rst_t;

entity CPU is

end CPU;

architecture Behavioral of CPU is
    constant CLK_PERIOD: time := 10 ns;
    signal clk : clk_t := '0';
    signal rst : rst_t := '0';
    
    signal pc : address_t;
    
    signal instruction : instruction_t;
    signal operand_1, operand_2, operand_3 : operand_t;
    signal opcode : opcode_t;
    
    signal addr_ram : address_t;
    signal data_ram : data_t;
    signal addr_reg_1, addr_reg_2 : register_t;
    signal data_reg_1, data_reg_2 : data_t;
    
    signal data_a, data_b, data_alu, data_w : data_t;
    signal addr_reg_w : register_t;
    signal addr_ram_w : address_t;
    
    signal w_registers, w_ram : std_logic;
begin
    clk <= not clk after CLK_PERIOD / 2;
    
    rom_i : entity rom port map(
        clk => clk,
        rst => rst,
        read_addr   => pc, 
        instruction => instruction
    );
    decode_i : entity decoder port map(
        clk => clk,
        rst => rst,
        instruction => instruction,
        opcode      => opcode,
        operand_1   => operand_1,
        operand_2   => operand_2,
        operand_3   => operand_3
    );
    registers_i : entity registers port map (
        clk     => clk,
        rst     => rst,
        addr_1  => addr_reg_1,
        addr_2  => addr_reg_2,
        addr_w  => addr_reg_w,
        data_1  => data_reg_1,
        data_2  => data_reg_2,
        w       => w_registers,
        data_w  => data_w,
        pc      => pc
    );
    memory_manager_i : entity memory_manager port map(
        clk => clk,
        rst => rst,
        opcode => opcode,
        addr => addr_ram,
        data_read => data_ram,
        data_write => data_alu
    );
    data_fetch_i : entity data_fetch port map(
        clk => clk,
        rst => rst,
        opcode      => opcode,
        operand_1   => operand_1,
        operand_2   => operand_2,
        operand_3   => operand_3,
        
        addr_ram    => addr_ram,
        data_ram    => data_ram,
        addr_reg_1  => addr_reg_1,
        data_reg_1  => data_reg_1,
        addr_reg_2  => addr_reg_2,
        data_reg_2  => data_reg_2,
        
        data_a      => data_a,
        data_b      => data_b,
        addr_reg_w       => addr_reg_w,
        addr_ram_w       => addr_ram_w
    );
    ALU_i : entity ALU port map ( --
        clk => clk,
        rst => rst,
        opcode => opcode,
        data_a => data_a,
        data_b => data_b,
        data_r => data_alu
    );
    write_back_i : entity write_back port map ( --
        clk => clk,
        rst => rst,
        opcode => opcode,
        w_registers => w_registers,
        w_ram => w_ram,
        data_w => data_w
    );
    branch_manager_i : entity branch_manager port map(
        clk => clk,
        rst => rst,
        opcode => opcode,
        jmp_dst => data_a,
        data => data_b
    );
    
    
    
    -- Reset du processeur
    process
    begin
        rst <= '1';
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD * 10000;
    end process;
end Behavioral;