; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 13 - Obtención de una cadena hexadecimal
; Descripción: Convierte un número a texto hexadecimal (8 caracteres) separando sus bits de 4 en 4.

INCLUDE Irvine32.inc               ; Librería Irvine32

.data
    bufferHex BYTE 8 DUP('0'), 0    ; Espacio para 8 caracteres hexadecimales y el 0 final

.code
main PROC
    mov eax, 12AB34CDh              ; El número que vamos a convertir
    mov esi, 7                      ; ESI = posición del último carácter del buffer (de 0 a 7)
    mov ecx, 8                      ; Son 8 dígitos hexadecimales, así que repetimos 8 veces

L1:
    mov ebx, eax                    ; Copiamos el número para no perderlo
    and ebx, 0Fh                    ; Nos quedamos solo con los últimos 4 bits (un dígito hexadecimal)

    cmp ebx, 10
    jl EsNumero                     ; Si es menor que 10, es un dígito del 0 al 9
    add ebx, 7                      ; Si es 10 o más, sumamos 7 para llegar a las letras A-F en ASCII

EsNumero:
    add ebx, '0'                    ; Convertimos el valor en su carácter ASCII
    mov bufferHex[esi], bl          ; Lo guardamos en el buffer (de derecha a izquierda)
    shr eax, 4                      ; Movemos el número 4 bits para quedar con el siguiente dígito

    dec esi                         ; Retrocedemos una posición en el buffer
    loop L1                         ; Repite hasta completar los 8 dígitos

    mov edx, OFFSET bufferHex
    call WriteString                ; Muestra el resultado: 12AB34CD
    call Crlf

    call DumpRegs                   ; Muestra los registros
    exit                            ; Termina el programa
main ENDP
END main
