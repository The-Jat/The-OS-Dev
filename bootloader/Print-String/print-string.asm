[ORG 0x7C00]

	mov si, msg     ; Set SI to point to the start of the message
print_string:
	lodsb           ; Load the byte from [SI] into AL and increment SI
	cmp al, 0       ; Check if AL is the null terminator
	je done         ; If AL is 0, we're done

	mov ah, 0x0E    ; BIOS teletype function
	mov bh, 0x00    ; Page number
	mov bl, 0x07    ; Text attribute (white on black)
	int 0x10        ; BIOS video interrupt

	jmp print_string ; Repeat for the next character

done:

	mov si, msg2     ; Set SI to point to the start of the message
	mov cx, 9      ; Length of the string

print_string2:
	mov al, [si]    ; Load the byte from [DS:SI] into AL
	cmp al, 0       ; Check if AL is the null terminator
	je done         ; If AL is 0, we're done

	mov ah, 0x0E    ; BIOS teletype function
	mov bh, 0x00    ; Page number
	mov bl, 0x07    ; Text attribute (white on black)
	int 0x10        ; BIOS video interrupt

	inc si          ; Increment SI to point to the next character
	loop print_string2 ; Repeat for the next character

	cli             ; Disable interrupts
	hlt             ; Halt the CPU

msg db 'TheJat!', 0   ; Our null-terminated string
msg2 db 'String 2!', 0   ; Our null-terminated string


times 510 - ($ - $$) db 0   ; Fill the rest of the sector with zeros
dw 0xAA55                   ; Boot signature
