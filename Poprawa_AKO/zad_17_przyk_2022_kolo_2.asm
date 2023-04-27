.686
.model flat

extern _ExitProcess@4 : PROC

.data
tablica dq 10,9,8,7,6,5,4,3,2,1
xddd db 'ddddd'

.code
_sortuj PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp + 12]
	mov edi, [ebp + 8]
	mov ecx, 0	; obecny poczatek
	push ecx	; pierwszy najmniejszy element

sortuj_dalej:
	mov ebx, ecx
	inc ebx

	znajdz_najmn:
		push ecx
		mov edx, [edi + 8*ebx + 4]
		mov ecx, [esp + 4]	; obecnie najmniejszy 
		mov eax, [edi + 8*ecx + 4]
		cmp edx, eax
		jb mniejszy

		mov edx, [edi + 8*ebx]
		mov eax, [edi + 8*ecx]
		cmp edx, eax
		jb mniejszy
		jmp dalej

	mniejszy:
		mov [esp + 4], ebx	; nowy najmniejszy

	dalej: 
		inc ebx
		pop ecx
		cmp ebx, esi
		jb znajdz_najmn

	mov ebx, [esp]
	
	; zamiana m³odszych czêœci
	mov edx, [edi + 8*ecx]
	mov eax, [edi + 8*ebx]
	mov [edi + 8*ecx], eax
	mov [edi + 8*ebx], edx

	; zamiana starszych czêœci
	mov edx, [edi + 8*ecx + 4]
	mov eax, [edi + 8*ebx + 4]
	mov [edi + 8*ecx + 4], eax
	mov [edi + 8*ebx + 4], edx

	inc ecx
	cmp ecx, esi
	jb sortuj_dalej

	; do zwrotu
	mov edx, [edi + 8*ebx + 4]
	mov eax, [edi + 8*ebx]

	add esp, 4
	pop edi 
	pop esi
	pop ebx
	pop ebp

	ret



_sortuj ENDP

_main PROC
	push 10
	push offset tablica
	call _sortuj
	add esp, 8

	push 0
	call _ExitProcess@4
_main ENDP
END