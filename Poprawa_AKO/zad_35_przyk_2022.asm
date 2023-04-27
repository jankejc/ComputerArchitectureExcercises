.686
.model flat

extern _ExitProcess@4 : PROC

.data

.code
_dodaj PROC
	;mov esi, [esp]	; zczytanie adresu, ktory wskazuje na 'dd 5' (œlad)
	;mov eax, [esi]	; wczytanie 5
	;add eax, [esi + 4]	; wczytanie 7
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]	; za œladem jest 5 na 4 bajtach
	add eax, [ebp + 12]
	pop ebp
	ret
_dodaj ENDP

_main PROC
	push 5
	push 7
	call _dodaj
	add esp, 8
	;dd 5
	;dd 7

	push 0
	call _ExitProcess@4
_main ENDP
END