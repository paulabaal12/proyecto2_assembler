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

fmt_valor db "%d", 0

;Preguntas dificiles
p1 BYTE 'Cual es el area de un circulo con radio 5 unidades? (en pi )', 0AH,0 ; es 25
p2 BYTE 'Cual es la pendiente de la recta que pasa por los puntos (2, 5) y (4, 3)?', 0AH,0 ;es 2

prespuestas DWORD 10, 15, 20, 25, 1, 2, 3, 4 
opf BYTE '%s).%d', 0AH, 0
;Mensajes de incorrecta y correcta
incorrecta BYTE 'Respuesta incorrecta ingresada',0AH,0
correcta BYTE 'Respuesta correcta',0AH,0
puntos DW 0; puntos acumulados
;Array de opciones para cada pregunta
opi BYTE 'a', 0, 'b', 0, 'c', 0, 'd', 0, 'a', 0, 'b', 0, 'c', 0, 'd', 0
opi2 BYTE 'a', 0, 'b', 0, 'c', 0, 'd', 0
;Array de las preguntas
arrayOfStrings DWORD OFFSET msg1, OFFSET msg2, OFFSET msg3, OFFSET msg4, OFFSET msg5, OFFSET msg6, OFFSET msg7, OFFSET msg8, OFFSET msg9, OFFSET msg10, OFFSET msg11, OFFSET msg12, OFFSET msg13
arraySize DWORD 13
;Array de las respuetas
;arr DWORD 77, 48, 12, 1, 0, 5, 35, 9, 15, 44, 22, 10, 4
;posibles respuestas
arr1 DWORD 77, 70, 71, 65
arr2 DWORD 32, 47, 48, 49
arr3 DWORD 11, 12, 14, 13
arr4 DWORD 1, 2, 3, 7
arr5 DWORD  0, 2, 3, 11
arr6 DWORD  7, 6, 8, 5
arr7 DWORD 32, 35, 33, 30
arr8 DWORD 9, 11, 13, 14
arr9 DWORD 16, 17, 15,18
arr10 DWORD 43, 42, 40,44
arr11 DWORD 21, 22, 23, 25
arr12 DWORD 11, 10,16,13
arr13 DWORD 6, 4, 8, 2
index DWORD 0, 0, 0
formatString BYTE '%s', 0
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
extrn scanf:near
public main
main proc
    call RandomPregunta
    push bx
    ;push cx
    mov [index], esi
    call Respuestas1
    pop bx
    mov dx, bx
    push bx
    mov ebx, 1
    call RandomPregunta
    
    mov [index+4], esi
    call Respuestas2
   ; pop cx
    mov dx, cx
    mov ebx, 2
    call RandomPregunta
    mov [index+8], esi
    call Respuestas3
    call  DificilPregunta1

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
    .if ebx ==1
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
    .if ebx==2
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
ret
RandomPregunta endp
;___________________________________________
;DificilPregunta1
;input: var global opi, p1, p2
;output: var global puntos
;___________________________________________
DificilPregunta1 proc
;Pregunta 1
    mov esi, offset prespuestas ; arreglo de respuestas
	mov ebx, sizeof	prespuestas ; tamaño del arreglo respuestas
	mov edi, offset	opi ;arreglo de los a, b, c, d 
    push offset p1 ;impresión de la pregunta 1
	call printf
label1:
	mov eax, [esi]     
    push eax
    push edi
    push offset opf
    call printf
    add edi, 2
    add esi, 4
    sub ebx, 4
    cmp ebx, 16            
    jne label1
    
    add esp, 4 ; Limpia la pila
    lea eax, [ebp-4] ; Obtiene la dirección de la variable local
    push eax ; Pone la dirección en la pila
    push offset fmt_valor ; Pone la dirección de la cadena de formato en la pila
    call scanf ; Llama a la función scanf para leer el número ingresado
    add esp, 8 ; Limpia la pila
    mov eax, [ebp-4] ; Mueve el número ingresado a eax
    .IF eax == 25 ; verificar si está correcta
        add puntos, 3;
		push offset correcta
		call printf
	.ELSE
		push offset incorrecta
		call printf
	.ENDIF
    add esp, 8 ; Limpia la pila
