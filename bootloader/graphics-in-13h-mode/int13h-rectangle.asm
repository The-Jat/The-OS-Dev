; Set up basic graphics mode (320x200, 256 colors) in BIOS bootloader

BITS 16            ; 16-bit real mode
ORG 0x7C00         ; Bootloader entry point

start:
	mov ax, 0x0013 ; Set video mode 0x13 (320x200, 256 colors)
	int 0x10       ; BIOS interrupt to set video mode

    ; Draw a rectangle with top-left corner at (100, 100), width 50, height 30, with color 0x0F (white)
	mov al, 0x03	 ; Color (white)
	mov cx, 100	 ; X coordinate of top-left corner
	mov dx, 100	 ; Y coordinate of top-left corner
	mov si, [width] 	; Width of the rectangle
	mov di, [height]	; Height of the rectangle
	
	call draw_rectangle

    jmp $          ; Infinite loop

; Function to draw a rectangle with top-left corner at (CX, DX), width SI, height DI, with color AL
draw_rectangle:
    pusha
draw_row:
    call draw_pixel
    inc cx         ; Move to the next pixel in the row
    
	dec si		; Decrement the width by one
	cmp si, 0	; Check if we reached the end of the row that complete width
    je next_row		; if we drawn complete row, jump to next row. 
    jmp draw_row	; Continue drawing the row, until the row completely drawn

next_row:
	mov cx, 100	; Initial coordinates of x

	inc dx		; move y to one down
	mov si, [width]	; reset to x to start of the next row.
	dec di		; decrement the height by 1
	cmp di, 0	; check if we height is 0
	je done       ; If yes, we are done
    jmp draw_row   ; Start drawing the next row

done:
    popa
    ret

; Function to draw a pixel at (CX, DX) with color AL
draw_pixel:
    mov ah, 0x0C   ; BIOS function to plot a pixel
    int 0x10       ; BIOS interrupt
    ret

width dw 15	; width of the rectangle
height dw 15	; height of the rectangle

TIMES 510 - ($ - $$) db 0 ; Fill the rest of the bootloader sector with zeros
DW 0xAA55                 ; Boot signature

