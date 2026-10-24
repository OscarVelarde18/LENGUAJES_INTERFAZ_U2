; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6 - Control de ocupación de un estacionamiento
; Descripción: Cuenta los autos que entran y salen de un estacionamiento de 20 lugares usando INC y DEC.

INCLUDE Irvine32.inc               ; Librería con ReadInt, WriteDec, etc.

.data
    menu        BYTE "1 = Entra auto | 2 = Sale auto | 0 = Terminar: ", 0
    msgMax      BYTE "Estacionamiento lleno", 0
    msgVacio    BYTE "El estacionamiento ya esta vacio", 0
    msgOpcion   BYTE "Opcion no valida", 0
    msgOcupados BYTE "Lugares ocupados: ", 0

.code
main PROC
    mov ebx, 20                     ; EBX guarda la capacidad máxima: 20 autos
    mov ecx, 0                      ; ECX cuenta los autos que hay ahora (empieza en 0)

ciclo:
    mov edx, OFFSET menu
    call WriteString                ; Muestra el menú
    call ReadInt                    ; Lee la opción; queda en EAX

    cmp eax, 0
    je fin                          ; Opción 0: terminar
    cmp eax, 1
    je entro                        ; Opción 1: entró un auto
    cmp eax, 2
    je salio                        ; Opción 2: salió un auto

    mov edx, OFFSET msgOpcion       ; Si no fue 0, 1 ni 2, la opción es incorrecta
    call WriteString
    call Crlf
    jmp ciclo                       ; Volvemos a mostrar el menú

entro:
    cmp ecx, ebx
    jae maximo                      ; Si ya hay 20 (o más), no cabe otro auto
    inc ecx                         ; Sumamos 1 auto
    jmp mostrar

salio:
    cmp ecx, 0
    je vacio                        ; Si no hay autos, no puede salir ninguno
    dec ecx                         ; Restamos 1 auto
    jmp mostrar

maximo:
    mov edx, OFFSET msgMax
    call WriteString                ; Avisa que está lleno
    call Crlf
    jmp ciclo

vacio:
    mov edx, OFFSET msgVacio
    call WriteString                ; Avisa que está vacío
    call Crlf
    jmp ciclo

mostrar:
    mov edx, OFFSET msgOcupados
    call WriteString
    mov eax, ecx                    ; Pasamos la cantidad de autos a EAX para mostrarla
    call WriteDec
    call Crlf
    jmp ciclo                       ; Regresa al menú

fin:
    exit                            ; Termina el programa
main ENDP
END main
