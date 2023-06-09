library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

entity ProgramCounter is
  port (
    inPC: in std_logic_vector(31 downto 0);
    outPC: out std_logic_vector(31 downto 0);
    CLK: in std_logic;
    Rst: in std_logic
  );
end ProgramCounter; 

architecture programcounter1 of ProgramCounter is

begin
    reg: process(CLK)
    begin
        if (Rst = '1') then
            outPC <= std_logic_vector(to_signed(-4,32));
        end if;
        if rising_edge(CLK) then
          outPC <= inPC;
        end if;
    end process; 
end architecture ;