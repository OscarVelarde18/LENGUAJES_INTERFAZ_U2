; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4 - Mayor, menor o igual con entrada del usuario
; Descripción: Pide dos números y dice si el primero es mayor, menor o igual al segundo.

INCLUDE Irvine32.inc               ; Librería con ReadInt, WriteString, etc.

.data
    prompt1    BYTE "Ingrese el primer numero: ", 0
    prompt2    BYTE "Ingrese el segundo numero: ", 0
    msgIguales BYTE "Los numeros son iguales", 0
    msgMayor   BYTE "El primer numero es MAYOR", 0
    msgMenor   BYTE "El primer numero es MENOR", 0

.code
main PROC
    mov edx, OFFSET prompt1
    call WriteString                ; Pide el primer número
    call ReadInt                    ; Lee un número entero; el resultado queda en EAX
    mov ecx, eax                    ; Guardamos el primero en ECX para no perderlo

    mov edx, OFFSET prompt2
    call WriteString                ; Pide el segundo número
    call ReadInt
    mov ebx, eax                    ; Guardamos el segundo en EBX

    cmp ecx, ebx                    ; Compara el primero contra el segundo
    je iguales                      ; Si son iguales, salta a "iguales"
    jg mayor                        ; Si el primero es mayor, salta a "mayor"

menor:                              ; Si no fue igual ni mayor, entonces es menor
    mov edx, OFFSET msgMenor
    call WriteString
    jmp fin                         ; Salta al final para no seguir con los otros mensajes

mayor:
    mov edx, OFFSET msgMayor
    call WriteString
    jmp fin

iguales:
    mov edx, OFFSET msgIguales
    call WriteString

fin:
    call Crlf
    exit                            ; Termina el programa
main ENDP
END main
