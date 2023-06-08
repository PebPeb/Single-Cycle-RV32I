MEMORY
{
  instruction_memory (rx) : ORIGIN = 0x00000000, LENGTH = 256
  data_memory (rwx) : ORIGIN = 0x00000000, LENGTH = 256
}

SECTIONS
{
  .text :
  {
    *(.text)
  } > instruction_memory

  .data :
  {
    *(.data)
    *(.bss)
  } > data_memory
}
