BITS 16

idt_message dw 15
db 'IDT was Loaded.'



Load_idt:

	lidt [idt_descriptor]
	
	mov si, idt_message
   	call Real_mode_println

ret

; Define IDT entries
idt_data:
	times 256 dd 0 ; 256 entries, each entry is 8 bytes long
	
; IDT descriptor
idt_descriptor:
	dw $ - idt_data - 1;
	dd idt_data
	
