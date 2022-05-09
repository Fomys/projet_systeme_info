library ieee;
use ieee.std_logic_1164.all;

use work.types.instruction_t;
use work.types.opcode_t;
use work.types.operand_t;
use work.types.immediate_t;
use work.types.clk_t;
use work.types.rst_t;

entity decoder is
    port (
        clk : in clk_t;
        rst : in rst_t;
        instruction : in instruction_t;
        opcode : out opcode_t;
        operand_1 : out operand_t;
        operand_2 : out operand_t;
        operand_3 : out operand_t
    );
end decoder;

architecture behavioral of decoder is
begin
    opcode <= OP_NOP        when instruction(7 downto 0) = x"00" else
              OP_AFC        when instruction(7 downto 0) = x"01" else
              OP_LDR        when instruction(7 downto 0) = x"02" else
              OP_STR        when instruction(7 downto 0) = x"03" else
              OP_JMP        when instruction(7 downto 0) = x"04" else
              OP_JMZ        when instruction(7 downto 0) = x"05" else
              OP_CPY        when instruction(7 downto 0) = x"06" else
              OP_LT         when instruction(7 downto 0) = x"08" else
              OP_ADD        when instruction(7 downto 0) = x"09" else
              OP_ADD_I      when instruction(7 downto 0) = x"0A" else
              OP_SUB        when instruction(7 downto 0) = x"0B" else
              OP_SUB_I      when instruction(7 downto 0) = x"0C" else
              OP_UNKNOWN;
    operand_1 <= instruction(15 downto 8);
    operand_2 <= instruction(23 downto 16);
    operand_3 <= instruction(31 downto 24);
end architecture behavioral;
