.686
.model flat
extern _ExitProcess@4 : PROC
extern _malloc : PROC

.data
tekst	db	'Marcia',0

.code
_komunikat PROC
	push ebp
	mov ebp,esp
	push ebx
	push esi
	push edi

	mov edi, [ebp+8]
	mov ecx, 0
petla:
	mov al, [edi + ecx]
	inc ecx
	cmp al, 0
	jne petla

	dec ecx
	mov edx, ecx
	add ecx, 6

	; z jakiegos powodu malloc zeruje ecx i edx...
	push edx
	push ecx
	call _malloc
	pop ecx
	pop edx
	mov esi, eax
	push edx
	dec edx
przepisz:
	mov bl, [edi+edx]
	mov [esi+edx],bl
	dec edx
	cmp edx, -1
	jne przepisz
	
	pop edx
	mov byte ptr [esi+edx],'B'
	inc edx
	mov byte ptr [esi+edx],'³'
	inc edx
	mov byte ptr [esi+edx],'¹'
	inc edx
	mov byte ptr [esi+edx],'d'
	inc edx
	mov byte ptr [esi+edx],'.'
	inc edx
	mov byte ptr [esi+edx],0
	mov eax, esi
	
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_komunikat ENDP

_main PROC
	push offset tekst
	call _komunikat
	add esp, 4

	push 0
	call _ExitProcess@4
_main ENDP
END