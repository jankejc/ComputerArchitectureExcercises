.686
.model flat

extern _ExitProcess@4 : PROC

.data
; 153 - 1001 1001

bufor db 2 dup (?)

.code
_zapisz5bitow PROC
	push edx
	push ecx
	push eax
	push ebx

	mov ah, 0
	mov ebx, 0
	mov ch, 0
	mov dx, -1

kolejny_bit:
	inc dx
	bt ax, dx
	jnc inc_ind_bl
	bts bx, cx

inc_ind_bl:
	inc cx
	cmp ecx, 7
	jbe dalej
	mov byte ptr [edi], bl
	mov bl, 0
	mov cl, 0

dalej:
	cmp dl, 4
	jne kolejny_bit

	cmp cl, 0
	je koniec
	mov byte ptr [edi + 1], bl

koniec:
	pop ebx
	pop eax
	pop ecx
	pop edx

	ret
_zapisz5bitow ENDP

_main PROC
	mov al, 153
	mov edi, offset bufor
	mov cl, 7

	call _zapisz5bitow 

	push 0
	call _ExitProcess@4
_main ENDP
END