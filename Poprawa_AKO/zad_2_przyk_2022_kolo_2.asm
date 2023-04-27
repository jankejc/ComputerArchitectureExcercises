.686
.model flat
extern _ExitProcess@4 : PROC
extern _malloc : PROC

.data
tabl dd	1,2,3,4,5,6,7,8,9,10

.code
_kopia_tablicy PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]
	mov ebx, [ebp+12]
	mov eax, ebx
	lea eax, [4*eax]
	
	push eax
	call _malloc
	add esp, 4
	
	; czy malloc zarezerwowa³
	cmp eax, 0
	je koniec
	
	mov edi, eax
	mov ecx, 0
	petla:
		mov eax, [esi+4*ecx]
		bt eax, 0
		jnc dalej
		mov eax, 0
	dalej:
		mov [edi+4*ecx], eax
		inc ecx
		cmp ecx, ebx
		jb petla

	mov eax, edi

koniec:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_kopia_tablicy ENDP

_main PROC
	push 10
	push offset tabl
	call _kopia_tablicy
	add esp, 8

	push 0
	call _ExitProcess@4
_main ENDP
END