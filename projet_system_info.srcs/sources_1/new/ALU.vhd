library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

use work.types.data_t;
use work.types.opcode_t;
use work.types.immediate_t;
use work.types.clk_t;
use work.types.rst_t;

entity alu is
    port (
        clk : in clk_t;
        rst : in rst_t;
        opcode : in opcode_t;
        data_a : in data_t;
        data_b : in data_t;
        data_r : out data_t
    );
end alu;

architecture behavioral of alu is
    signal add : data_t;
    signal sub : data_t;
    signal lt : data_t;
    signal mul : data_t;
begin
    add <= data_a + data_b;
    sub <= data_a - data_b;
    lt  <= "00000001" when data_a < data_b else
           "00000000";
    mul <= data_a(3 downto 0) * data_b(3 downto 0);

    data_r <= add    when (opcode = OP_ADD)
                       or (opcode = OP_ADD_I) else
              sub    when (opcode = OP_SUB)
                       or (opcode = OP_SUB_I) else
              mul    when (opcode = OP_MUL)
                       or (opcode = OP_MUL_I) else
              lt     when (opcode = OP_LT) else
              data_a when (opcode = OP_AFC) 
                       or (opcode = OP_CPY)
                       or (opcode = OP_LDR)
                       or (opcode = OP_STR) else
              (others => '0');
end architecture behavioral;
