; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 1 - Ciclos numéricos
; Descripción: Repite un bloque 5 veces usando LOOP y muestra el contador.

INCLUDE Irvine32.inc               ; Librería con las funciones para mostrar datos

.data

.code
main PROC
    mov ecx, 5                      ; ECX cuenta las vueltas; empezamos en 5

ciclo:                              ; Etiqueta: aquí regresa el programa en cada vuelta
    mov eax, ecx                    ; Copiamos el contador a EAX para poder mostrarlo
    call WriteDec                   ; Muestra en pantalla el número que hay en EAX
    call Crlf                       ; Salto de línea

    loop ciclo                      ; Resta 1 a ECX y, si no llegó a 0, regresa a "ciclo"

    exit                            ; Termina el programa
main ENDP
END main
