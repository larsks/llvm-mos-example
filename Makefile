CC = /usr/local/pkg/llvm-mos/bin/mos-c64-clang
OBJDUMP = /usr/local/pkg/llvm-mos/bin/llvm-objdump

%.lst: %.elf
	$(OBJDUMP) --disassemble $< > $@ || { rm -f $@; exit 1; }

all: hello-strout.elf hello-strout.lst hello-printf.elf hello-printf.lst

hello-strout.elf hello-strout: hello-strout.o strout.o
	$(CC) -o $(@:.elf=) $^

hello-printf.elf hello-printf: hello-printf.o
	$(CC) -o $(@:.elf=) $^

clean:
	rm -f hello-strout hello-printf *.o *.elf *.lst
