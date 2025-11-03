# MIPS

VHDL implementation of a simple MIPS processor

## Description

This project provides a **VHDL** implementation of a simple MIPS-style processor.
It includes the fundamental modules for an ALU, instruction and data memory, registers, program counter, multiplexers, and control logic.

The goal of this repository is to serve as an **educational tool** for understanding how a MIPS processor can be built and simulated in hardware description languages such as VHDL.

---

## Project Structure

```
/MIPS
│
├─ ALU.vhd               -- Arithmetic Logic Unit
├─ ALUCONTROL.vhd        -- ALU control unit
├─ FULLADDER.vhd         -- Full adder component
├─ INSTRUCTIONMEMORY.vhd -- Instruction memory
├─ MEMORY.vhd            -- Data memory
├─ MIPS.vhd              -- Top-level MIPS processor module
├─ MUX2_32.vhd           -- 2-to-1 multiplexer (32-bit)
├─ MUX2_5.vhd            -- 2-to-1 multiplexer (5-bit)
├─ OUTPUTCONTROL.vhd     -- Output control module
├─ PROGRAMCOUNTER.vhd    -- Program counter
├─ REGISTERS.vhd         -- General purpose register file
├─ SHIFTER.vhd           -- Shifter unit
├─ SIGNEXTEND.vhd        -- Sign extension unit
├─ TESTBENCHALU.vhd      -- ALU testbench
├─ TESTBENCHMIPS.vhd     -- Full processor testbench
├─ TESTBENCHRAM.vhd      -- Memory testbench
└─ README.md             -- This file
```

---

## Prerequisites

To simulate or synthesize this project, you’ll need:

* A VHDL simulator (e.g., **ModelSim**, **GHDL**)
* (Optional) An FPGA toolchain for synthesis (e.g., **Vivado**, **Quartus**)
* Basic knowledge of VHDL and MIPS architecture concepts

---

## Usage / Simulation

1. Clone the repository:

   ```bash
   git clone https://github.com/katsfak/MIPS.git
   cd MIPS
   ```

2. Open the desired testbench file in your VHDL tool (for example, `TESTBENCHMIPS.vhd`).

3. Compile all design files and set `MIPS.vhd` as the top-level entity.

4. Run the simulation and observe the processor’s operation — instruction fetching, ALU operations, register updates, and memory access.

5. *(Optional)* For FPGA implementation, create a constraints file and synthesize the design using your chosen tool.

---

## Architecture Overview

The processor follows a basic **RISC MIPS** architecture, including:

* **Fetch stage:** `INSTRUCTIONMEMORY.vhd` and `PROGRAMCOUNTER.vhd` handle instruction fetching.
* **Decode/Execute stage:** The `ALU.vhd` performs arithmetic and logic operations under control of `ALUCONTROL.vhd`.
* **Memory stage:** `MEMORY.vhd` performs load and store operations.
* **Register file:** `REGISTERS.vhd` stores general-purpose registers.
* **Additional units:**

  * `SHIFTER.vhd` for shifting operations
  * `SIGNEXTEND.vhd` for sign extension
  * `OUTPUTCONTROL.vhd` for output logic
  * Multiplexers (`MUX2_32.vhd`, `MUX2_5.vhd`) to control data paths

---

## Testing

The repository includes multiple testbenches:

* `TESTBENCHALU.vhd` — Verifies ALU operations (add, subtract, logic).
* `TESTBENCHRAM.vhd` — Tests memory read/write functionality.
* `TESTBENCHMIPS.vhd` — Performs full processor verification, including instruction execution and signal monitoring.

You can extend these testbenches with new instruction programs and visualize signals in your simulator.

---

## Author Information
Project Owner: Aikaterini Eirini Sfakianou

GitHub: https://github.com/katsfak/MIPS

Email: katsfak12@gmail.com
