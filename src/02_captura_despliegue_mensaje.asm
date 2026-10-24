; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 2 - Captura y despliegue de mensaje
; Descripción: Pide un nombre por teclado y lo muestra con un saludo.

INCLUDE Irvine32.inc               ; Librería con ReadString, WriteString, etc.

.data
    prompt BYTE "Escribe tu nombre: ", 0    ; Mensaje que le pide el dato al usuario
    saludo BYTE "Hola, ", 0                 ; Texto del saludo
    buffer BYTE 31 DUP(0)                   ; Espacio vacío para guardar lo que escriba (30 letras + el 0 final)

.code
main PROC
    mov edx, OFFSET prompt          ; EDX apunta al mensaje de petición
    call WriteString                ; Lo muestra en pantalla

    mov edx, OFFSET buffer          ; EDX apunta al lugar donde se guardará lo que se escriba
    mov ecx, SIZEOF buffer - 1      ; ECX = máximo de letras permitidas (dejamos un lugar para el 0)
    call ReadString                 ; Lee el teclado; EAX queda con la cantidad de letras escritas

    mov edx, OFFSET saludo
    call WriteString                ; Muestra "Hola, "
    mov edx, OFFSET buffer
    call WriteString                ; Muestra el nombre que se escribió
    call Crlf                       ; Salto de línea
    exit                            ; Termina el programa
main ENDP
END main
