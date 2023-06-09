library ieee ;
use ieee.std_logic_1164.all ;


entity ALUControl is
  port (
    ALUop: in std_logic_vector(2 downto 0);
    Funct: in std_logic_vector(5 downto 0);
    ALUCont_out: out std_logic_vector(3 downto 0)
  );
end ALUControl; 

architecture alucontrol1 of ALUControl is
 signal tmpALUControl_func: std_logic_vector(3 downto 0) := (others => '0');
 signal tmpALUControl_op: std_logic_vector(3 downto 0) := (others => '0');
begin
    with Funct select
        tmpALUControl_func <=
        "0001" when "100000",
        "0010" when "100100",
        "0011" when "100101",
        "0100" when "100111",
        "0101" when "001100",
        "0110" when "001101",
        "0111" when "000000",
        "1000" when "000010",
        "1100" when "101010",
        "1111" when others;
    
    with ALUop select
        tmpALUControl_op <=
        "0001" when "001",
        "1010" when "010",
        "1011" when "011",
        "1101" when "100",
        "1111" when others;

    with ALUop select
        ALUCont_out <=
            tmpAlUControl_func when "000",
            tmpALUControl_op when others;
            
end architecture ;
