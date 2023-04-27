.686
.model flat
extern _ExitProcess@4 : PROC

.data
pomiary	dd	3,4,5,1,7,8,9

.code
_szukaj_elem_min PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	mov edi, [ebp+8]
	mov esi, [ebp+12]
	cmp esi, 0
	jbe blad
	mov eax, [edi]
	mov ebx, 0
	mov ecx, 0

petla:
	cmp eax, [edi + 4*ecx]
	jbe dalej

	mov eax,[edi + 4*ecx]
	mov ebx, ecx

dalej:
	inc ecx
	cmp ecx, esi
	jb petla

	mov eax, edi
	lea ebx, [4*ebx]
	add eax, ebx

blad:
	
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_szukaj_elem_min ENDP

_main PROC
	push 7
	push offset pomiary
	call _szukaj_elem_min
	add esp, 8

; test
	mov eax, [eax]

	push 0
	call _ExitProcess@4
_main ENDP
END