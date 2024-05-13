BITS 16

;---Initialized data------------------------------------------------------------
stage2_message dw 19
db 'Entering Stage 2...'


;---Code------------------------------------------------------------------------
Stage2_entrypoint:
      ; Print 'Entering Stage 2...' message
      mov si, stage2_message
      call Real_mode_println

      ; Enable Gate A20
      call Enable_A20
      
      ; Load GDT
      call Load_gdt

       .halt: hlt ; Infinite loop. 
        jmp .halt ; (It prevents us from going off in memory and executing junk).


; Include
%include "stage2/a20.asm"
%include "stage2/gdt.asm"

