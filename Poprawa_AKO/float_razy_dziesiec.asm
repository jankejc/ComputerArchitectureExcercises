.686
.model flat
extern _ExitProcess@4 : PROC

.data
jedynka dd 1.0

.code
_razy_dziesiec PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi
	finit

	mov ebx, [ebp+8]
	mov eax,ebx
	mov ecx,ebx

	shr ecx, 23
	add cl,3
	shl eax,9
	mov edx,0

	petla:
		rcl eax,1
		rcl ecx,1
		inc edx
		cmp edx,23
		jne petla
; w ecx mamy arg*8
	push ecx
	fld dword ptr [esp]
	add esp,4
	
	mov ebx,ecx
	mov eax,[ebp+8]
	mov ecx,[ebp+8]
	shl ecx,9
	shr ecx,12
	shl eax,9
	shr eax,12
	add ecx,eax
	add ecx,eax
	mov edx,0
	shr ebx,20
	shl ecx,12
	
	petla_2:
		rcl ecx,1
		rcl ebx,1
		inc edx
		cmp edx,20
		jne petla_2
	
	push ebx
	fld dword ptr [esp]
	add esp,4

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_razy_dziesiec ENDP



_main PROC
	push jedynka
	call _razy_dziesiec
	add esp,4
	nop


	push 0
	call _ExitProcess@4
_main ENDP
END