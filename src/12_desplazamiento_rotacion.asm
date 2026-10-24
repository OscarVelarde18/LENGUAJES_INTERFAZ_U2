; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 12 - Desplazamiento y rotación
; Descripción: Mueve los bits de un número a la izquierda o derecha con SHL, SHR, SAR y las rotaciones ROL, ROR, RCL y RCR.

INCLUDE Irvine32.inc               ; Librería; usamos DumpRegs y WriteBin

.data

.code
main PROC
    mov eax, 0                      ; Limpiamos los registros para empezar en cero
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; 1 - SHL: mueve los bits una posición a la izquierda
    mov al, 10000000b
    shl al, 1                       ; El bit de la izquierda sale a CF; AL = 00000000b
    call DumpRegs
    call WriteBin                   ; Muestra EAX en binario
    call Crlf

    ; 2 - SHR: mueve los bits una posición a la derecha
    mov al, 00001101b
    shr al, 1                       ; AL = 00000110b y el bit que salió (1) queda en CF
    call DumpRegs
    call WriteBin
    call Crlf

    ; 3 - SAR: igual que SHR, pero conserva el signo del número
    mov al, -8                      ; -8 en binario es 11111000b
    sar al, 1                       ; AL = 11111100b, que es -4
    call DumpRegs
    call WriteBin
    call Crlf

    ; 4 - SAR con un número impar negativo
    mov al, -9                      ; -9 en binario es 11110111b
    sar al, 1                       ; AL = 11111011b, que es -5 (redondea hacia abajo)
    call DumpRegs
    call WriteBin
    call Crlf

    ; 5 - SHL de 2 posiciones (equivale a multiplicar por 4)
    mov al, 00001111b
    shl al, 2                       ; AL = 00111100b
    call WriteBin
    call Crlf
    call DumpRegs

    ; 6 - SHR de 2 posiciones, usando CL para indicar cuántas
    mov al, 00001111b
    mov cl, 2                       ; CL guarda el número de posiciones a mover
    shr al, cl                      ; AL = 00000011b
    call WriteBin
    call Crlf
    call DumpRegs

    ; 7 - Rotaciones: los bits que salen por un lado entran por el otro
    ; ROL rota a la izquierda
    mov al, 10010001b
    rol al, 1                       ; El bit de la izquierda pasa a la derecha: AL = 00100011b
    call DumpRegs

    ; ROR rota a la derecha
    mov al, 10010001b
    ror al, 1                       ; El bit de la derecha pasa a la izquierda: AL = 11001000b
    call DumpRegs

    ; RCL rota a la izquierda pasando por la bandera CF
    clc                             ; Ponemos CF = 0
    mov al, 10000001b
    rcl al, 1                       ; Entra el valor de CF (0) por la derecha: AL = 00000010b, CF = 1
    call DumpRegs

    ; RCR rota a la derecha pasando por la bandera CF
    stc                             ; Ponemos CF = 1
    mov al, 00000010b
    rcr al, 1                       ; Entra el valor de CF (1) por la izquierda: AL = 10000001b, CF = 0
    call DumpRegs

    exit                            ; Termina el programa
main ENDP
END main
