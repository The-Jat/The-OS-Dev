.PHONY: clean, .force-rebuild
all: os.bin protect.bin

os.bin: os.asm .force-rebuild
	nasm -fbin os.asm -o os.bin

protect.bin: sample/protect.asm .force-rebuild
	nasm -fbin sample/protect.asm -o sample/protect.bin

run:
	qemu-system-x86_64 -drive format=raw,file=os.bin

run-protect:
	qemu-system-x86_64 -drive format=raw,file=sample/protect.bin

clean:
	rm *.bin
