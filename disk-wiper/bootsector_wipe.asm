[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov si, msg
    call print_string

    mov bx, 0x0000      ; buffer at 0x0000:0x0000
    mov ax, 0x0000      ; fill buffer with zeroes
    mov cx, 256         ; 512 bytes / 2 = 256 words
fill:
    mov [bx], ax
    add bx, 2
    loop fill

    mov si, 64          ;number of sectors to wipe
    mov dl, 0x80        ; first hard disk

wipe_loop:
    mov ah, 0x03        ;write sectores
    mov al, 1           ; one sector at time
    mov ch, 0           ;cylinder
    mov cl, si          ; sector nr
    mov dh, 0           ;head
    mov bx, 0x0000      ; buffer
    int 0x13            ; bios disk write

    dec si 
    jnz wipe_loop

hang:
    jmp hang

print_string:
    mov ah, 0x0E
.next:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .next
.done:
    ret

msg db "Wiping disk sectors...", 0

times 510 - ($ - $$) db 0
dw 0xAA55