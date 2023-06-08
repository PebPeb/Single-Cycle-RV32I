# Single Cycle RV32I


## Compiling Code

### Requirements

- 32 bit RISC-V Toolchain ([guide to build the toolchain](https://github.com/riscv/riscv-gnu-toolchain))


``` bash
riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib -Wl,-T,cpu_memory.ld -o out.elf test.c
riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib -Wl,-T,cpu_memory.ld,-Map=out.map -o out.elf test.c
riscv32-unknown-elf-objdump -d out.elf
riscv32-unknown-elf-objcopy -O binary out.elf test.bin
hexdump -e '"%08x\n"' test.bin
hexdump -e '"%08x\n"' test.bin > text.hex
```


