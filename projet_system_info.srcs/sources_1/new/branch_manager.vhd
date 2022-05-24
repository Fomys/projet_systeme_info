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
        block_ip : in std_logic;
        opcode : in opcode_t;
        dest : in data_t;
        val : data_t;
        ip : out address_t
    );
end branch_manager;

architecture behavioral of branch_manager is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ip <= (others => '0');
            elsif block_ip = '0' then
                if opcode = OP_JMP_I or
                   opcode = OP_JMP then
                    ip <= data_to_address(dest);
                elsif opcode = OP_JMZ_I 
                      and val = "0" then
                    ip <= data_to_address(dest);
                else
                    ip <= ip + 1;
                end if;
            end if;
        end if;
    end process;

end architecture behavioral;
