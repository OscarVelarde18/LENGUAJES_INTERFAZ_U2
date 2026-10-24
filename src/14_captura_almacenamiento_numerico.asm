; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 14 - Captura y almacenamiento de datos numéricos
; Descripción: Pide la cantidad recibida en un almacén (de 1 a 99), la valida y la suma a la existencia inicial de 25.

INCLUDE Irvine32.inc               ; Librería Irvine32

.data
    promptMsg         BYTE "Ingrese la cantidad recibida (1-99): ", 0
    errorMsg          BYTE "Error de entrada. Intente nuevamente.", 0
    msgExistencia     BYTE "Existencia actual: ", 0

    buffer            BYTE 10 DUP(0)    ; Aquí se guarda el texto que escribe el usuario
    cantidadRecibida  DWORD ?           ; Aquí se guarda la cantidad ya convertida a número
    existenciaInicial DWORD 25          ; Productos que ya había en el almacén
    existenciaActual  DWORD ?           ; Resultado de la suma
    outBuffer         BYTE 10 DUP(0)    ; Aquí se arma el resultado en texto para mostrarlo

.code
main PROC
PedirDatos:
    mov edx, OFFSET promptMsg
    call WriteString                ; Pide la cantidad

    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer - 1      ; Máximo de caracteres a leer (dejamos lugar al 0 final)
    call ReadString                 ; Lee el texto; EAX = cuántos caracteres se escribieron

    cmp eax, 0                      ; Si no escribió nada, es error
    je ErrorEntrada
    cmp eax, 2                      ; Si escribió más de 2 caracteres, es error
    ja ErrorEntrada

    mov esi, OFFSET buffer          ; ESI recorre el texto carácter por carácter
    mov ecx, eax                    ; Repetiremos una vez por cada carácter escrito
ValidarCaracteres:
    mov al, [esi]
    cmp al, '0'
    jb ErrorEntrada                 ; Menor que '0': no es número
    cmp al, '9'
    ja ErrorEntrada                 ; Mayor que '9': no es número
    inc esi
    loop ValidarCaracteres

    ; Convertir el texto a número: resultado = resultado * 10 + dígito
    mov esi, OFFSET buffer
    mov eax, 0                      ; EAX acumula el número; empieza en 0
    mov ebx, 10                     ; Multiplicaremos por 10 en cada vuelta
    mov ecx, 2                      ; Máximo 2 dígitos
ConvertLoop:
    movzx edi, BYTE PTR [esi]       ; El dígito va en EDI porque MUL cambia el valor de EDX
    cmp edi, 0
    je FinConversion                ; Si llegamos al 0 final, ya terminamos
    sub edi, '0'                    ; Convertimos el carácter en su valor (ejemplo: '7' pasa a 7)
    mul ebx                         ; EAX = EAX * 10
    add eax, edi                    ; Le sumamos el dígito
    inc esi                         ; Siguiente carácter
    loop ConvertLoop

FinConversion:
    cmp eax, 1
    jb ErrorEntrada                 ; El número debe estar entre 1 y 99
    cmp eax, 99
    ja ErrorEntrada

    mov cantidadRecibida, eax       ; Guardamos la cantidad recibida
    mov ebx, existenciaInicial
    add eax, ebx                    ; Nueva existencia = existencia inicial + cantidad recibida
    mov existenciaActual, eax

    mov edx, OFFSET msgExistencia
    call WriteString

    mov eax, existenciaActual
    mov edi, OFFSET outBuffer
    call ConvDwordToString          ; Convierte el número a texto para mostrarlo

    mov edx, OFFSET outBuffer
    call WriteString
    call Crlf
    jmp FinProg

ErrorEntrada:
    call Crlf
    mov edx, OFFSET errorMsg
    call WriteString                ; Avisa que hubo un error
    call Crlf
    jmp PedirDatos                  ; Vuelve a pedir el dato

FinProg:
    exit                            ; Termina el programa
main ENDP

; ------------------------------------------------------------
; ConvDwordToString
; Recibe: EAX = número, EDI = buffer donde se escribe el texto
; Divide entre 10 y guarda cada dígito en la pila. Como la pila
; entrega al revés, los dígitos salen en el orden correcto.
; ------------------------------------------------------------
ConvDwordToString PROC
    pushad                          ; Guarda todos los registros
    mov ecx, 0                      ; ECX cuenta cuántos dígitos hay
    mov ebx, 10                     ; Divisor
DivLoop:
    mov edx, 0
    div ebx                         ; EAX = cociente, EDX = residuo (un dígito)
    add dl, '0'                     ; Lo convertimos en carácter
    push edx                        ; Lo guardamos en la pila
    inc ecx
    cmp eax, 0
    jne DivLoop                     ; Sigue hasta que el cociente sea 0
PopLoop:
    pop edx                         ; Sacamos los dígitos (ya en el orden correcto)
    mov [edi], dl                   ; Los escribimos en el buffer
    inc edi
    loop PopLoop
    mov BYTE PTR [edi], 0           ; Marca el fin del texto
    popad                           ; Devuelve todos los registros
    ret
ConvDwordToString ENDP
END main
