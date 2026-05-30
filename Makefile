CC = riscv64-elf-gcc
LD = riscv64-elf-ld
OBJCOPY = riscv64-elf-objcopy

CFLAGS = -Wall -Werror -O0 -fno-omit-frame-pointer -ggdb -mcmodel=medany -ffreestanding -fno-common -nostdlib -mno-relax

kernel: entry.s main.c kernel.ld
	$(CC) $(CFLAGS) -c entry.s -o entry.o
	$(CC) $(CFLAGS) -c main.c -o main.o
	$(LD) -T kernel.ld -o kernel entry.o main.o

QEMU = qemu-system-riscv64
QEMUOPTS = -machine virt -bios none -kernel kernel -m 128M -smp 4 -nographic
GDBPORT = 6969
QEMUGDB = $(shell if $(QEMU) -help | grep -q '^-gdb'; \
	then echo "-gdb tcp::$(GDBPORT)"; \
	else echo "-s -p $(GDBPORT)"; fi)

qemu: kernel
	$(QEMU) $(QEMUOPTS)

.gdbinit: .gdbinit
	sed "s/:1234/:$(GDBPORT)/" < $^ > $@

qemu-gdb: kernel .gdbinit fs.img
	@echo "*** Now run 'gdb' in another window." 1>&2
	$(QEMU) $(QEMUOPTS) -S $(QEMUGDB)

print-gdbport:
	@echo $(GDBPORT)

clean:
	rm -f *.o kernel
