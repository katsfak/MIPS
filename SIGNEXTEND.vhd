library ieee ;
use ieee.std_logic_1164.all ;

entity SignExtend is
  port (
    SignExIn: in std_logic_vector(15 downto 0);
    SignExOut: out std_logic_vector(31 downto 0)
  );
end SignExtend; 

architecture signextend1 of SignExtend is
    signal ones: std_logic_vector(15 downto 0) := (others => '1');
    signal zeros: std_logic_vector(15 downto 0) := (others => '0');

begin
    SignExOut <= ones & SignExIn when SignExIn(15) = '1' else
                 zeros & SignExIn when SignExIn(15) = '0';
end architecture ;
