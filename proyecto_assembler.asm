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
msg1 BYTE ' Cuanto es | -77 | ?',0Ah,0
msg2 BYTE ' 16 + 32 es igual a?',0Ah,0
msg3 BYTE 'raiz cuadrada de 144',0Ah,0
msg4 BYTE ' Cuanto es e a la 0?', 0AH,0
msg5 BYTE ' Cuanto es cos(90°)?', 0AH,0
msg6 BYTE 'La derivada de 5x es', 0AH,0
msg7 BYTE '( 5 + 2) * 10 / 2 es', 0AH,0
msg8 BYTE '  Cuanto es 56 / 7 ?', 0AH,0
msg9 BYTE 'si (x*2)/3 = 10, x es', 0AH,0
msg10 BYTE '6x8 menos cuatro es:', 0AH,0
msg11 BYTE '1/3 de 66 es igual a', 0AH,0
msg12 BYTE 'si 10+x = 15, 2x es:', 0AH,0
msg13 BYTE 'x+y=1 y 3x+2y=6, x =', 0AH,0
;Array de las preguntas
arrayOfStrings DWORD OFFSET msg1, OFFSET msg2, OFFSET msg3, OFFSET msg4, OFFSET msg5, OFFSET msg6, OFFSET msg7, OFFSET msg8, OFFSET msg9, OFFSET msg10, OFFSET msg11, OFFSET msg12, OFFSET msg13
arraySize DWORD 13
;Array de las respuetas
arr DWORD 77, 48, 12, 1, 0, 5, 35, 9, 15, 44, 22, 10, 4
formatString BYTE '%s', 0
index DWORD 0, 0, 0
comp1 DWORD 0
comp2 DWORD 0
comp DWORD 0

.code
includelib libucrt.lib
includelib legacy_stdio_definitions.lib
includelib libcmt.lib
includelib libvcruntime.lib

extrn printf:near
extrn exit:near

public main
main proc
    call RandomPregunta
    mov dx, bx
    add ebx,1
    mov [index], esi
    mov comp1, ebx
    call RandomPregunta
    mov dx, cx
    mov [index+4], esi
    add ebx,1
    mov comp2, ebx
    call RandomPregunta
    ; Exit the program
    push 0
    call exit

main endp
; ------------ SUBRUTINAS -------------
;___________________________________________
;RandomPregunta
;input: var global arrayOfStrings dword
;output: NO utiliza
;___________________________________________
RandomPregunta proc

    ; Genera el random index
    mov ax, dx
    xor dx, dx
    mov cx, 13
    div cx  
    ; Calcula el index para la pregunta
    movzx esi, dx  
    .if ebx ==comp1
        lCheckIndex:
            cmp esi, [index]
            je lGenerateNewIndex    
            jne lexit
        lGenerateNewIndex:
            ; Generate a new random index
            mov ax, dx
            xor dx, dx
            mov cx, 13
            div cx
            movzx esi, dx
            jmp lCheckIndex
        lexit:
    .endif
    .if ebx==comp2
        lCheckIndex2:
            cmp esi, [index]
            je lGenerateNewIndex2
            cmp esi, [index + 4]
            je lGenerateNewIndex2    
            jne lexit2
        lGenerateNewIndex2:
            ; Generate a new random index
            mov ax, dx
            xor dx, dx
            mov cx, 13
            div cx
            movzx esi, dx
            jmp lCheckIndex2
        lexit2:
    .endif

mov eax, [arrayOfStrings + esi*4]
push eax  
push OFFSET formatString  
call printf  ; Imprime la pregunta
; Check if the generated index is already in the index array
add esp, 8  ; Limpia el stack
ret
RandomPregunta endp
end 