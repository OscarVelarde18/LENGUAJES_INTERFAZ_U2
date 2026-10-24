; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 9 - PUSH y POP
; Descripción: Muestra cómo funciona la pila: guardar y sacar valores con PUSH y POP, y cómo la usan CALL y RET.

INCLUDE Irvine32.inc               ; Librería Irvine32

.data

.code
main PROC
    ; BLOQUE 1: guardar un valor y recuperarlo
    mov eax, 500
    push eax                        ; Guarda el 500 en la pila
    nop
    mov ebx, 0
    pop ebx                         ; Saca el valor de la pila y lo pone en EBX (ahora vale 500)
    nop

    ; BLOQUE 2: la pila saca primero lo último que entró (LIFO)
    mov eax, 10
    push eax                        ; Entra 10
    mov eax, 20
    push eax                        ; Entra 20
    mov eax, 30
    push eax                        ; Entra 30
    nop
    pop eax                         ; Sale 30 (el último que entró)
    pop ebx                         ; Sale 20
    pop ecx                         ; Sale 10
    nop

    ; BLOQUE 3: guardar registros para usarlos y luego devolverlos
    mov eax, 100
    mov ebx, 200
    push eax                        ; Guardamos los valores originales
    push ebx
    mov eax, 999                    ; Ahora podemos usar los registros para otra cosa
    mov ebx, 888
    pop ebx                         ; Los recuperamos en orden inverso
    pop eax                         ; Otra vez EAX = 100 y EBX = 200
    nop

    ; BLOQUE 4: CALL y RET también usan la pila
    mov eax, 50
    mov ebx, 666
    call aumentarDiez               ; CALL guarda en la pila el lugar al que debe regresar
    nop                             ; Al volver, EAX = 60 y EBX sigue valiendo 666

    exit                            ; Termina el programa
main ENDP

aumentarDiez PROC
    push ebx                        ; Guardamos EBX para no perder su valor
    mov ebx, 10
    add eax, ebx                    ; Le sumamos 10 a EAX
    pop ebx                         ; Devolvemos EBX a su valor original
    ret                             ; Regresa al lugar donde se llamó el procedimiento
aumentarDiez ENDP
END main
