.686
.model flat
extern _ExitProcess@4 : PROC
extern _malloc : PROC

.data
probabilities dd 0.5, 0.0, 0.5 
number dd 3

.code
_entropy PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi
	
	finit
	mov esi, [ebp+12]
	mov edi, [ebp+8]
	mov ecx, 0
	fldz
	petla:
		fld dword ptr [edi+4*ecx]
		fldz
		fcomi st(0),st(1) ; fcomi?
		fstp st(0)
		je zero
		
		fld dword ptr [edi+4*ecx]
		fyl2x
		faddp
		jmp dalej

	zero:
		fstp st(0)

	dalej:
		inc ecx
		cmp ecx, esi
		jb petla

	; opcja 1
	;push 0FFFFFFFFh
	;fild dword ptr [esp]
	
	; opcja 2
	push 0BF800000h
	fld dword ptr [esp]
	
	add esp, 4
	fmulp

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_entropy ENDP

_main PROC
	push number
	push offset probabilities
	call _entropy
	add esp, 8

	push 0
	call _ExitProcess@4
_main ENDP
END