[org 0x7C00]       ; BIOS loads us here
[bits 16]          ; We start in real mode

%define CENTRY 0x7E00

boot:
    jmp start

    ; Fake BIOS parameter block so this works on a real machine
    TIMES 3-($-$$) DB 0x90
    ; Dos 4.0 EBPB 1.44MB floppy
    OEMname:           db    "mkfs.fat"  ; mkfs.fat is what OEMname mkdosfs uses
    bytesPerSector:    dw    512
    sectPerCluster:    db    1
    reservedSectors:   dw    1
    numFAT:            db    2
    numRootDirEntries: dw    224
    numSectors:        dw    2880
    mediaType:         db    0xf0
    numFATsectors:     dw    9
    sectorsPerTrack:   dw    18
    numHeads:          dw    2
    numHiddenSectors:  dd    0
    numSectorsHuge:    dd    0
    driveNum:          db    0
    reserved:          db    0
    signature:         db    0x29
    volumeID:          dd    0x2d7e5a1a
    volumeLabel:       db    "NO NAME    "
    fileSysType:       db    "FAT12   "

start:
    ; Enable A20 line via BIOS
    mov ax, 0x2403
    int 15h

    jmp 0x0000:init  ; Far jump to reload CS

init:
    xor ax, ax

    ; Set up segment registers.
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Place stack above since it grows away from us
    mov sp, 0x7C00

    ; Load program into memory
    mov bx, CENTRY
    mov dh, 15
    ; DL should still contain the boot drive
    call read_disk

    ; Clear direction flag
    cld

    ; Jump to C program entry point
    jmp CENTRY

read_disk:
    ; Function to read disk sectors into memory
    ; BX: Destination address, DH: Number of sectors, DL: Drive number
    mov ah, 0x02  ; BIOS read sectors
    mov al, dh    ; Number of sectors to read
    mov ch, 0     ; Cylinder number
    mov cl, 2     ; Sector number (starting at 2)
    mov dh, 0     ; Head number
    int 0x13      ; BIOS interrupt
    jc disk_error ; Jump if carry flag is set (error)
    ret

disk_error:
    hlt  ; Halt on disk error

; Pad out file.
times 510 - ($-$$) db 0
dw 0xAA55
