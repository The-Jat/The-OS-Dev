[bits 16]
protected:
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEG:start_protected_mode
	
	
[bits 32]
start_protected_mode:
	mov ax, DATA_SEG       ; Data segment selector (GDT index 1)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
	mov al, 'A'
	mov ah, 0x0f
	mov [0xb8000], ax
loopy:
jmp loopy
	jmp $
