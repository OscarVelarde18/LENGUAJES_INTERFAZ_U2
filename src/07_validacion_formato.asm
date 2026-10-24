; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 7 - Validación de formato
; Descripción: Revisa que el texto escrito tenga el formato AAA-999: 3 letras mayúsculas, un guion y 3 números.

INCLUDE Irvine32.inc               ; Librería con ReadString y WriteString

.data
    prompt      BYTE "Ingrese el codigo (formato AAA-999): ", 0
    msgValido   BYTE "LA CADENA CUMPLE CON LAS REGLAS", 0
    msgNoValido BYTE "NO CUMPLE CON LAS REGLAS", 0
    buffer      BYTE 20 DUP(0)                  ; Espacio donde se guarda lo que escriba el usuario

.code
main PROC
    mov edx, OFFSET prompt
    call WriteString                ; Pide el código

    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer - 1      ; Máximo de caracteres que se pueden leer
    call ReadString                 ; Lee el texto; EAX = cuántos caracteres se escribieron

    cmp eax, 7                      ; Regla 1: debe tener exactamente 7 caracteres
    jne invalido

    mov esi, OFFSET buffer          ; ESI será nuestro "dedo" que recorre el texto letra por letra
    mov ecx, 3                      ; Revisaremos las primeras 3 posiciones (letras)

validarLetras:
    mov al, [esi]                   ; Tomamos el carácter donde está el "dedo"
    cmp al, 'A'
    jb invalido                     ; Si es menor que 'A', no es mayúscula
    cmp al, 'Z'
    ja invalido                     ; Si es mayor que 'Z', tampoco
    inc esi                         ; Avanzamos al siguiente carácter
    loop validarLetras              ; Repite 3 veces

    mov al, [esi]                   ; Regla 3: el cuarto carácter debe ser un guion
    cmp al, '-'
    jne invalido
    inc esi                         ; Pasamos al siguiente carácter

    mov ecx, 3                      ; Ahora revisaremos las últimas 3 posiciones (números)

validarDigitos:
    mov al, [esi]
    cmp al, '0'
    jb invalido                     ; Menor que '0': no es número
    cmp al, '9'
    ja invalido                     ; Mayor que '9': no es número
    inc esi
    loop validarDigitos             ; Repite 3 veces

    mov edx, OFFSET msgValido       ; Si llegó hasta aquí, cumplió todas las reglas
    call WriteString
    jmp fin

invalido:
    mov edx, OFFSET msgNoValido     ; Si falló alguna regla, llegamos aquí
    call WriteString

fin:
    call Crlf
    exit                            ; Termina el programa
main ENDP
END main
