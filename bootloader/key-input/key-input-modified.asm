[ORG 0x7C00]   ; Set the origin to the BIOS boot sector address

    ; Clear the screen
	mov ah, 0x07    ; AH = 07h (Scroll down function)
	mov al, 0       ; AL = 0 lines to scroll (clear the entire screen)
	mov bh, 0x07    ; BH = 07h (attribute byte, white on black)
	mov cx, 0x0000  ; CH = 0, CL = 0 (upper left corner)
	mov dx, 0x184F  ; DH = 24, DL = 79 (lower right corner)
	int 0x10        ; Call BIOS video interrupt

    ; Move cursor to top-left corner
	mov ah, 0x02    ; AH = 02h (Set cursor position)
	mov bh, 0x00    ; BH = 0 (Page number)
	mov dh, 0x00    ; DH = 0 (Row)
	mov dl, 0x00    ; DL = 0 (Column)
	int 0x10        ; Call BIOS video interrupt


; Get And Write Characters
; Gets character from keyboard and displays it
characterLoop:
    mov ah, 0x00        ; AH = 00h (Get Key)
    int 0x16            ; Call BIOS keyboard interrupt
                        ; AL now contains ASCII character

    cmp al, 0x0D        ; Check if Enter key is pressed
    je nextLine         ; Jump to next line if Enter is pressed

    mov ah, 0x0E        ; AH = 0Eh (Display character)
    mov bh, 0x00        ; BH = 0 (Page number)
    mov bl, 0x07        ; BL = 07h (Attribute, white on black)
    int 0x10            ; Call BIOS video interrupt

    jmp characterLoop   ; Keep looping

nextLine:
    mov ah, 0x02        ; AH = 02h (Set cursor position)
    mov bh, 0x00        ; BH = 0 (Page number)
    inc dh              ; DH = 1 (Move to next line)
    mov dl, 0x00        ; DL = 0 (Column)
    int 0x10            ; Call BIOS video interrupt

    jmp characterLoop   ; Continue looping

    ; Infinite loop
    cli             ; Clear interrupts
.endloop:
    hlt             ; Halt processor
    jmp .endloop    ; Infinite loop

times 510 - ($-$$) db 0   ; Fill the rest of the sector with zeros
dw 0xAA55                 ; Boot signature
