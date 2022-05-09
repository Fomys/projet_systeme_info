library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.register_t;
use work.types.register_array_t;
use work.types.data_t;
use work.types.address_t;

entity registers is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        
        addr_1 : in register_t;
        addr_2 : in register_t;
        addr_w : in register_t;
        data_w : in data_t;
        w : in std_logic;
        data_1 : out data_t;
        data_2 : out data_t;
        pc : in address_t
    );
end registers;

architecture behavioral of registers is
    signal registers : register_array_t;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                registers <= (others => (others => '0'));
            elsif W = '1' then
                registers(to_integer(unsigned(addr_w))) <= data_w;
            end if;
        end if;
    end process;
    
    registers(15) <= pc;
    
    data_1 <= registers(to_integer(unsigned(addr_1)));
    data_2 <= registers(to_integer(unsigned(addr_2)));
end architecture behavioral;
