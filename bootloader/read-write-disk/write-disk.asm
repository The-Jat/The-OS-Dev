[org 0x7c00]

BUFFER_SIZE equ 512             ; Size of the buffer
BUFFER      equ 0x7e00          ; Address of the buffer

; Save boot disk number
mov [BOOT_DISK], dl

; Setting up the stack
xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

; Filling the buffer with 'B's
mov di, BUFFER                 ; Set DI to point to the buffer
mov cx, BUFFER_SIZE            ; Set CX to the size of the buffer
mov al, 'B'                    ; AL = 'B'
rep stosb                      ; Fill the buffer with 'B's

; Writing the buffer to the disk
mov ah, 3                      ; AH = 3 (Write sectors to disk)
mov al, 1                      ; AL = number of sectors to write
mov ch, 0                      ; CH = cylinder number
mov dh, 0                      ; DH = head number
mov cl, 2                      ; CL = starting sector number (sector 3)
mov dl, [BOOT_DISK]            ; DL = boot disk number
mov bx, BUFFER                 ; Set BX to point to the buffer
int 0x13                       ; BIOS interrupt to write disk sectors

; Reading the sector back into the buffer
mov ah, 2                      ; AH = 2 (Read sectors from disk)
mov al, 1                      ; AL = number of sectors to read
mov ch, 0                      ; CH = cylinder number
mov dh, 0                      ; DH = head number
mov cl, 2                      ; CL = starting sector number (sector 3)
mov dl, [BOOT_DISK]            ; DL = boot disk number
mov bx, BUFFER                 ; Set BX to point to the buffer
int 0x13                       ; BIOS interrupt to read disk sectors

; Printing the content of the buffer
mov si, BUFFER                 ; Set SI to point to the buffer
mov cx, BUFFER_SIZE            ; Set CX to the size of the buffer

print_loop:
    mov ah, 0x0e               ; AH = 0Eh (teletype output)
    lodsb                      ; Load byte from [SI] into AL and increment SI
    or al, al                  ; Check if AL is zero (end of string)
    jz print_done              ; If zero, jump to print_done
    int 0x10                   ; BIOS interrupt for video services
    jmp print_loop             ; Continue printing characters

print_done:
    jmp $                      ; Infinite loop

BOOT_DISK: db 0                ; Boot disk number

; Magic padding
times 510-($-$$) db 0
dw 0xaa55