;Pregunta 2
    mov esi, offset prespuestas ; arreglo de respuestas
	mov ebx, sizeof	prespuestas ; tamaño del arreglo respuestas
	mov edi, offset	opi ;arreglo de los a, b, c, d 
    push offset p2 ;impresión de la pregunta 2
	call printf
label2:
	mov eax, [esi+16]     
    push eax
    push edi
    push offset opf
    call printf
    add edi, 2
    add esi, 4
    sub ebx, 4
    cmp ebx, 16           
    jne label2
    add esp, 4 ; Limpia la pila
    lea eax, [ebp-4] ; Obtiene la dirección de la variable local
    push eax ; Pone la dirección en la pila
    push offset fmt_valor ; Pone la dirección de la cadena de formato en la pila
    call scanf ; Llama a la función scanf para leer el número ingresado
    add esp, 8 ; Limpia la pila
    mov eax, [ebp-4] ; Mueve el número ingresado a eax
    .IF eax == 2 ; verificar si está correcta
        add puntos, 3;
		push offset correcta
		call printf
	.ELSE
		push offset incorrecta
		call printf
	.ENDIF
    add esp, 8 ; Limpia la pila
    ret
DificilPregunta1 endp

;___________________________________________
;Respuestas1
;input: var global opi2, arr
;output: 
;___________________________________________
Respuestas1 proc
;Pregunta 1
mov ebx,[index]
    .if ebx ==0
            mov esi, offset arr1 ; arreglo de respuestas
	        mov ebx, sizeof	arr1 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
.endif
    .if ebx ==1
            mov esi, offset arr2 ; arreglo de respuestas
	        mov ebx, sizeof	arr2 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==2
            mov esi, offset arr3 ; arreglo de respuestas
	        mov ebx, sizeof	arr3 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==3
            mov esi, offset arr4 ; arreglo de respuestas
	        mov ebx, sizeof	arr4 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==4
            mov esi, offset arr5 ; arreglo de respuestas
	        mov ebx, sizeof	arr5 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==5
            mov esi, offset arr4 ; arreglo de respuestas
	        mov ebx, sizeof	arr4 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==6
            mov esi, offset arr7 ; arreglo de respuestas
	        mov ebx, sizeof	arr7 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==7
            mov esi, offset arr8 ; arreglo de respuestas
	        mov ebx, sizeof	arr8 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==8
            mov esi, offset arr9 ; arreglo de respuestas
	        mov ebx, sizeof	arr9 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==9
            mov esi, offset arr10 ; arreglo de respuestas
	        mov ebx, sizeof	arr10 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==10
            mov esi, offset arr11 ; arreglo de respuestas
	        mov ebx, sizeof	arr11 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==11
            mov esi, offset arr12 ; arreglo de respuestas
	        mov ebx, sizeof	arr12 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==12
            mov esi, offset arr13 ; arreglo de respuestas
	        mov ebx, sizeof	arr13 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    label1:
	    mov eax, [esi]     
        push eax
        push edi
        push offset opf
        call printf
        add edi, 2
        add esi, 4
        sub ebx, 4
        cmp ebx, 0  
        jne label1
     
    mov ebx, 1
    add esp, 14*4

ret
Respuestas1 endp
;___________________________________________
;Respuestas2
;input: var global opi2, arr
;output: 
;___________________________________________
Respuestas2 proc
;Pregunta 2
mov ebx,[index+4]
    .if ebx ==0
            mov esi, offset arr1 ; arreglo de respuestas
	        mov ebx, sizeof	arr1 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
