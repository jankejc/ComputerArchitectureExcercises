.686
.model flat

extern _ExitProcess@4	: PROC
extern _MessageBoxA@16	: PROC

.data

miesiace dd 00000021h

.code
_main PROC
	push ecx
	push edx
	push eax
	push ebx
	push esi
	push edi
	push ebp
	mov ebp, esp	; do wyliczenia wielkoœci zajêtego stosu

; œrodowisko
	mov cl, 1	; styczeñ
	mov ebx, offset miesiace
; koniec œrodowiska

	mov dx, 0
	mov edi, ebx
	dec cl
	mov ebx, 0
	mov bl, cl
	mov esi, dword ptr [edi + ebx]
	mov ebx, 0
	push 0	; 0 na 32 bitach jako koniec ci¹gu znaków 
			; jakby zaczynamy od tego, bo wtedy bêdzie na samym dole stosu

kolejny_dzien:
	bt esi, ebx ; czy moze byc 
	jnc dalej
	inc dh	; liczba dni œwi¹tecznych
; wstawienie daty w formie ci¹gu znaków na stos
	mov eax, 0
	mov dl, 10
	inc cl
	mov al, cl
	dec cl
	div dl
	add ah, 30h
	add al, 30h
	push ax
	push word ptr ' .'
	mov eax, 0
	inc ebx
	mov ax, bx
	dec ebx	
	div dl
	add ah, 30h
	add al, 30h
	push ax
	push word ptr '| '

dalej:
	inc ebx
	cmp ebx, 32
	jne kolejny_dzien
	
; przygotowanie do wyswietlenia
	cmp dh, 0
	je koniec
	
	mov edx, esp	; adres na ci¹g znaków dat 

	push 0			; 0 na 32 bitach jako koniec ci¹gu znaków
	push 'utyt'		; bêdzie na 4 bajtach
	mov ebx, esp	; bo stos roœnie malej¹co
; wywo³anie funkcji
	push 0
	push ebx
	push edx
	push 0
	call _MessageBoxA@16

; w tym miejscu na pewno mamy coœ na stosie, bo dh by³o > 0
	mov eax, 0
	mov eax, esp
	sub ebp, eax
	mov eax, ebp
	mov dl, 2
	div dl	; max rozmiar tekstu to bêdzie ~= 6 * 31, wiêc dzielenie na ax
	cmp al, 0
	mov eax, esp	; to nie zmieni flag
	je przyg_do_oczysz
; wyrównanie, aby œci¹gaæ po 2 bajty ze stosu
	push 0	
	add eax, 1		

przyg_do_oczysz:
	sub eax, ebp

oczysc_stos:
	pop cx	; jakiœ rejestr do œci¹gania
	dec eax
	cmp eax, 0
	jne oczysc_stos

koniec:
	pop ebp
	pop edi
	pop esi
	pop ebx
	pop eax
	pop edx
	pop ecx

	push 0
	call _ExitProcess@4
_main ENDP
END