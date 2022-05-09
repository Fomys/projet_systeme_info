library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

use work.types.clk_t;
use work.types.rst_t;
use work.types.opcode_t;
use work.types.data_t;
use work.types.address_t;
use work.types.data_to_address;

entity branch_manager is
    port (
        clk : in clk_t;
        rst : in rst_t;
        opcode : in opcode_t;
        jmp_dst : in data_t;
        data : in data_t;
        pc : out address_t
    );
end branch_manager;

architecture behavioral of branch_manager is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                pc <= (others => '0');
            else
                pc <= data_to_address(jmp_dst) when (opcode = OP_JMP) else
                      data_to_address(jmp_dst) when (opcode = OP_JMZ) and (data = 0) else
                      pc + 1;
            end if;
        end if;
    end process;

end architecture behavioral;
