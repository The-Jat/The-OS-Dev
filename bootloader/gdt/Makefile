.PHONY: clean, .force-rebuild
all: os.bin

os.bin: os.asm .force-rebuild
	nasm -fbin os.asm -o os.bin

run:
	qemu-system-x86_64 -drive format=raw,file=os.bin

clean:
	rm *.bin
