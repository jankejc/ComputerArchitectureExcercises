.686
.model flat
extern _ExitProcess@4 : PROC

.data
tekst db 'tekscik',0

.code
_szyfruj PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	
	mov edi, [ebp+8]
	mov ebx, 52525252h
	mov ecx, 0

petla:
	mov al, [edi + ecx]
	cmp al, 0
	je koniec
	xor al, bl
	bt ebx, 30
	jc trzy_zero_ust
	bt ebx, 31
	jc trzy_jeden_ust
	btr edx, 0
	jmp dalej

trzy_zero_ust:
	bt ebx, 31
	jc trzy_zero_trzy_jeden_ust
	bts edx, 0
	jmp dalej

trzy_jeden_ust:
	bts edx, 0
	jmp dalej

trzy_zero_trzy_jeden_ust:
	btr edx, 0

dalej:
	shl eax, 1
	bt edx, 0
	jc ustaw
	btr eax, 0
	jmp dalej_2

ustaw:
	bts eax, 0

dalej_2:
	mov [edi + ecx], al
	inc ecx
	jmp petla

koniec:
	pop edi
	pop ebx
	pop ebp
	ret
	
	pop edi
	pop ebx
	pop ebp
	ret
_szyfruj ENDP

_main PROC
	push offset tekst
	call _szyfruj
	add esp, 4

	push 0
	call _ExitProcess@4
_main ENDP
END