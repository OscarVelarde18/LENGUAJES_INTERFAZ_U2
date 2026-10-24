; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Hola mundo en Visual Studio 2022 con Irvine32
; Descripción: Muestra el mensaje "Hola mundo" para comprobar que todo está bien configurado.

INCLUDE Irvine32.inc               ; Trae las funciones de la librería Irvine32 (WriteString, Crlf, etc.)

.data
    msg BYTE "Hola mundo", 0        ; El mensaje. El 0 del final marca dónde termina el texto

.code
main PROC
    mov edx, OFFSET msg             ; Guardamos en EDX la dirección donde empieza el mensaje
    call WriteString                ; Escribe en pantalla el texto al que apunta EDX
    call Crlf                       ; Baja el cursor a la línea siguiente
    exit                            ; Termina el programa
main ENDP
END main
