.686
.model flat

extern _ExitProcess@4 : PROC

.data
pr dd 2.0

.code
_pole_kola PROC
	push ebp
	mov ebp, esp
	push ebx
	mov ebx, [ebp + 8]	; pr

	finit
	fldpi
	fld dword ptr [ebx]
	fmul st(0), st(0)
	fmulp

	pop ebx
	pop ebp
	ret
_pole_kola ENDP

_main PROC
	push offset pr
	call _pole_kola

	push 0
	call _ExitProcess@4
_main ENDP
END