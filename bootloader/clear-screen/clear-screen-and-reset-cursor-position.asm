; This code snippet demos the scroll up and scroll down function to clear the screen
; and set cursor position function to set the cursor position to (0, 0)
;

[ORG 0x7C00]   ; Set the origin to the BIOS boot sector address

; Clear the screen with scroll up function 0x06
	mov ah, 0x06    ; AH = 06h (Scroll up function)
	mov al, 0       ; AL = 0 lines to scroll up (clear the entire screen)
	mov bh, 0x07    ; BH = 07h (attribute byte, white on black)
	mov cx, 0x00    ; CX = 184Fh (attribute and blank character)
	mov dx, 0x184f  ; DH = 0, DL = 0 (upper left corner)
	int 0x10        ; Call BIOS video interrupt

; Print a char to be able to clear
	mov ah, 0x0E     ; Function 0x0E of BIOS interrupt 10h: Teletype output
	mov al, 'J'      ; Load 'H' into AL
	mov bl, 0x0F
	int 0x10     
	
; Clear the screen with scroll down function 0x07
	mov ah, 0x07    ; AH = 06h (Scroll up function)
	mov al, 0       ; AL = 0 lines to scroll up (clear the entire screen)
	mov bh, 0x07    ; BH = 07h (attribute byte, white on black)
	mov cx, 0x00    ; CX = 184Fh (attribute and blank character)
	mov dx, 0x184f  ; DH = 0, DL = 0 (upper left corner)
	int 0x10        ; Call BIOS video interrupt

; Now we have to set the cursor position to top left corner
; because we just clear the screen, the cursor is still at
; previous position

    ; Set Cursor Position
	mov ah, 0x02    ; AH = 02h (Set cursor position)
	mov bh, 0x00    ; BH = 0 (Page number)
	mov dh, 0x00    ; DH = 0 (Row)
	mov dl, 0x00    ; DL = 0 (Column)
	int 0x10        ; Call BIOS video interrupt

    ; Infinite loop
	cli             ; Clear interrupts
.endloop:
	hlt             ; Halt processor
	jmp .endloop    ; Infinite loop

times 510 - ($-$$) db 0   ; Fill the rest of the sector with zeros
dw 0xAA55                 ; Boot signature
