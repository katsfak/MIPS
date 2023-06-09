library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity Registers is
  port (
    RegIn1, RegIn2, RegWriteIn: in std_logic_vector(4 downto 0);
    DataWriteIn: in std_logic_vector(31 downto 0);
    RegWrite: in std_logic;
    RegOut1, RegOut2: out std_logic_vector(31 downto 0)
  );
end Registers; 

architecture registers1 of Registers is
    type registers is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs: registers := (others => (others => '0'));
    signal RegWriteDelayed: std_logic;
    signal x: std_logic_vector(31 downto 0) := (others => 'X');
begin
    RegOut1 <= regs(to_integer(unsigned(RegIn1)));
    RegOut2 <= regs(to_integer(unsigned(RegIn2)));
    RegWriteDelayed <= transport RegWrite after 1 ns;
    regs(to_integer(unsigned(RegWriteIn))) <= DataWriteIn when
    (RegWriteDelayed = '1' and DataWriteIn /= x);
end architecture ;
