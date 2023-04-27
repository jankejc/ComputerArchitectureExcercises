.686
.model flat

extern _ExitProcess@4 : PROC

.data
tablica_3 dw 3,4,5,6,7,8,9,10,11,12,0
znak db 'kkkk'

tablica_5 db 18 dup (?), 1,2,3,4,5,6,7,8,9
wynik_64 dq 0
wynik_8 dq 0

.code
_dynamic_fun PROC
	push esi
	push ebx
	mov esi, [esp+8]
	xor ebx, ebx
	mov bl, byte ptr [esi]
	mov ebx, dword ptr [esi+4*ebx+1]
	call ebx
	pop ebx
	pop esi
	ret
_dynamic_fun ENDP

_main PROC
; zadanie 6
	nop
	;pushf
	;pop eax
	bts eax, 8
	;push eax
	;popf

; zadanie 1
	;push 0B00CBABEh
	;pop eax

; zadanie 2
	mov al, -20
	mov ebx, 10
	movsx eax, al
	;xor edx, edx
	test eax, 31
	jz dalej
	mov edx, 0FFFFFFFFh
dalej:
	idiv ebx

; zadanie 3
	mov esi, offset tablica_3
	mov ecx, 0
ile_jest:
	mov ax, word ptr [esi + 2*ecx]
	inc ecx
	cmp ax, 0
	jne ile_jest

	sub ecx, 2
	mov ebx, 0
	bt ecx, 0
	jnc zamien_nieparz
	
zamien_parz:
	mov ax, word ptr [esi + 2*ebx]
	mov dx, word ptr [esi + 2*ecx]
	mov word ptr [esi+2*ebx], dx
	mov word ptr [esi+2*ecx], ax
	inc ebx
	dec ecx
	mov eax, ecx
	sub eax, ebx
	cmp eax, 1
	jne zamien_parz
	jmp koniec

zamien_nieparz:
	mov ax, word ptr [esi + 2*ebx]
	mov dx, word ptr [esi + 2*ecx]
	mov word ptr [esi + 2*ebx], dx
	mov word ptr [esi + 2*ecx], ax
	inc ebx
	dec ecx
	mov eax, ecx
	sub eax, ebx
	cmp eax, 0
	jne zamien_nieparz

koniec:

; zadanie 5
	mov cl, 2
	push ebx
	push esi
	mov esi, offset tablica_5
	movzx ecx, cl
	lea eax, [esi + 8*ecx]
	add eax, ecx
	mov eax, dword ptr [eax]
	mov ebx, offset wynik_64
	mov dword ptr [ebx], eax
	mov edx, ecx	
	add edx, 4
	lea eax, [esi + 8*ecx]
	add eax, edx
	mov eax, dword ptr [eax]
	mov dword ptr [ebx + 4], eax
	mov ebx, offset wynik_8
	add edx, 4
	lea eax, [esi + 8*ecx]
	add eax, edx
	mov al, byte ptr [eax]
	mov byte ptr [ebx], al
	pop esi
	pop ebx

; zadanie 8
	mov eax, 0
	mov ax, 2000h
	neg ax

; zadanie 10
	call _dynamic_fun
	db 2
	dd 500
	dd 710
	dd 320
	jmp ciag_dalszy
ciag_dalszy:


	
	push 0
	call _ExitProcess@4
_main ENDP
END