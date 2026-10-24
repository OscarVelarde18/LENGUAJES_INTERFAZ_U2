; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 10 - Obtención de una cadena decimal
; Descripción: Convierte números a texto dividiendo entre 10 y sumando el código ASCII, sin usar WriteDec.

INCLUDE Irvine32.inc               ; Librería Irvine32

.data
    ; Datos del problema: descarga de un archivo
    tamArchivo DWORD 100000         ; Tamaño total del archivo en bytes
    bloques    DWORD 125            ; Bloques que ya se descargaron
    tamBloque  DWORD 512            ; Tamaño de cada bloque en bytes

    ; Aquí guardaremos los resultados
    descargados DWORD ?
    pendientes  DWORD ?
    porcentaje  DWORD ?
    grupos      DWORD ?
    residuo     DWORD ?

    ; Mensajes
    msg1 BYTE "Bytes descargados: ", 0
    msg2 BYTE "Bytes pendientes: ", 0
    msg3 BYTE "Porcentaje de avance: ", 0
    msg4 BYTE "Grupos completos de 1024: ", 0
    msg5 BYTE "Residuo del agrupamiento: ", 0

    buffer BYTE 11 DUP(0)           ; Aquí se arma el texto (hasta 10 dígitos + el 0 final)

.code

; ------------------------------------------------------------
; convertirDecimal
; Recibe: EAX = el número, ESI = dirección del buffer
; Devuelve: el buffer con el número escrito como texto
; Idea: dividir entre 10 una y otra vez; cada residuo es un dígito.
; Los dígitos salen al revés, por eso se escriben de derecha a izquierda.
; ------------------------------------------------------------
convertirDecimal PROC
    push eax                        ; Guardamos los registros para no dañar el programa principal
    push ebx
    push ecx
    push edx
    push edi

    mov edi, esi
    add edi, 10                     ; EDI apunta al final del buffer
    mov BYTE PTR [edi], 00h         ; Ponemos el 0 que marca el fin del texto

    mov ebx, 10                     ; Vamos a dividir entre 10

    cmp eax, 0
    jne convertir                   ; Si el número no es 0, seguimos normal
    dec edi                         ; Caso especial: el número es 0
    mov BYTE PTR [edi], '0'         ; Escribimos el carácter '0' directamente
    jmp terminado

convertir:
    xor edx, edx                    ; Ponemos EDX en 0 antes de dividir
    div ebx                         ; EAX = cociente, EDX = residuo (el último dígito)
    add dl, '0'                     ; Convertimos el dígito en su carácter ASCII
    dec edi                         ; Retrocedemos una posición
    mov [edi], dl                   ; Escribimos el dígito
    cmp eax, 0
    jne convertir                   ; Mientras el cociente no sea 0, seguimos dividiendo

terminado:
    mov esi, edi                    ; ESI apunta al primer dígito del texto
    mov ecx, 0

contar:                             ; Contamos cuántos caracteres tiene el texto
    cmp BYTE PTR [esi+ecx], 0
    je copiarInicio
    inc ecx
    jmp contar

copiarInicio:
    mov edi, OFFSET buffer          ; El destino es el inicio del buffer
    inc ecx                         ; Contamos también el 0 final
    cld                             ; Copiar hacia adelante
    rep movsb                       ; Copia el texto al inicio del buffer

    pop edi                         ; Devolvemos los registros en orden inverso
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
convertirDecimal ENDP

main PROC
    ; 1. Bytes descargados = bloques * tamaño de cada bloque
    mov eax, bloques
    mul tamBloque
    mov descargados, eax

    ; 2. Bytes pendientes = total - descargados
    mov eax, tamArchivo
    sub eax, descargados
    mov pendientes, eax

    ; 3. Porcentaje = descargados * 100 / total
    mov eax, descargados
    mov ebx, 100
    mul ebx
    mov ebx, tamArchivo
    div ebx
    mov porcentaje, eax

    ; 4. Cuántos grupos de 1024 caben y cuánto sobra
    mov eax, descargados
    xor edx, edx
    mov ebx, 1024
    div ebx
    mov grupos, eax                 ; Cociente = grupos completos
    mov residuo, edx                ; Residuo = lo que sobra

    ; Mostrar los resultados (cada uno se convierte a texto primero)
    mov edx, OFFSET msg1
    call WriteString
    mov eax, descargados
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov edx, OFFSET msg2
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov edx, OFFSET msg3
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov edx, OFFSET msg4
    call WriteString
    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov edx, OFFSET msg5
    call WriteString
    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit                            ; Termina el programa
main ENDP
END main
