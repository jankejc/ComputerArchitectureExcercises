.686
.model flat

extern _ExitProcess@4 : PROC

.data

.code

_NWD PROC
	push ebp
	mov ebp, esp
	push ebx
	
	mov eax, 0
	mov ebx, dword ptr [ebp + 8]	; a -> ebx
	mov edx, dword ptr [ebp + 12]	; b -> edx
	cmp ebx, edx
	ja a_wieksze	; ze znakiem jg
	jb b_wieksze	; ze znakiem jl
	mov eax, ebx
	jmp koniec

a_wieksze:
	sub ebx, edx
	push edx
	push ebx
	call _NWD
	add esp, 8
	jmp koniec

b_wieksze:
	sub edx, ebx
	push edx
	push ebx
	call _NWD
	add esp, 8

koniec:
; wynik w eax

	pop ebx
	pop ebp
	ret
_NWD ENDP

_main PROC
	push 7
	push 1
	call _NWD	; wynik w eax
	add esp, 8

	push 0
	call _ExitProcess@4
_main ENDP

END