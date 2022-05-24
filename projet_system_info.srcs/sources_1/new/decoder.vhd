library ieee;
use ieee.std_logic_1164.all;

use work.types.instruction_t;
use work.types.opcode_t;
use work.types.data_t;
use work.types.immediate_t;
use work.types.clk_t;
use work.types.rst_t;

entity decoder is
    port (
        clk : in clk_t;
        rst : in rst_t;
        instruction : in instruction_t;
        opcode : out opcode_t;
        operand_1 : out data_t;
        operand_2 : out data_t;
        operand_3 : out data_t
    );
end decoder;

architecture behavioral of decoder is
begin
    opcode <= OP_NOP        when instruction(7 downto 0) = x"00" else -- 1 = , 2 = , 3 =
              OP_AFC        when instruction(7 downto 0) = x"01" else -- 1 = R_dest, 2 = val, 3 =
              OP_LDR        when instruction(7 downto 0) = x"02" else -- 1 = R_dest, 2 = @src, 3 =
              OP_STR        when instruction(7 downto 0) = x"03" else -- 1 = @dest, 2 = R_src, 3 =
              OP_JMP_I      when instruction(7 downto 0) = x"04" else -- 1 = , 2 = val, 3 = 
              OP_JMZ_I      when instruction(7 downto 0) = x"05" else -- 1 = , 2 = val, 3 = R_test
              OP_CPY        when instruction(7 downto 0) = x"06" else -- 1 = R_dest, 2 = R_src, 3 =
              OP_LT         when instruction(7 downto 0) = x"08" else -- 1 = R_dest, 2 = R_src1, 3 = R_src2
              OP_ADD        when instruction(7 downto 0) = x"09" else -- 1 = R_dest, 2 = R_src1, 3 = R_src2
              OP_ADD_I      when instruction(7 downto 0) = x"0A" else -- 1 = R_dest, 2 = val, 3 = R_src2
              OP_SUB        when instruction(7 downto 0) = x"0B" else -- 1 = R_dest, 2 = R_src1, 3 = R_src2
              OP_SUB_I      when instruction(7 downto 0) = x"0C" else -- 1 = R_dest, 2 = val, 3 = R_src2
              OP_MUL        when instruction(7 downto 0) = x"0D" else -- 1 = R_dest, 2 = R_src1, 3 = R_src2
              OP_MUL_I      when instruction(7 downto 0) = x"0E" else -- 1 = R_dest, 2 = val, 3 = R_src2
              OP_LT_I       when instruction(7 downto 0) = x"0F" else -- 1 = R_dest, 2 = val, 3 = R_src2
              OP_JMP        when instruction(7 downto 0) = x"10" else -- 1 = , 2 = R_dest, 3 =
              OP_UNKNOWN;
    operand_1 <= instruction(15 downto 8);
    operand_2 <= instruction(23 downto 16);
    operand_3 <= instruction(31 downto 24);
end architecture behavioral;
