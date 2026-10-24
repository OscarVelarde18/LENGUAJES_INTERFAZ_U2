# Lenguajes de Interfaz — Unidad 2

## Datos generales

| | |
|---|---|
| **Materia** | Lenguajes de Interfaz |
| **Unidad** | Unidad 2 |
| **Alumno** | Oscar Mario Velarde Barraza |
| **Horario** | 10:00 - 11:00 |
| **Docente** | Dr. José Luis Medina Jiménez |

## Índice de prácticas

| No. | Práctica | Descripción |
|---|---|---|
| 0 | [Hola mundo](src/00_hola_mundo.asm) | Muestra el mensaje "Hola mundo" para comprobar que todo está bien configurado. |
| 1 | [Ciclos numéricos](src/01_ciclos_numericos.asm) | Repite un bloque 5 veces usando LOOP y muestra el contador. |
| 2 | [Captura y despliegue de mensaje](src/02_captura_despliegue_mensaje.asm) | Pide un nombre por teclado y lo muestra con un saludo. |
| 3 | [Comparación y prueba](src/03_comparacion_prueba.asm) | Compara números con CMP y revisa bits con TEST para saber si un número es par o impar. |
| 4 | [Mayor, menor o igual con entrada del usuario](src/04_mayor_menor_igual.asm) | Pide dos números y dice si el primero es mayor, menor o igual al segundo. |
| 5 | [Repetir hasta que el usuario ingrese cero](src/05_repetir_hasta_cero.asm) | Pide números una y otra vez hasta que el usuario escribe 0. |
| 6 | [Control de ocupación de un estacionamiento](src/06_control_estacionamiento.asm) | Cuenta los autos que entran y salen de un estacionamiento de 20 lugares usando INC y DEC. |
| 7 | [Validación de formato](src/07_validacion_formato.asm) | Revisa que el texto escrito tenga el formato AAA-999: 3 letras mayúsculas, un guion y 3 números. |
| 8 | [Operaciones aritméticas](src/08_operaciones_aritmeticas.asm) | Practica suma, resta, multiplicación y división, y muestra cómo cambian las banderas CF y OF. |
| 9 | [PUSH y POP](src/09_push_pop.asm) | Muestra cómo funciona la pila: guardar y sacar valores con PUSH y POP, y cómo la usan CALL y RET. |
| 10 | [Obtención de una cadena decimal](src/10_cadena_decimal.asm) | Convierte números a texto dividiendo entre 10 y sumando el código ASCII, sin usar WriteDec. |
| 11 | [Operaciones lógicas](src/11_operaciones_logicas.asm) | Usa AND, OR, XOR, NOT y TEST para consultar y cambiar bits de un byte de estado. |
| 12 | [Desplazamiento y rotación](src/12_desplazamiento_rotacion.asm) | Mueve los bits de un número a la izquierda o derecha con SHL, SHR, SAR y las rotaciones ROL, ROR, RCL y RCR. |
| 13 | [Obtención de una cadena hexadecimal](src/13_cadena_hexadecimal.asm) | Convierte un número a texto hexadecimal (8 caracteres) separando sus bits de 4 en 4. |
| 14 | [Captura y almacenamiento de datos numéricos](src/14_captura_almacenamiento_numerico.asm) | Pide la cantidad recibida en un almacén (de 1 a 99), la valida y la suma a la existencia inicial de 25. |
| 15 | [Manipulación de archivo](src/15_manipulacion_archivo.asm) | Crea un archivo de texto, escribe en él, lo cierra, lo abre otra vez, lo lee y muestra lo que contiene. |

## Cómo ejecutar

1. Abrir Visual Studio 2022 con un proyecto MASM configurado con la librería **Irvine32**.
2. Agregar el archivo `.asm` de la práctica deseada al proyecto (solo uno a la vez como punto de entrada).
3. Compilar y ejecutar (`Ctrl + F5`).

## Estructura

```
.
├── README.md
└── src/
    ├── 00_hola_mundo.asm
    ├── 01_ciclos_numericos.asm
    └── ...
```
