library ieee;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity MIPS is
  port (
    CLK: in std_logic;
    Rst: in std_logic;
    outMIPS: out std_logic_vector(31 downto 0)
  );
end MIPS ; 

architecture mips1 of MIPS is
    component FullAdder
    port (
      in1,in2: in std_logic_vector(31 downto 0);
      carryin: in std_logic_vector(0 downto 0);
      sum: out std_logic_vector(31 downto 0);
      carryout: out std_logic      
    );
    end component;

    component ALU
    port (
      in1,in2: in std_logic_vector(31 downto 0);
      op: in std_logic_vector(3 downto 0);
      outALU: out std_logic_vector(31 downto 0);
      Zero: out std_logic
    );
    end component;

    component ProgramCounter
    port (
      inPC: in std_logic_vector(31 downto 0);
      outPC: out std_logic_vector(31 downto 0);
      CLK: in std_ulogic;
      Rst: in std_ulogic
    );
    end component;

    component InstructionMemory
    port (
      inIM: in std_logic_vector(31 downto 0);
      outIM: out std_logic_vector(31 downto 0)
    );
    end component;

    component Registers
    port (
      RegIn1, RegIn2, RegWriteIn: in std_logic_vector(4 downto 0);
      DataWriteIn: in std_logic_vector(31 downto 0);
      RegWrite: in std_logic;
      RegOut1, RegOut2: out std_logic_vector(31 downto 0)
    );
    end component;

    component ALUControl
    port (
      ALUop: in std_logic_vector(2 downto 0);
      Funct: in std_logic_vector(5 downto 0);
      ALUCont_out: out std_logic_vector(3 downto 0)
    );
    end component;

    component OutputControl
    port(
      CLK: in std_logic;
      OC_in: in std_logic_vector(5 downto 0);
      RegWrite: out std_logic;
      ALUSrc: out std_logic;
      ALUop: out std_logic_vector(2 downto 0);
      MemWrite: out std_logic;
      MemRead: out std_logic;
      RegDst: out std_logic;
      MemToReg: out std_logic;
      Jump: out std_logic;
      Branch: out std_logic
    );
    end component;

    component Memory
      port (
        inRAM: in std_logic_vector(31 downto 0);
        WriteData: in std_logic_vector(31 downto 0);
        MemWrite: in std_logic;
        MemRead: in std_logic;
        outRAM: out std_logic_vector(31 downto 0);
        reset: in std_logic
      );
      end component;

      component MUX2_5
        port (
          MUXin1, MUXin2: in std_logic_vector(4 downto 0);
          MUXout: out std_logic_vector(4 downto 0);
          sel: in std_logic
        );
      end component;

      component MUX2_32
        port (
          MUXin1, MUXin2: in std_logic_vector(31 downto 0);
          MUXout: out std_logic_vector(31 downto 0);
          sel: in std_logic
        );
      end component;

      component SignExtend
        port (
          SignExIn: in std_logic_vector(15 downto 0);
          SignExOut: out std_logic_vector(31 downto 0)
        );
      end component;

signal RegWrite: std_logic;
signal ALUSrc: std_logic;
signal MemWrite: std_logic;
signal MemRead: std_logic;
signal RegDst: std_logic;
signal MemToReg: std_logic;
signal Jump: std_logic;
signal Zero: std_logic;
signal Branch: std_logic;
signal BranchTaken: std_logic;
signal PC_FA_IM: std_logic_vector(31 downto 0);
signal FA_PC_OUT: std_logic_vector(31 downto 0);
signal OUT_IM: std_logic_vector(31 downto 0);
signal FOUR: std_logic_vector(31 downto 0);
signal outALU: std_logic_vector(31 downto 0);
signal ALUop: std_logic_vector(2 downto 0);
signal RegOut1: std_logic_vector(31 downto 0);
signal RegOut2: std_logic_vector(31 downto 0);
signal ALUControl_out: std_logic_vector(3 downto 0);
signal DataWriteIn: std_logic_vector(31 downto 0);
signal MUXregOut: std_logic_vector(4 downto 0);
signal MUXaluOut: std_logic_vector(31 downto 0);
signal SignExOut: std_logic_vector(31 downto 0);
signal outRAM: std_logic_vector(31 downto 0);
signal ShiftJump2MuxJump: std_logic_vector(31 downto 0);
signal MuxJump2PC: std_logic_vector(31 downto 0);
signal MuxBranch2MuxJump: std_logic_vector(31 downto 0);
signal ALUbranchOut: std_logic_vector(31 downto 0);
signal SignExOutAligned: std_logic_vector(31 downto 0);

