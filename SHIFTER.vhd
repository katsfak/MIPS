library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity Shifter is
  port (
    Sin: in std_logic_vector(31 downto 0);
    Sout: out std_logic_vector(31 downto 0);
    opS: in std_ulogic;
    num: in std_logic_vector(4 downto 0)
  );
end Shifter; 

architecture shifter1 of Shifter is
    signal tmp: unsigned(31 downto 0);
begin
    tmp <= to_unsigned(to_integer(signed(Sin)), tmp'length) sll
    to_integer(signed(num)) when opS='0' else 

    to_unsigned(to_integer(signed(Sin)), tmp'length) srl
    to_integer(signed(num)) when opS = '1';

    Sout <= std_logic_vector(to_signed(to_integer(tmp),Sout'length));
end architecture ;
