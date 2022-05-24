----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2022 11:29:04 AM
-- Design Name: 
-- Module Name: alea_manager - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.clk_t;
use work.types.opcode_t;
use work.types.rst_t ;
use work.types.register_t;
use work.types.modified_register_t;

entity alea_manager is
    Port ( clk : in clk_t;
           rst : in rst_t;
           opcode : in opcode_t;
           a : in register_t;
           b : in register_t;
           c : in register_t;
           w : in std_logic;
           w_addr : in register_t;
           block_ip : out std_logic); --signal de blocage de comptage pour attendre la fin de modication d'un registre
end alea_manager;

architecture Behavioral of alea_manager is
    signal tmodified_register : modified_register_t ;
begin
    process(clk)
        variable modified_register : modified_register_t ; -- compteur de modification pour chaque registre
    begin
        if falling_edge(clk) then
            if rst = '1' then
                block_ip <= '0'; 
                modified_register := (others => 0);
            else
                if    opcode = OP_AFC
                   or opcode = OP_LDR then --simple écriture, sans lecture préalable
                    modified_register(to_integer(unsigned(a))) := modified_register(to_integer(unsigned(a))) + 1 ;
                elsif    opcode = OP_STR
                      or opcode = OP_JMP then --simple lecture d'un registre (b), sans écriture postérieure 
                    if modified_register(to_integer(unsigned(b))) = 0 then
                        block_ip <= '0'; 
                    else
                        block_ip <= '1';
                    end if;
                elsif opcode = OP_JMZ_I then
                    if     modified_register(to_integer(unsigned(b))) = 0
                       and modified_register(to_integer(unsigned(c))) = 0 then --simple lecture de deux registres (b, c), sans écriture postérieure 
                        block_ip <= '0'; 
                    else
                        block_ip <= '1';
                    end if;
                elsif opcode = OP_CPY then -- lecture d'un registre (b) puis écriture => notification de la modification
                    if modified_register(to_integer(unsigned(b))) = 0 then
                        block_ip <= '0';
                        modified_register(to_integer(unsigned(a))) := modified_register(to_integer(unsigned(a))) + 1 ;
                    else
                        block_ip <= '1';
                    end if;
                elsif opcode = OP_ADD_I
                   or opcode = OP_SUB_I
                   or opcode = OP_MUL_I
                   or opcode = OP_LT_I then -- lecture d'un registre (c) puis écriture => notification de la modification
                   if modified_register(to_integer(unsigned(c))) = 0 then
                        block_ip <= '0';
                        modified_register(to_integer(unsigned(a))) := modified_register(to_integer(unsigned(a))) + 1 ;
                    else
                        block_ip <= '1';
                    end if;
                elsif opcode = OP_ADD
                   or opcode = OP_SUB
                   or opcode = OP_MUL
                   or opcode = OP_LT then -- lecture de deux registres (b,c) puis écriture => notification de la modification
                   if modified_register(to_integer(unsigned(b))) = 0 and
                      modified_register(to_integer(unsigned(c))) = 0 then
                        block_ip <= '0';
                        modified_register(to_integer(unsigned(a))) := modified_register(to_integer(unsigned(a))) + 1 ;
                    else
                        block_ip <= '1';
                    end if;
                end if;
                
                if w = '1' then  -- une écriture est faite, on notifie la fin de la modification
                    modified_register(to_integer(unsigned(w_addr))) := modified_register(to_integer(unsigned(w_addr))) - 1;
                end if;
            end if;
        end if;
        tmodified_register <= modified_register;
    end process;

end Behavioral;
