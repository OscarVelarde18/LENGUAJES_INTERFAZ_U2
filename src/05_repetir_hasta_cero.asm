; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5 - Repetir hasta que el usuario ingrese cero
; Descripción: Pide números una y otra vez hasta que el usuario escribe 0.

INCLUDE Irvine32.inc               ; Librería con ReadInt, WriteInt, etc.

.data
    prompt BYTE "Ingrese un numero (0 para terminar): ", 0
    msgNum BYTE "Usted ingreso: ", 0
    msgFin BYTE "Se ingreso 0. Fin del programa.", 0

.code
main PROC

ciclo:                              ; Aquí empieza cada vuelta
    mov edx, OFFSET prompt
    call WriteString                ; Pide un número
    call ReadInt                    ; Lo lee; queda en EAX

    cmp eax, 0                      ; ¿Es cero?
    je fin                          ; Si es cero, salimos del ciclo

    mov edx, OFFSET msgNum
    call WriteString                ; Muestra "Usted ingreso: "
    call WriteInt                   ; Muestra el número (con su signo)
    call Crlf

    jmp ciclo                       ; Regresa al inicio para pedir otro número

fin:
    mov edx, OFFSET msgFin
    call WriteString                ; Mensaje de despedida
    call Crlf
    exit                            ; Termina el programa
main ENDP
END main
