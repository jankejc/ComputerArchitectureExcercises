.686
.model flat
extern _ExitProcess@4 : PROC
extern _SearchPathW@24 : PROC

.data
MAX_PATH EQU 255
filename dw 'a','a','d','t','b','.','d','l','l'
lpFilePart dd '.'
lpBuffer dw 255 dup (?)

.code
_check_file PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	mov ebx,[ebp+8]
	mov eax, MAX_PATH ; nie bylo
	shl eax,1 ; nie bylo
	sub esp,eax ; nie bylo
	mov esi,esp ; lpBuffer
	sub esp,4
	mov edi,esp ; lpFilePart
	
	push edi
	push esi
	push MAX_PATH ; bylo eax
	push 0
	push ebx
	push 0
	call _SearchPathW@24 ; powinno byæ z podkreœleniem

; wystarczy³oby tu zwróciæ ju¿ ...............
	cmp eax,0
	je koniec
	mov ecx,0

	petla:
		mov dx,[esi+2*ecx]
		cmp dx,0
		je dalej
		inc ecx
		jmp petla
dalej:
	inc ecx
	mov eax,ecx
	add esp,4
	mov ecx,MAX_PATH
	shl ecx,1 ; nie bylo
	add esp,ecx

koniec:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_check_file ENDP



_main PROC
	push offset filename
	call _check_file
	add esp,4
	nop


	push 0
	call _ExitProcess@4
_main ENDP
END