library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.address_t;
use work.types.instruction_t;
use work.types.rom_array_t;

entity rom is
    Port (
        rst : in std_logic;
        clk : in std_logic;
        read_addr : in address_t;
        instruction : out instruction_t
    );
end rom;

architecture behavioral of rom is
    signal rom_data : rom_array_t := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) and rst = '1' then
rom_data(0) <= x"00_02_00_01";
rom_data(1) <= x"00_00_00_06";
rom_data(2) <= x"00_02_01_01";
rom_data(3) <= x"00_01_01_06";
rom_data(4) <= x"00_05_02_01";
rom_data(5) <= x"00_02_02_06";
rom_data(6) <= x"00_07_03_01";
rom_data(7) <= x"00_03_03_06";
rom_data(8) <= x"00_0b_04_01";
rom_data(9) <= x"00_04_04_06";
rom_data(10) <= x"00_02_05_08";
rom_data(11) <= x"05_0e_00_05";
rom_data(12) <= x"00_00_04_06";
rom_data(13) <= x"00_0f_00_04";
rom_data(14) <= x"00_01_04_06";
rom_data(15) <= x"01_00_00_09";
rom_data(16) <= x"02_00_00_09";
rom_data(17) <= x"03_00_00_09";
rom_data(18) <= x"04_00_00_09";
rom_data(19) <= x"00_00_00_06";
rom_data(20) <= x"00_00_00_00";


        end if;
    end process;
    instruction <= rom_data(to_integer(unsigned(read_addr)));
end architecture behavioral;
