library ieee;
use ieee.std_logic_1164.all;

package types is
    subtype register_t is std_logic_vector(3 downto 0);
    subtype operand_t is std_logic_vector(7 downto 0);
    subtype instruction_t is std_logic_vector(31 downto 0);
    subtype data_t is std_logic_vector(7 downto 0);
    subtype immediate_t is std_logic_vector(15 downto 0);
    subtype address_t is std_logic_vector(7 downto 0);
    subtype clk_t is std_logic;
    subtype rst_t is std_logic;
    type memory_array_t is array(1024 downto 0) of data_t;
    type rom_array_t is array(255 downto 0) of instruction_t;
    type ram_array_t is array(255 downto 0) of data_t;
    type register_array_t is array(15 downto 0) of data_t;
    type opcode_t is (
        OP_AFC,
        OP_LDR,
        OP_STR,
        OP_JMP,
        OP_JMZ,
        OP_CPY,
        OP_NOP,
        OP_LT,
        OP_ADD,
        OP_ADD_I,
        OP_SUB,
        OP_SUB_I,
        OP_UNKNOWN
    );
    function operand_to_register(op: operand_t)
        return register_t;
    function operand_to_data(op: operand_t)
        return data_t;
    function data_to_address(data: data_t)
        return address_t;
    function operand_to_address(operand: operand_t)
        return address_t;
    function address_to_data(address: address_t)
        return data_t;
end package types;

package body types is
    function operand_to_register(op: operand_t)
        return register_t is
    begin
        return op(3 downto 0);
    end function operand_to_register;
    
    function operand_to_data(op: operand_t)
        return data_t is
    begin
        return op(7 downto 0);
    end function operand_to_data;
    
    function data_to_address(data: data_t)
        return address_t is
    begin
        return data(7 downto 0);
    end function data_to_address;
    
    function operand_to_address(operand: operand_t)
        return address_t is
    begin
        return operand(7 downto 0);
    end function operand_to_address;
    
    function address_to_data(address: address_t)
        return data_t is
    begin
        return address(7 downto 0);
    end function address_to_data;
end package body types;
