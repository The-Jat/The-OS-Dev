jmp $

; Pad the rest of the sector with zeroes
times 510 - ($ - $$) db 0

; Magic numbers indicating bootable device
dw 0xAA55

