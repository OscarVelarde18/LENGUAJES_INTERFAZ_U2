; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 8 - Operaciones aritméticas
; Descripción: Practica suma, resta, multiplicación y división, y muestra cómo cambian las banderas CF y OF.

INCLUDE Irvine32.inc               ; Librería; usamos DumpRegs para ver los resultados

.data

.code
main PROC
    ; 1. Suma y resta
    mov eax, 50
    mov ebx, 20
    add eax, ebx                    ; 50 + 20 = 70
    sub eax, 15                     ; 70 - 15 = 55
    call DumpRegs                   ; Muestra los registros para ver el resultado

    ; 2. CF (acarreo): el resultado no cabe en 8 bits sin signo
    mov eax, 0
    mov al, 255                     ; 255 es lo más grande que cabe en AL
    add al, 1                       ; AL da la vuelta y queda en 0; CF = 1
    call DumpRegs

    ; 3. OF (desbordamiento): el resultado no cabe en 8 bits con signo
    mov eax, 0
    mov al, 127                     ; 127 es el máximo positivo en 8 bits con signo
    add al, 1                       ; Pasa a 80h (-128); OF = 1
    call DumpRegs

    ; 4. MUL: multiplicación sin signo
    mov eax, 25
    mov ebx, 3
    mul ebx                         ; EAX * EBX = 75; el resultado queda en EDX:EAX
    call DumpRegs

    ; 5. MUL con un resultado muy grande
    mov eax, 65537
    mov ebx, 65537
    mul ebx                         ; No cabe en 32 bits: EDX = 1 y EAX = 00020001h
    call DumpRegs

    ; 6. IMUL: multiplicación con signo
    mov eax, -5
    imul eax, eax, 3                ; -5 * 3 = -15
    call DumpRegs

    ; 7. DIV: división sin signo
    mov eax, 125
    mov edx, 0                      ; EDX debe ser 0 antes de dividir
    mov ebx, 12
    div ebx                         ; 125 / 12: EAX = 10 (cociente) y EDX = 5 (residuo)
    call DumpRegs

    ; 8. IDIV: división con signo
    mov eax, -125
    cdq                             ; Extiende el signo de EAX hacia EDX (necesario antes de IDIV)
    mov ebx, 12
    idiv ebx                        ; -125 / 12: EAX = -10 y EDX = -5
    call DumpRegs

    exit                            ; Termina el programa
main ENDP
END main
