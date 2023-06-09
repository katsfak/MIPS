library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity FullAdder is
  port (
    in1, in2: in std_logic_vector(31 downto 0);
    carryin: in std_logic_vector(0 downto 0);
    sum: out std_logic_vector(31 downto 0);
    carryout: out std_logic
  );
end FullAdder; 

architecture fulladder1 of FullAdder is
    signal tmp: std_logic_vector(32 downto 0);
begin
    tmp <= std_logic_vector(to_signed(to_integer(signed(in1)) + to_integer(signed(in2)) + to_integer(signed(carryin)),33));
    carryout <= tmp(32);
    sum <= tmp(31 downto 0);
end architecture;
