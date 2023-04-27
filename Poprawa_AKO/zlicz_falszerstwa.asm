.686
.model flat

extern _ExitProcess@4 : PROC

.data
; '|' -> ';', '\' -> '"'
temp_stack db 'ebpr', 'slad' 
wejscie db "|{\tekst\:sda,\szyfr\:0xC9}|{\tekst\:ssss,\szyfr\:0x47}|{\tekst\:foo,\szyfr\:0xAB}|", 0
klucz db 5

.code
_main PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov eax, 0
	mov ebx, 0
	; linia kodu, ¿eby zasymulowaæ wywo³anie z parametrami z .c
	mov ebp, offset temp_stack
	
	mov ebx, 0
	mov bl, klucz
	mov esi, ebx
	mov ebx, offset wejscie	; ci¹g znaków
	mov edi, 0	; licznik falszerstw
	mov ecx, -2	; i pierwszym obiegu pêtli wejdzie na 1, 
				; a to ma byc jakis znak, jesli jest jeszcze jeden element 
	mov edx, 0

kolejny:
	add ecx, 3
	mov al, byte ptr [ebx + ecx]
	cmp al, '{'
	jne koniec
	add ecx, 9	; poczatek wartosci tekstu
	mov al, byte ptr [ebx + ecx]
	xor eax, esi
	inc ecx
czy_jeszcze_jeden_znak:
	mov dl, byte ptr [ebx + ecx]
	cmp dl, ','
	je dalej_1
	mov edx, 0
	xor edx, esi
	add eax, edx
	inc ecx
	jmp czy_jeszcze_jeden_znak

; sprawdzenie wartoœci czy falszywa
dalej_1:
	add ecx, 11	; do liczby w szyfrze
	mov edx, 0
	mov dl, byte ptr [ebx + ecx]
	sub dl, 30h
	push eax
	mov eax, edx
	mov edx, 10
	mul edx
	inc ecx
	mov edx, 0
	mov dl, byte ptr [ebx + ecx]
	sub dl, 30h
	add eax, edx
	mov edx, eax
	pop eax
	cmp eax, edx
	je dalej_2
	inc edi	; falszywa +1

dalej_2:
	jmp kolejny

koniec: 
	mov eax, edi
	
	pop esi
	pop edi
	pop ebx
	pop ebp

; wynik falszywych w eax

	push 0
	call _ExitProcess@4
_main ENDP
END