library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.types.opcode;
use work.types.immediate;
use work.types.data;

entity ALU_selector is
    Port ( data_a : in data;
           data_b : in data;
           data_w : in data;
           immediate : in immediate;
           opcode : in opcode;
           A : out data;
           B : out data);
end ALU_selector;

architecture Behavioral of ALU_selector is

begin
    A <= immediate when (opcode = OP_ADD_I) or (opcode = OP_SUB_I) else 
         data_a;
    B <= data_w when (opcode = OP_ADD_I) or (opcode = OP_SUB_I) else
         data_b;
end Behavioral;
