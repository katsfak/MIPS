library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity InstructionMemory is
  port (
    inIM: in std_logic_vector(31 downto 0);
    outIM: out std_logic_vector(31 downto 0)
  );
end InstructionMemory; 

architecture instructionmemory1 of InstructionMemory is
    type mem_type is array (natural range <>) of std_logic_vector(7 downto 0);
    signal mem: mem_type(0 to 1023) := (others => (others => '0'));
    signal FullInstruction: std_logic_vector(31 downto 0);
    signal IM_address: integer;
begin
    IM_address <= to_integer(unsigned(inIM)) when
     (to_integer(unsigned(inIM)) >= 0) else 0;
    FullInstruction <= mem(IM_address) & mem(IM_address+1) & mem(IM_address+2) & mem(IM_address+3)
    when (IM_address >= 0) else std_logic_vector(to_signed(-1,32));
    outIM <= FullInstruction;
end architecture ;
