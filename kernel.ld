OUTPUT_ARCH(riscv)
ENTRY(_entry)

SECTIONS
{
  /* Ensure the code is loaded at QEMU's default RAM entry point */
  . = 0x80000000;

  .text : {
    *(.text .text.*)
  }

  .rodata : {
    *(.rodata .rodata.*)
  }

  .data : {
    *(.data .data.*)
  }

  .bss : {
    *(.bss .bss.*)
  }

  PROVIDE(end = .);
}