begin
  FOUR <= std_logic_vector(to_unsigned(1,32));
  FA_PC1: FullAdder
    port map(
      in1 => PC_FA_IM,
      in2 => FOUR,
      carryin => "0",
      sum => FA_PC_OUT
    );

  SignExOutAligned <= SignExOut(29 downto 0) & "00";

  FA_BRANCH: FULLAdder
    port map(
      in1 => FA_PC_OUT,
      in2 => SignExOutAligned,
      carryin => "0",
      sum => ALUbranchOut
    );
  
  PC1: ProgramCounter
    port map(
      inPC => MuxJump2PC,
      outPC => PC_FA_IM,
      CLK => CLK,
      Rst => Rst
    );

  IM1: InstructionMemory
    port map(
      inIM => PC_FA_IM,
      outIM => OUT_IM
    );

  REG1: Registers
    port map(
      RegIn1 => OUT_IM(25 downto 21),
      RegIn2 => OUT_IM(20 downto 16),
      RegWriteIn => MUXregOut,
      DataWriteIn => DataWriteIn,
      RegWrite => RegWrite,
      RegOut1 => RegOut1,
      RegOut2 => RegOut2
    );

  OC1: OutputControl
    port map(
      CLK => CLK,
      OC_in => OUT_IM(31 downto 26),
      RegWrite => RegWrite,
      ALUSrc => ALUSrc,
      ALUop => ALUop,
      MemWrite => MemWrite,
      MemRead => MemRead,
      RegDst =>RegDst,
      MemToReg => MemToReg,
      Jump => Jump,
      Branch => Branch
    );

  ALUC_1: ALUControl
    port map(
      ALUop => ALUop,
      Funct => OUT_IM(5 downto 0),
      ALUCont_out => ALUControl_out
    );

  ALU1: ALU
    port map(
      in1 => RegOut1,
      in2 => MUXaluOut,
      op => ALUControl_out,
      outALU => outALU,
      Zero => Zero
    );

  RAM1: Memory
    port map(
      inRAM => outALU,
      WriteData => RegOut2,
      MemWrite => MemWrite,
      MemRead => MemRead,
      outRAM => outRAM,
      reset => Rst
    );

  MUXreg: MUX2_5
    port map(
      MUXin1 => OUT_IM(20 downto 16),
      MUXin2 => OUT_IM(15 downto 11),
      MUXout => MUXregOut,
      sel => RegDst
    );

  MUXaluIn: MUX2_32
    port map(
      MUXin1 => RegOut2,
      MUXin2 => SignExOut,
      MUXout => MUXaluOut,
      sel => ALUSrc
    );

  MUXram: MUX2_32
    port map(
      MUXin1 => outALU,
      MUXin2 => outRAM,
      MUXout => DataWriteIn,
      sel => MemToReg
    );

    ShiftJump2MuxJump <= FA_PC_OUT(31 downto 28) & OUT_IM(25 downto 0) & "00";

  MUXjump: MUX2_32
    port map(
      MUXin1 => MuxBranch2MuxJump,
      MUXin2 => ShiftJump2MuxJump,
      MUXout => MuxJump2PC,
      sel => Jump
    );

  BranchTaken <= Branch and Zero;

  MUXbranch: MUX2_32
  port map(
    MUXin1 => FA_PC_OUT,
    MUXin2 => ALUbranchOut,
    MUXout => MuxBranch2MuxJump,
    sel => BranchTaken
  );

  SignEx1: SignExtend
    port map(
      SignExIn => OUT_IM(15 downto 0),
      SignExOut => SignExOut 
    );

    outMIPS <= outALU;
  
end architecture ;
