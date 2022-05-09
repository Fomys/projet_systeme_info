library ieee;
use ieee.std_logic_1164.all;

use work.types.opcode_t;
use work.types.clk_t;
use work.types.rst_t;
use work.types.register_t;

entity write_back is
    port (
        clk : in clk_t;
        rst : in rst_t;
        opcode: in opcode_t;
        w_registers : out std_logic;
        w_ram : out std_logic
    );
end write_back;

architecture behavioral of write_back is
begin 
    w_registers <= '1' when (opcode = OP_ADD)
                         or (opcode = OP_ADD_I)
                         or (opcode = OP_SUB)
                         or (opcode = OP_SUB_I)
                         or (opcode = OP_CPY)
                         or (opcode = OP_LT)
                         or (opcode = OP_AFC)
                         or (opcode = OP_LDR) else
                   '0';
    w_ram <= '1' when (opcode = OP_STR) else
             '0';
end architecture behavioral;
