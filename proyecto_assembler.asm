; -----------------------------------------------
; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organización de computadoras y Assembler
; Ciclo 1 - 2023
; Nombre: proyecto_assembler.asm
; Descripción: 
; Autor: 
; ----------------------------------------------- 

.386
.model flat, stdcall, c
.stack 4096
;ExitProcess proto,dwExitCode:dword

.data
msg0 BYTE 'Bienvenidos!, 0Ah, 0
preg1 BYTE '¿Cuánto es | -77 | ?', 0Ah, 0
preg2 BYTE '¿16 + 32 es igual a?', 0Ah, 0
preg3 BYTE 'raíz cuadrada de 144', 0Ah, 0
preg4 BYTE '¿Cuánto es e a la 0?', 0Ah, 0
preg5 BYTE '¿Cuanto es cos(90º)?', 0Ah, 0
preg6 BYTE 'La derivada de 5x es', 0Ah, 0
preg7 BYTE '( 5 + 2) * 10 / 2 es', 0Ah, 0
preg8 BYTE '¿ Cuánto es 56 / 7 ?', 0Ah, 0
preg9 BYTE 'si (x*2)/3 = 10, x es', 0Ah, 0
preg10 BYTE '6x8 menos cuatro es:', 0Ah, 0
preg11 BYTE '1/3 de 66 es igual a', 0Ah, 0
preg12 BYTE 'si 10+x = 15, 2x es:', 0Ah, 0
preg13 BYTE 'x+y=1 y 3x+2y=6, x =', 0Ah, 0
arr1 DD 77,48,12,1,0,5,35,9,15,44,22,10,4

.code
includelib libucrt.lib
includelib legacy_stdio_definitions.lib
includelib libcmt.lib
includelib libvcruntime.lib

extrn printf:near
extrn exit:near

public main
main proc
	

main endp
end 


