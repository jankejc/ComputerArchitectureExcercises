; wywo³anie przez wchar_t *ASCII_na_UTF16(char *znaki, int n);

.686
.model flat
extern _malloc : PROC
extern _ExitProcess@4 : PROC


.data
tablica db 'dzien dobry, nazywam sie jan', 0	; 28 znakow bez 0 
ttt		db 'ttt'



.code
_ASCII_na_UTF16 PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov eax, [ebp + 12]	; n -> eax
	mov esi, eax		; n -> esi, bo edx bêdzie u¿yte w mno¿eniu
	inc eax				; miejsce na 0 w UTF-16
	mov ecx, 2
	mul ecx

	push eax
	call _malloc
	add esp, 4
	mov edi, eax		; adres no. obszaru -> edi
	
	mov edx, esi		; n -> edx
	mov ecx, 0
	mov esi, [ebp + 8]	; adres star. obsz. -> esi
	mov ah, 0

kolejny: 
	mov al, byte ptr [esi + ecx]
	mov word ptr [edi + 2*ecx], ax
	inc ecx
	cmp ecx, edx
	jne kolejny

	mov ax, 0
	mov word ptr [edi + 2*ecx], ax
	mov eax, edi		; zwrócenie adresu na nowy obszar

	pop edi
	pop esi
	pop ebx
	pop ebp

	ret
_ASCII_na_UTF16 ENDP


_main PROC
; wywo³anie funkcji
	push 28
	push offset tablica
	call _ASCII_na_UTF16
	add esp, 8

	push 0
	call _ExitProcess@4
_main ENDP
END