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
rom_data(1) <= x"00_03_01_01";
rom_data(2) <= x"00_05_02_01";
rom_data(3) <= x"00_07_03_01";
rom_data(4) <= x"00_00_05_0A";
rom_data(5) <= x"00_05_00_03";
rom_data(6) <= x"00_00_05_0C";
rom_data(7) <= x"00_0b_00_01";
rom_data(8) <= x"00_01_05_0A";
rom_data(9) <= x"00_05_00_03";
rom_data(10) <= x"00_01_05_0C";
rom_data(11) <= x"00_00_05_0A";
rom_data(12) <= x"00_05_00_02";
rom_data(13) <= x"00_00_05_0C";
rom_data(14) <= x"00_00_05_0A";
rom_data(15) <= x"01_05_00_03";
rom_data(16) <= x"00_00_05_0C";
rom_data(17) <= x"02_00_01_08";
rom_data(18) <= x"00_18_01_05";
rom_data(19) <= x"00_01_05_0A";
rom_data(20) <= x"01_05_00_02";
rom_data(21) <= x"00_01_05_0C";
rom_data(22) <= x"00_00_01_06";
rom_data(23) <= x"00_1f_00_04";
rom_data(24) <= x"00_01_05_0A";
rom_data(25) <= x"00_05_00_03";
rom_data(26) <= x"00_01_05_0C";
rom_data(27) <= x"00_00_05_0A";
rom_data(28) <= x"00_05_00_02";
rom_data(29) <= x"00_00_05_0C";
rom_data(30) <= x"00_00_01_06";
rom_data(31) <= x"00_01_05_0A";
rom_data(32) <= x"00_05_00_02";
rom_data(33) <= x"00_01_05_0C";
rom_data(34) <= x"00_00_00_09";
rom_data(35) <= x"00_02_00_09";
rom_data(36) <= x"00_03_00_09";
rom_data(37) <= x"00_01_00_09";
rom_data(38) <= x"00_00_00_00";
        end if;
    end process;
    instruction <= rom_data(to_integer(unsigned(read_addr)));
end architecture behavioral;
