BITS 16

gdt_message dw 15
db 'GDT was Loaded.'

LOADING_GDT_MSG db "Loading GDT", 0
	CODE_SEG equ GDT_code - GDT_start
	DATA_SEG equ GDT_data - GDT_start
	
Load_gdt:

	lgdt [GDT_descriptor]
	
	mov si, gdt_message
   	call Real_mode_println

ret
                                    
                                     
GDT_start:
    GDT_null:
        dd 0x0
        dd 0x0

    GDT_code:
        dw 0xffff
        dw 0x0
        db 0x0
        db 0b10011010
        db 0b11001111
        db 0x0

    GDT_data:
        dw 0xffff
        dw 0x0
        db 0x0
        db 0b10010010
        db 0b11001111
        db 0x0

GDT_end:

GDT_descriptor:
    dw GDT_end - GDT_start - 1
    dd GDT_start

