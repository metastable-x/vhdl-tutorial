# VHDL Tutorial Series

This repository contains all RTL written for my VHDL tutorial YouTube series. Each folder corresponds to a project covered in the series.

**Full Playlist:** [youtube.com/watch?v=CRsW5iSCA6Y&list=PL0n5Xs8-BlvRgiKNislo2LvXpLIaxNPUP](https://www.youtube.com/watch?v=CRsW5iSCA6Y&list=PL0n5Xs8-BlvRgiKNislo2LvXpLIaxNPUP)

## What is VHDL?

VHDL (VHSIC Hardware Description Language) is a hardware description language used to model and design digital logic circuits. VHDL was originally developed in the 1980s under the U.S. Department of Defense's **Very High Speed Integrated Circuit** initiative and has since become one of the dominant HDLs in the industry. It's used for ASIC design and FPGA development. 

Unlike software programming languages, VHDL doesn't describe a sequence of instructions. It describes the structure and behavior of hardware. Constructs in VHDL represent real physical gates, flip-flops, and wires that can be implemented in silicon or on a programmable chip. VHDL can be used to build digital systems like digital signal processors, retro gaming consoles, or even a softcore processors (CPUs).

## Tools Used in This Series

### Simulation — ModelSim / Questasim

All simulations in this series are performed using **ModelSim** or its successor **Questasim**. ModelSim is an HDL simulator that lets you write testbenches, drive inputs, and observe waveform outputs.

### Synthesis & Bitfile Generation — Xilinx Vivado

**Vivado Design Suite** by AMD/Xilinx is used to synthesize VHDL into a netlist, run place-and-route, and generate a bitstream (`.bit` file) that is programmed onto the FPGA. The key steps in Vivado are:

1. Write/import VHDL source (`.vhd`) and constraint files (`.xdc`)
2. Run **Synthesis** — maps VHDL to FPGA primitives
3. Run **Implementation** — places and routes the design
4. **Generate Bitstream** — creates the `.bit` file
5. **Program Device** via the Hardware Manager

Vivado is available for free and supports the Artix-7 FPGA found on the Basys3 board.

### Hardware — Digilent Basys3

The **Digilent Basys3** is the target board for all hardware demonstrations in this series. It is built around a **Xilinx Artix-7 (XC7A35T)** FPGA and was made specifically for learning digital design.

Key features:
- 33,280 logic cells (Artix-7 XC7A35T)
- 100 MHz onboard oscillator
- 16 switches
- 5 pushbuttons
- 16 LEDs
- 4-digit 7-segment display
- USB-JTAG programming and UART bridge

The Basys3 can be purchased from Digilent here: [Basys3](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/)


## Repository Structure

| Folder | Topic | Description |
|--------|-------|-------------|
| [`dff/`](./dff/) | D Flip-Flop | The foundational component for modern FPGAs with an accompanying testbench|
| [`led/`](./led/) | LED Display | First hardware project with four LED tests: a single LED, an LED strobe, an LED sweep, and an LED binary counter |
| [`db/`](./db/) | Debouncer | Button debounce circuit and state machine implementation  |
| [`fifo/`](./fifo/) | FIFO | First-In First-Out buffer implementation in VHDL |

Each folder has its own `README.md` with a link to the corresponding video, a project summary, and a change log.


## Getting Started

1. **Clone the repo:**
   ```bash
   git clone https://github.com/metastable-x/vhdl-tutorial.git
   ```

2. **Simulate:** Open the project in ModelSim/Questasim, compile the source and testbench files, then run the simulation.

3. **Synthesize:** Open or create a Vivado project, add the VHDL source and constraints file, then run synthesis → implementation → generate bitstream.

4. **Program:** Connect your Basys3 over USB, open the Hardware Manager in Vivado, and program the device with the generated `.bit` file.


