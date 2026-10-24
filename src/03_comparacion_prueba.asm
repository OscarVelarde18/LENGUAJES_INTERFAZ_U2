; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 3 - Comparación y prueba
; Descripción: Compara números con CMP y revisa bits con TEST para saber si un número es par o impar.

INCLUDE Irvine32.inc               ; Librería para mostrar texto y registros

.data
    msgPar   BYTE "El numero es par", 0
    msgImpar BYTE "El numero es impar", 0

.code
main PROC
    ; --- CMP: compara dos valores y cambia las banderas (flags) ---
    mov eax, 7
    mov ebx, 7
    cmp eax, ebx                    ; Son iguales, así que la bandera ZF queda en 1
    call DumpRegs                   ; Muestra los registros y las banderas para verlo

    mov eax, 5
    mov ebx, 9
    cmp eax, ebx                    ; 5 es menor que 9, así que CF y SF quedan en 1
    call DumpRegs

    ; --- TEST: revisa bits sin cambiar el número ---
    mov eax, 13                     ; 13 en binario es 1101; su último bit vale 1
    test eax, 1                     ; Pregunta: ¿el último bit es 1? Si es 0, ZF = 1
    jz esPar                        ; Si ZF = 1 el número es par y salta
    mov edx, OFFSET msgImpar        ; Si no saltó, es impar
    call WriteString
    jmp fin                         ; Salta al final para no mostrar también el mensaje de par

esPar:
    mov edx, OFFSET msgPar
    call WriteString

fin:
    call Crlf
    exit                            ; Termina el programa
main ENDP
END main
