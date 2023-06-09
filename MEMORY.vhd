library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
  port (
    inRAM, WriteData: in std_logic_vector(31 downto 0);
    MemWrite, MemRead: in std_logic;
    outRAM: out std_logic_vector(31 downto 0);
    reset: in std_logic
  );
end Memory; 

architecture memory1 of Memory is
    type ram_type is array (natural range <>) of std_logic_vector(31 downto 0);
    signal ram: ram_type(0 to 1023) := (others => (others => '0'));
    signal Address: integer := 0;
begin

    Address <= to_integer(unsigned(inRAM)) when
    (to_integer(unsigned(inRAM)) <= 1023) else 0;

    ram(Address) <= WriteData when (MemWrite = '1' and reset = '0');
    
    with reset select
        outRAM <=
          ram(Address) when '0',
          (others => '0') when others;
end architecture ;
