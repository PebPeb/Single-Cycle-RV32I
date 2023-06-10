
# RISC-V Single Cycle RV32I CPU

This project is an implementation of a Single Cycle CPU utilizing the RISC-V ISA. The design is based off of the RV32I implementation as outlined in the [RISC-V Instruction Set Manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). Therefor making this a 32-bit cpu, written all in **Verilog**. This project was mostly made as a hobby and educational purposes, and I talk more about that and the design process [here on my website](https://brycekeen.com/projects/Single-Cycle-RV32I).

## Requirements

- A general understanding of the RV32I implementation as referenced in the [RISC-V Instruction Set Manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf) may help with understanding of this project.
- A Verilog synthesis tool is needed for this project i used [Icarus Verilog](https://steveicarus.github.io/iverilog/).
- GTKWave or a waveform viewer of your choice (All my scripts are set up with GTKWave).
- 32 bit RISC-V Toolchain ([guide to build the toolchain](https://github.com/riscv/riscv-gnu-toolchain)) for more details on how to compile assembly or C refer to programs folder.



**Note:** This project is currently under active development and I'm not perfect ;)