.endif
    .if ebx ==1
            mov esi, offset arr2 ; arreglo de respuestas
	        mov ebx, sizeof	arr2 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==2
            mov esi, offset arr3 ; arreglo de respuestas
	        mov ebx, sizeof	arr3 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==3
            mov esi, offset arr4 ; arreglo de respuestas
	        mov ebx, sizeof	arr4 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==4
            mov esi, offset arr5 ; arreglo de respuestas
	        mov ebx, sizeof	arr5 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==5
            mov esi, offset arr4 ; arreglo de respuestas
	        mov ebx, sizeof	arr4 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==6
            mov esi, offset arr7 ; arreglo de respuestas
	        mov ebx, sizeof	arr7 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==7
            mov esi, offset arr8 ; arreglo de respuestas
	        mov ebx, sizeof	arr8 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==8
            mov esi, offset arr9 ; arreglo de respuestas
	        mov ebx, sizeof	arr9 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==9
            mov esi, offset arr10 ; arreglo de respuestas
	        mov ebx, sizeof	arr10 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==10
            mov esi, offset arr11 ; arreglo de respuestas
	        mov ebx, sizeof	arr11 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==11
            mov esi, offset arr12 ; arreglo de respuestas
	        mov ebx, sizeof	arr12 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==12
            mov esi, offset arr13 ; arreglo de respuestas
	        mov ebx, sizeof	arr13 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    label1:
	    mov eax, [esi]     
        push eax
        push edi
        push offset opf
        call printf
        add edi, 2
        add esi, 4
        sub ebx, 4
        cmp ebx, 0  
        jne label1
     
    mov ebx, 2
    add esp, 14*4

ret
Respuestas2 endp
;___________________________________________
;Respuestas3
;input: var global opi2, arr
;output: 
;___________________________________________
Respuestas3 proc
;Pregunta 3
mov ebx,[index+8]
    .if ebx ==0
            mov esi, offset arr1 ; arreglo de respuestas
	        mov ebx, sizeof	arr1 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
.endif
    .if ebx ==1
            mov esi, offset arr2 ; arreglo de respuestas
	        mov ebx, sizeof	arr2 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==2
            mov esi, offset arr3 ; arreglo de respuestas
	        mov ebx, sizeof	arr3 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==3
            mov esi, offset arr4 ; arreglo de respuestas
	        mov ebx, sizeof	arr4 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==4
            mov esi, offset arr5 ; arreglo de respuestas
	        mov ebx, sizeof	arr5 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==5
            mov esi, offset arr4 ; arreglo de respuestas
	        mov ebx, sizeof	arr4 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==6
            mov esi, offset arr7 ; arreglo de respuestas
	        mov ebx, sizeof	arr7 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==7
            mov esi, offset arr8 ; arreglo de respuestas
	        mov ebx, sizeof	arr8 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==8
            mov esi, offset arr9 ; arreglo de respuestas
	        mov ebx, sizeof	arr9 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==9
            mov esi, offset arr10 ; arreglo de respuestas
	        mov ebx, sizeof	arr10 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==10
            mov esi, offset arr11 ; arreglo de respuestas
	        mov ebx, sizeof	arr11 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==11
            mov esi, offset arr12 ; arreglo de respuestas
	        mov ebx, sizeof	arr12 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    .if ebx ==12
            mov esi, offset arr13 ; arreglo de respuestas
	        mov ebx, sizeof	arr13 ; tamaño del arreglo respuestas
	        mov edi, offset	opi2 ;arreglo de los a, b, c, d 
            push eax  
            push OFFSET formatString  
            call printf  ; Imprime la pregunta
    .endif
    label1:
	    mov eax, [esi]     
        push eax
        push edi
        push offset opf
        call printf
        add edi, 2
        add esi, 4
        sub ebx, 4
        cmp ebx, 0  
        jne label1
     
    
    add esp, 14*4

ret
Respuestas3 endp
end 