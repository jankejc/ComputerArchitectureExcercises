.686
.model flat
extern _ExitProcess@4 : PROC

.data
liczba_float	dd 2.0
liczba_double	dq 1.0

.code
_main PROC
	push esi
	push edi
	mov esi, offset liczba_float
	mov edi, offset liczba_double

; w³aœciwy program
	push ebx

	mov ebx, [esi]
	mov eax, ebx
	shl ebx, 1
	shr ebx, 24		; mamy tylko wyk³adnik
	add ebx, 896	; 1023 - 127
	; gotowy wyk³adnik
	
	bt eax, 31
	jnc zero_1
	bts ebx, 11
	; ustawienie bitu znaku
zero_1:
	; gotowy znak + wyk³adnik

	shl eax, 9
	; gotowa mantysa do oddawania

	mov ecx, 0
	petla:
		shl ebx, 1
		shl eax, 1
		jnc zero_2
		bts ebx, 0
	zero_2:
		inc ecx
		cmp ecx, 20
		jb petla
	; gotowe obie czêœci liczby w formacie double

	mov [edi], eax
	mov [edi + 4], ebx

	pop ebx
; koniec w³aœciwego programu

; sprawdzenie
	finit 
	fld qword ptr [edi]
	fld dword ptr [esi]

	pop esi
	pop edi

	push 0
	call _ExitProcess@4
_main ENDP
END