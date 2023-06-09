library ieee;
use ieee.std_logic_1164.all;


entity OutputControl is
  port (
    CLK: in std_logic;
    OC_in: in std_logic_vector(5 downto 0);
    RegWrite: out std_logic := '0';
    ALUSrc: out std_logic;
    ALUop: out std_logic_vector(2 downto 0);
    MemWrite: out std_logic;
    MemRead: out std_logic;
    RegDst: out std_logic;
    MemToReg: out std_logic;
    Jump: out std_logic;
    Branch: out std_logic
  );
end OutputControl; 

architecture outputcontrol1 of OutputControl is

begin
    with OC_in select
        RegWrite <=
            ('1' and CLK) when "100011",
            ('1' and CLK) when "000000",
            ('1' and CLK) when "001000",
            '0' when others;
    
    with OC_in select
        ALUSrc <=
            '1' after 2 ns when "100011",
            '1' after 2 ns when "101011",
            '1' after 2 ns when "001000",
            '0' when others;

    with OC_in select
        ALUop <=
            "000" after 2 ns when "000000",
            "001" after 2 ns when "100011",
            "001" after 2 ns when "101011",
            "010" after 2 ns when "000100",
            "011" after 2 ns when "000101",
            "100" after 2 ns when "001000",
            "111" when others;

    with OC_in select
        MemWrite <=
            '1' after 10 ns when "101011",
            '0' when others;
    
    with OC_in select
        MemRead <=
            '1' after 2 ns when "100011",
            '0' when others;

    with OC_in select
        MemToReg <=
            '1' after 2 ns when "100011",
            '0' when others;

    with OC_in select
        RegDst <=
            '0' when "100011",
            '0' when "001000",
            '1' when others;

    with OC_in select
        Jump <=
            '1' when "000010",
            '0' when others;

    with OC_in select
        Branch <=
            '1' when "000100",
            '1' when "000101",
            '0' when others;
end architecture ;
