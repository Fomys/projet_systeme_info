library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use work.types.data_t;
use work.types.opcode_t;
use work.types.immediate_t;
use work.types.clk_t;
use work.types.rst_t;


entity pipeline is
    Port (  clk : in clk_t;
            rst : in rst_t;
            block_out : in std_logic;
            OP_in : in opcode_t;
            data_a_in : in data_t;
            data_b_in : in data_t;
            data_c_in : in data_t;
            OP_out : out opcode_t;
            data_a_out : out data_t;
            data_b_out : out data_t;
            data_c_out : out data_t
          );
end pipeline;

architecture Behavioral of pipeline is

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                OP_out <= OP_NOP;
                data_a_out <= (others => '0') ;
                data_b_out <= (others => '0') ;
                data_c_out <= (others => '0') ;
            elsif block_out = '0' then
                OP_out <= OP_in;
                data_a_out <= data_a_in ;
                data_b_out <= data_b_in ;
                data_c_out <= data_c_in ;
            end if;
        end if;
    end process;
end Behavioral;
