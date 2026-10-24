; Materia: Lenguajes de Interfaz
; Alumno: Oscar Mario Velarde Barraza
; Horario: 10:00 - 11:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 15 - Manipulación de archivo
; Descripción: Crea un archivo de texto, escribe en él, lo cierra, lo abre otra vez, lo lee y muestra lo que contiene.

INCLUDE Irvine32.inc               ; Librería con las funciones para manejar archivos

BUFFER_SIZE = 100                   ; Constante: tamaño del espacio para leer el archivo

.data
    nombreArchivo BYTE "practica15.txt", 0      ; Nombre del archivo que se va a crear
    texto         BYTE "Practica 15: manipulacion de archivos en ensamblador.", 0Dh, 0Ah
    LONG_TEXTO = ($ - texto)        ; El ensamblador calcula cuántos bytes mide el texto
    buffer        BYTE BUFFER_SIZE DUP(0)       ; Espacio donde se guarda lo que se lea
    manejador     DWORD ?           ; Número que identifica al archivo abierto

    msgEscrito BYTE "Archivo creado y escrito correctamente.", 0
    msgLeido   BYTE "Contenido leido del archivo:", 0
    msgError   BYTE "Error al manejar el archivo.", 0

.code
main PROC
    ; --- Crear el archivo ---
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile           ; Crea el archivo; EAX = su número de identificación
    cmp eax, INVALID_HANDLE_VALUE   ; Si EAX tiene este valor especial, algo falló
    je error
    mov manejador, eax              ; Guardamos el número de identificación

    ; --- Escribir en el archivo ---
    mov eax, manejador              ; EAX = qué archivo
    mov edx, OFFSET texto           ; EDX = qué se va a escribir
    mov ecx, LONG_TEXTO             ; ECX = cuántos bytes escribir
    call WriteToFile

    ; --- Cerrar el archivo ---
    mov eax, manejador
    call CloseFile                  ; Cerramos para que se guarde bien

    mov edx, OFFSET msgEscrito
    call WriteString
    call Crlf

    ; --- Abrir el archivo para leerlo ---
    mov edx, OFFSET nombreArchivo
    call OpenInputFile              ; Abre el archivo para lectura
    cmp eax, INVALID_HANDLE_VALUE
    je error
    mov manejador, eax

    ; --- Leer el archivo ---
    mov edx, OFFSET buffer          ; EDX = dónde se guardará lo leído
    mov ecx, BUFFER_SIZE - 1        ; ECX = máximo de bytes a leer
    call ReadFromFile               ; EAX = bytes leídos; si hubo error, CF = 1
    jc error
    mov buffer[eax], 0              ; Ponemos el 0 final después del último byte leído

    mov eax, manejador
    call CloseFile                  ; Cerramos el archivo

    ; --- Mostrar lo leído ---
    mov edx, OFFSET msgLeido
    call WriteString
    call Crlf
    mov edx, OFFSET buffer
    call WriteString                ; Muestra el contenido del archivo
    jmp fin

error:
    mov edx, OFFSET msgError
    call WriteString                ; Avisa que algo salió mal
    call Crlf

fin:
    exit                            ; Termina el programa
main ENDP
END main
