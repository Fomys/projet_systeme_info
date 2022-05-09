library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.clk_t;
use work.types.rst_t;
use work.types.address_t;
use work.types.data_t;
use work.types.ram_array_t;
use work.types.opcode_t;

entity memory_manager is
    port (
        clk : in clk_t;
        rst : in rst_t;
        addr : in address_t;
        data_read : out data_t;
        data_write : in data_t;
        opcode : in opcode_t
    );
end memory_manager;

architecture behavioral of memory_manager is
    signal ram: ram_array_t;
begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ram <= (others => (others => '0'));
            elsif opcode = OP_STR then
                ram(to_integer(unsigned(addr))) <= data_write;
            end if;
        end if;
    end process;
    
    data_read <= ram(to_integer(unsigned(addr)));

end architecture behavioral;
