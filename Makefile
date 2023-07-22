MOD = Od1n

ASM :=nasm

PWD :=$(shell pwd)
BUILD := build
SRC := src

BOOTLOADER := $(SRC)/bootloader.asm
MAKEFILE := $(PWD)/Makefile 

all:
	mkdir -p build
	cp $(SRC)/Makefile $(SRC)/$(MOD).c $(BUILD)
	$(MAKE) -C $(KPATH) M=$(PWD)/build modules EXTRA_CFLAGS="-g"

bootloader:
	@echo "🚀 Making bootloader."
	@mkdir -p $(BUILD)
	@$(ASM) $(BOOTLOADER) -f bin -o $(BUILD)/bootloader.img
	@truncate -s 1440k $(BUILD)/bootloader.img

clean:
	@echo "✅ Build folder cleaned"
	@rm $(BUILD)/*

test:
	@qemu-system-i386 -fda build/bootloader.img