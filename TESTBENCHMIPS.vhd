library ieee;
use ieee.std_logic_1164.all;

entity TestBench is
end TestBench;

architecture testbenchmips of TestBench is

    component MIPS
        port(
            CLK: in std_logic;
            Rst: in std_logic;
            outMIPS: out std_logic_vector(31 downto 0)
        );
    end component;

    signal CLK: std_logic;
    signal Rst: std_logic;
    signal outMIPS: std_logic_vector(31 downto 0);

begin

    UUT: MIPS
        port map(CLK, Rst, outMIPS);

    clock:process
        variable clktmp: std_logic := '1';
        variable reset: std_logic := '1';
    begin
        clktmp := not clktmp;
        CLK <= clktmp;
        if (reset = '1') then
          Rst <= reset;
          reset := '0';
        else
            Rst <= '0';
        end if;
        wait for 50 ns;
    end process;
end architecture;
