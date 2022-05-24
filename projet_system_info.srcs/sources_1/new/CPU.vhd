library ieee;
use ieee.std_logic_1164.all;

use work.ALU;
use work.registers;
use work.decoder;
use work.write_back;
use work.rom;
use work.branch_manager;
use work.memory_manager;
use work.pipeline;
use work.alea_manager;
use work.types.data_to_register;
use work.types.data_to_address;
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
    constant CLK_PERIOD: time := 100 ps;
    signal clk : clk_t := '0';
    signal rst : rst_t := '0';
    signal ip : address_t;
    signal instruction : instruction_t;
    
    signal opcode_LIDI_in, opcode_LIDI_out : opcode_t;
    signal a_LIDI_in, b_LIDI_in, c_LIDI_in, a_LIDI_out, b_LIDI_out, c_LIDI_out : data_t ;
    
    signal block_ip : std_logic;
    
    signal registers_to_mux : data_t;
    
    signal opcode_DIEX_in, opcode_DIEX_out : opcode_t;
    signal b_DIEX_in, c_DIEX_in, a_DIEX_out, b_DIEX_out, c_DIEX_out : data_t ;
    
    signal alu_to_mux : data_t;
    
    signal opcode_EXMEM_in, opcode_EXMEM_out : opcode_t;
    signal b_EXMEM_in, a_EXMEM_out, b_EXMEM_out, c_EXMEM_out : data_t ;
    
    signal mux_to_memory_manager, memory_manager_to_mux : data_t;
    
    signal opcode_MEMRE_in, opcode_MEMRE_out : opcode_t;
    signal b_MEMRE_in, a_MEMRE_out, b_MEMRE_out, c_MEMRE_out : data_t ;
    
    signal w : std_logic;
    
    begin
    clk <= not clk after CLK_PERIOD / 2;
    -- Reset du processeur
    process
    begin
        rst <= '1';
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD * 10000;
    end process;
    
    branch_manager_i : entity branch_manager port map (
        rst => rst,
        clk => clk,
        opcode => opcode_DIEX_in,
        dest => b_DIEX_in,
        val => c_DIEX_in,
        block_ip => block_ip,
        ip => ip
    );
    
    rom_i : entity ROM port map(
        rst => rst,
        clk => clk,
        read_addr => ip,
        instruction => instruction
    );
    
    decoder_i : entity decoder port map(
        clk => clk,
        rst => rst,
        instruction => instruction,
        opcode => opcode_LIDI_in,
        operand_1 => a_LIDI_in,
        operand_2 => b_LIDI_in,
        operand_3 => c_LIDI_in
    );
    
    pipeline_LIDI : entity pipeline port map(
       clk => clk,
       rst => rst,
       block_out => block_ip,
       OP_in => opcode_LIDI_in,
       data_a_in => a_LIDI_in,
       data_b_in => b_LIDI_in,
       data_c_in => c_LIDI_in,
       OP_out => opcode_LIDI_out,
       data_a_out => a_LIDI_out,
       data_b_out => b_LIDI_out,
       data_c_out => c_LIDI_out
    );
   
   alea_manager_i : entity alea_manager port map(
        clk => clk,
        rst => rst,
        opcode => opcode_LIDI_out,
        a => data_to_register(a_LIDI_out),
        b => data_to_register(b_LIDI_out),
        c => data_to_register(c_LIDI_out),
        w_addr => data_to_register(a_MEMRE_out),
        w => w,
        block_ip => block_ip
   );
   
    registers_i : entity registers port map(
        clk => clk,
        rst => rst,
        addr_1 => data_to_register(b_LIDI_out),
        addr_2 => data_to_register(c_LIDI_out),
        addr_w => data_to_register(a_MEMRE_out),
        data_w => b_MEMRE_out,
        w => w,
        data_1 => registers_to_mux,
        data_2 => c_DIEX_in
    );
    
    b_DIEX_in <= registers_to_mux when opcode_LIDI_out = OP_CPY or
                                       opcode_LIDI_out = OP_ADD or
                                       opcode_LIDI_out = OP_MUL or
                                       opcode_LIDI_out = OP_LT or
                                       opcode_LIDI_out = OP_SUB or
                                       opcode_LIDI_out = OP_STR or
                                       opcode_LIDI_out = OP_JMP else
                 b_LIDI_out       when opcode_LIDI_out = OP_AFC or
                                       opcode_LIDI_out = OP_LDR or
                                       opcode_LIDI_out = OP_ADD_I or
                                       opcode_LIDI_out = OP_SUB_I or
                                       opcode_LIDI_out = OP_MUL_I or
                                       opcode_LIDI_out = OP_LT_I or
                                       opcode_LIDI_out = OP_JMP_I or
                                       opcode_LIDI_out = OP_JMZ_I else
                 (others => '0');
                 
    opcode_DIEX_in <= OP_NOP when block_ip = '1' else
                      opcode_LIDI_out;
    
    pipeline_DIEX : entity pipeline port map(
       clk => clk,
       rst => rst,
       block_out => '0',
       OP_in => opcode_DIEX_in,
       data_a_in => a_LIDI_out,
       data_b_in => b_DIEX_in,
       data_c_in => c_DIEX_in,
       OP_out => opcode_DIEX_out,
       data_a_out => a_DIEX_out,
       data_b_out => b_DIEX_out,
       data_c_out => c_DIEX_out
    );
    
    alu_i : entity ALU port map(
       clk => clk,
       rst => rst,
       opcode => opcode_DIEX_out,
       data_a => b_DIEX_out,
       data_b => c_DIEX_out,
       data_r => alu_to_mux
    );
  
    b_EXMEM_in <= alu_to_mux when opcode_DIEX_out = OP_ADD or
                                  opcode_DIEX_out = OP_MUL or
                                  opcode_DIEX_out = OP_LT or
                                  opcode_DIEX_out = OP_SUB else
                  b_DIEX_out when opcode_DIEX_out = OP_AFC or 
                                  opcode_DIEX_out = OP_CPY or
                                  opcode_DIEX_out = OP_STR or
                                  opcode_DIEX_out = OP_LDR else
                 (others => '0');
    
    pipeline_EXMEM : entity pipeline port map(
       clk => clk,
       rst => rst,
       block_out => '0',
       OP_in => opcode_DIEX_out,
       data_a_in => a_DIEX_out,
       data_b_in => b_EXMEM_in,
       data_c_in => c_DIEX_out, --BLC
       OP_out => opcode_EXMEM_out,
       data_a_out => a_EXMEM_out,
       data_b_out => b_EXMEM_out
  --     data_c_out => 
    );
    
    
    mux_to_memory_manager <= a_EXMEM_out when opcode_EXMEM_out = OP_STR else
                             b_EXMEM_out when opcode_EXMEM_out = OP_LDR else
                             (others => '0');
    
    memory_manager_i : entity memory_manager port map(
       clk => clk,
       rst => rst,
       addr => data_to_address(mux_to_memory_manager),
       data_read => memory_manager_to_mux,
       data_write => b_EXMEM_out,
       opcode => opcode_EXMEM_out
    );
    
    b_MEMRE_in <= memory_manager_to_mux when opcode_EXMEM_out = OP_LDR else
                  b_EXMEM_out;
    
    pipeline_MEMRE : entity pipeline port map(
       clk => clk,
       rst => rst,
       block_out => '0',
       OP_in => opcode_EXMEM_out,
       data_a_in => a_EXMEM_out,
       data_b_in => b_MEMRE_in,
       data_c_in => a_EXMEM_out,--BLC
       OP_out => opcode_MEMRE_out,
       data_a_out => a_MEMRE_out,
       data_b_out => b_MEMRE_out
   --    data_c_out => 
    );
    
    write_back_i : entity write_back port map(
       clk => clk,
       rst => rst,
       opcode => opcode_MEMRE_out,
       w_registers => w
    );
    
    
    
end Behavioral;