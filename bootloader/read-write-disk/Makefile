.PHONY: clean, .force-rebuild
all: bootloader.bin read-disk.bin write-disk.bin

bootloader.bin: os.asm .force-rebuild
	nasm -fbin os.asm -o os.bin

run-bootloader:
	qemu-system-x86_64 -drive format=raw,file=os.bin

read-disk.bin: os.asm .force-rebuild
	nasm -fbin read-disk.asm -o read-disk.bin
	
write-disk.bin: os.asm .force-rebuild
	nasm -fbin write-disk.asm -o write-disk.bin

run-read-disk:
	qemu-system-x86_64 -fda read-disk.bin

run-write-disk:
	qemu-system-x86_64 -fda write-disk.bin

clean:
	rm *.bin
