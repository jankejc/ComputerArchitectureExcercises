.686
.model flat

extern _ExitProcess@4 : PROC

.data
znaki db 51h, 66h, 0c2h, 0a2h, 0c2h, 0afh, 0e7h, 95h, 08fh, 0e7h, 95h, 08fh, 0	
; 2 * 1B, 2 * 2B, 2 * 3B => 6 znaków
; w UTF-16 => 12B, w UTF-8 => 12B

.code
_main PROC
	push ecx
	push eax
	push ebx
	mov ecx, 0
	mov ebx, 0
	mov eax, 0

kolejny_znak:
	mov al, byte ptr [znaki + ebx]
	cmp eax, 0
	je koniec
	bt eax, 7
	jnc znak_1B
	bt eax, 6
	jnc znak_2B
	add ebx, 3
	jmp przyg_kol
znak_1B:
	inc ebx
	jmp przyg_kol
znak_2B:
	add ebx, 2
przyg_kol:
	inc ecx
	jmp kolejny_znak

koniec:
	mov eax, ecx
	mov ecx, 2
	mul ecx
	mov ecx, eax

	pop ebx
	pop eax
	pop ecx

	push 0
	call _ExitProcess@4
_main ENDP
END