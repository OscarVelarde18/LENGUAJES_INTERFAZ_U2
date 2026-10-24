; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 11 - Operaciones lógicas
; Descripción: Usa AND, OR, XOR, NOT y TEST para consultar y cambiar bits de un byte de estado.

INCLUDE Irvine32.inc               ; Librería; usamos DumpRegs para ver los resultados

.data

.code
main PROC
    ; Cada bit del byte guarda un dato:
    ;   bit 0 = encendido, bit 1 = alarma, bit 2 = conectada
    ; Estado inicial: 00000101b (encendido y conectada)

    ; 1 - AND: sirve para "aislar" un bit y ver cuánto vale
    mov eax, 0
    mov ebx, 0
    mov al, 00000101b
    mov bl, al
    and bl, 00000001b               ; La máscara deja solo el bit 0; BL = 1 significa "encendido"
    call DumpRegs
    nop

    ; 2 - OR: sirve para encender un bit
    mov al, 00000101b
    or al, 00000010b                ; Enciende el bit 1 (alarma); AL = 00000111b
    call DumpRegs
    nop

    ; 3 - XOR: sirve para cambiar un bit (si estaba en 1 pasa a 0, y viceversa)
    mov al, 00000111b
    xor al, 00000010b               ; Invierte el bit de alarma; AL = 00000101b
    call DumpRegs
    nop

    ; 4 - NOT: invierte todos los bits
    mov al, 00000101b
    not al                          ; Los 0 pasan a 1 y los 1 a 0; AL = 11111010b
    call DumpRegs
    nop

    ; 5 - TEST: revisa un bit sin cambiar el valor de AL
    mov al, 00000101b
    test al, 00000010b              ; El bit 1 vale 0, así que ZF = 1; AL se queda igual
    call DumpRegs
    nop

    exit                            ; Termina el programa
main ENDP
END main
