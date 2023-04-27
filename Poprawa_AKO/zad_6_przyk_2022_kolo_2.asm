.686
.model flat
extern _ExitProcess@4 : PROC

.data

.code
_kwadrat PROC
	push ebp
	mov ebp, esp
	push ebx
	mov eax, [ebp+8]
	cmp eax, 0
	je zwroc
	cmp eax, 1
	je zwroc
	lea edx, [eax-2]
	mov ecx, edx
	mov ebx, 0
petla:	
	add ebx, edx
	dec ecx
	cmp ecx, 0
	ja petla

	lea edx, [4*eax]
	sub edx, 4
	add ebx, edx
	mov eax, ebx

zwroc:

	pop ebx
	pop ebp
	ret
_kwadrat ENDP

_main PROC
	push 300
	call _kwadrat
	add esp, 4

	push 0
	call _ExitProcess@4
_main ENDP
END