use work.types.clk_t;
use work.types.rst_t;
use work.types.opcode_t;
use work.types.operand_t;
use work.types.address_t;
use work.types.data_t;
use work.types.register_t;
use work.types.operand_to_register;
use work.types.operand_to_data;
use work.types.data_to_address;

entity data_fetch is
    port (
        clk : in clk_t;
        rst : in rst_t;
        
        opcode : in opcode_t;
        operand_1, operand_2, operand_3 : in operand_t;
        
        addr_ram : out address_t;
        data_ram : in data_t;
        addr_reg_1, addr_reg_2 : out register_t;
        data_reg_1, data_reg_2 : in data_t;
        
        data_a, data_b : out data_t;
        addr_reg_w : out register_t;
        addr_ram_w : out address_t
    );
end data_fetch;

architecture behavioral of data_fetch is
begin
    addr_reg_1 <= operand_to_register(operand_1) when (opcode = OP_ADD_I) or (opcode = OP_SUB_I) else
                  operand_to_register(operand_3);
    addr_reg_2 <= operand_to_register(operand_2);

    data_a <= data_reg_1                 when (opcode = OP_ADD) 
                                           or (opcode = OP_SUB)
                                           or (opcode = OP_ADD_I)
                                           or (opcode = OP_SUB_I)
                                           or (opcode = OP_LT) 
                                           or (opcode = OP_CPY)
                                           or (opcode = OP_STR) else
              operand_to_data(operand_2) when (opcode = OP_AFC)
                                           or (opcode = OP_JMP)
                                           or (opcode = OP_JMZ) else
              data_ram                   when (opcode = OP_LDR) else
              (others => '0');
    data_b <= data_reg_2                 when (opcode = OP_JMP)
                                           or (opcode = OP_JMZ)
                                           or (opcode = OP_LT)
                                           or (opcode = OP_ADD)
                                           or (opcode = OP_SUB) else
              operand_to_data(operand_2) when (opcode = OP_ADD_I)
                                           or (opcode = OP_SUB_I) else
              (others => '0');

    addr_ram   <= data_to_address(data_reg_2);
    addr_ram_w <= data_to_address(data_reg_2);
    addr_reg_w <= operand_to_register(operand_1);
end architecture behavioral;
