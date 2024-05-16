; Set up basic graphics mode (320x200, 256 colors) in BIOS bootloader

BITS 16            ; 16-bit real mode
ORG 0x7C00         ; Bootloader entry point

start:
    mov ax, 0x0013 ; Set video mode 0x13 (320x200, 256 colors)
    int 0x10       ; BIOS interrupt to set video mode

    ; Draw a pixel at coordinates (100, 100) with color 0x0F (white)
    mov al, 0x0f  ; Color (white)
    mov cx, 100   ; X coordinate
    mov dx, 100    ; Y coordinate
    call draw_pixel

    jmp $          ; Infinite loop

; Function to draw a pixel at (CX, DX) with color AX
draw_pixel:
    pusha
    mov ah, 0x0C   ; BIOS function to plot a pixel
    int 0x10       ; BIOS interrupt
    popa
   ret



TIMES 510 - ($ - $$) db 0 ; Fill the rest of the bootloader sector with zeros
DW 0xAA55                 ; Boot signature
