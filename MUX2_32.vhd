library ieee ;
use ieee.std_logic_1164.all ;


entity MUX2_32 is
 port (
    MUXin1, MUXin2: in std_logic_vector(31 downto 0);
    MUXout: out std_logic_vector(31 downto 0);
    sel: in std_logic
  );
end MUX2_32; 

architecture mux2_321 of MUX2_32 is

begin
    MUXout <= MUXin1 when sel='0' else
              MUXin2 when sel='1';
end architecture ;