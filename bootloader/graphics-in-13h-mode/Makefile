.PHONY: clean, .force-rebuild
all: int13h-pixel int13h-rectangle

int13h-pixel: .force-rebuild
	nasm -fbin int13h-pixel.asm -o int13h-pixel.bin

run-int13h-pixel:
	qemu-system-x86_64 -drive format=raw,file=int13h-pixel.bin

int13h-rectangle: .force-rebuild
	nasm -fbin int13h-rectangle.asm -o int13h-rectangle.bin

run-int13h-rectangle:
	qemu-system-x86_64 -drive format=raw,file=int13h-rectangle.bin


clean:
	rm *.bin
