.686
.model flat
extern _ExitProcess@4 : PROC
extern _malloc : PROC

.data
pierwsza dd	-5
druga dd 10
wsk dd 0

.code
_roznica PROC
	push ebp
	mov ebp,esp
	
	mov eax, [ebp+8]
	mov eax, [eax]
	mov edx, [ebp+12]
	mov edx, [edx]
	mov edx, [edx]

	sub eax, edx

	pop ebp
	ret
_roznica ENDP

_main PROC
	mov eax, offset druga
	mov wsk, eax

	push offset wsk
	push offset pierwsza
	call _roznica
	add esp, 8

	push 0
	call _ExitProcess@4
_main ENDP
END