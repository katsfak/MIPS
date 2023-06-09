library ieee;
use ieee.std_logic_1164.all;

entity TestBenchRam is
end TestBenchRam;

architecture testbenchram1 of TestBenchRam is

component Memory
    port(
        inRAM: in std_logic_vector(31 downto 0);
        WriteData: in std_logic_vector(31 downto 0);
        MemWrite: in std_logic;
        MemRead: in std_logic;
        outRAM: out std_logic_vector(31 downto 0);
        reset: in std_logic
    );
end component;
    signal CLK: std_ulogic;
    signal Rst: std_ulogic;
    signal inRAM: std_logic_vector(31 downto 0);
    signal WriteData: std_logic_vector(31 downto 0);
    signal MemWrite: std_logic;
    signal MemRead: std_logic;
    signal outRAM: std_logic_vector(31 downto 0);

begin
UUT: Memory port map(inRAM, WriteData, MemWrite, MemRead, outRAM, Rst);
    clock: process
        variable clktmp: std_ulogic := '1';
        variable reset: std_ulogic := '1';
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
stimilus: process(CLK)
begin
    if (rising_edge(CLK)) then
        inRam <= "00000000000000000000000000000110";
        WriteData <= "11000000000000000000000000000011";
        MemWrite <= '1' after 2 ns;
        MemRead <= '0';    
    end if ;
    end process;
end architecture;
