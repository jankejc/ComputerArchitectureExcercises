.686
.model flat
extern _ExitProcess@4 : PROC
extern _GetComputerNameExW@12 : PROC

.data
a dd 0
znak_utf_8 db 0C5H, 0B8H
tablica_shortow dw 0,1,2,3,4,5,6,7,8,9,10,11,12,13
k EQU 1024
temp db ?
t3 db 2
table_1 db 1,2,3
table_2 dw 1,2,3



.code
_iteracja PROC
	push ebp
	
	
	pop ebp
	ret
_iteracja ENDP



_main PROC
	pusha
	finit

; czym to siê ró¿ni?
	lea ebx, table_2+4
	mov eax, offset table_2+4
	; niczym

; zerowanie rejestrów
	mov ax, 0FFFFh
	and ax,0
	mov ax, 0FFFFh
	xor ax,ax
	mov ax, 0FFFFh
	mov ax,0
	mov ax, 0FFFFh
	lea ax, [0]
	mov ax, 0FFFFh
	shl ax,16
	mov ax, 0FFFFh
	shr ax,16
	mov ax, 0FFFFh
	sal ax,16
	nop

; kodowanie rozkazów
	; lea ebp,[esp+10]
	db 8dh
	db 6ch
	db 24h
	db 0ah

	; lea ecx,[ebp+12]
	db 8dh
	db 4dh
	db 0ch

	; lea edx,[4*esi+1025]
	db 8dh
	db 14h
	db 0b5h
	db 01h
	db 04h
	db 00h
	db 00h

	; lea edx,[esi+1025]
	db 8dh
	db 96h
	db 01h
	db 04h
	db 00h
	db 00h

	; lea edx, [esi+2*ebx]
	db 8dh
	db 14h
	db 5eh

	; lea edx,[esi+2*ebx-1025]
	db 8dh
	db 94h
	db 5eh
	db 0ffh
	db 0fbh
	db 0ffh
	db 0ffh

	; xchg ah,al
	db 86h
	db 0e0h

	; movzx esi, di
	db 0fh
	db 0b7h
	db 0f7h

	; movsx ebx,ah
	db 0fh
	db 0beh
	db 0dch

	; mov bl,ah
	db 8ah
	db 0dch
	
	; mov bx, ax
	db 66h
	db 8bh
	db 0d8h

	; mov dword ptr [ebx+8*esi-1083],-1083

	db  0C7H
	db  84H
	db  0F3H
	db  0C5H
	db  0FBH
	db  0FFH
	db  0FFH
	db  0C5H
	db  0FBH
	db	0FFh
	db	0FFh

	; mov ax, -158
	db 66h
	db 0B8h
	db 62h
	db 0FFh

	; mov word ptr [edi+4*ecx-20],bx
	nop
	db 66h
	db 89h
	db 5Ch
	db 8Fh
	db 0ECh

; modyfikacja dynamiczna operacji
	
	;xor byte ptr ds:[$+2], 1Bh
	;sub edx, ecx
	;sub ecx,edx
	mov al, 0D1h
	xor al, 1Bh
	; powinno byæ al=CAh

; 12 element (od 0) na wierzcho³ek kopro
	mov edx, offset tablica_shortow
	fild word ptr [edx+24]
	fild word ptr [edx+22]
	fsub

; ile razy wykona siê inc ecx
	mov ecx, -3
	petla_egz:
		inc ecx
		jg petla_egz

; liczba float x64
	mov edx, 3f800000h ; 1.0f
	push edx
	fld dword ptr [esp]

	mov eax, edx
	shr eax, 23
	add al, 6
	mov ecx, 9
	shl edx, 9
	petla:
		shr eax,1
		rcr edx,1
		dec ecx
		cmp ecx,0
		jne petla

	push edx
	fld dword ptr [esp]

; dostanie nazwy komputera
	mov ebp, esp
	sub esp, 100
	mov esi, esp 
	sub esp, 4
	mov eax, 50
	mov [esp], eax
	push esp
	push esi
	push 4
	call _GetComputerNameExW@12
	mov esp, ebp

; rozkaz, którego pole adresowe jest wiêksze ni¿ adres efektywny
; zak³adam, ¿e ebx < 20
	add eax, [ebx-10]

; zadanie 2: 5.03.2022
	clc
	mov ebx, -1
dalej:
	inc ebx
	jc dalej
	nop

	
; zadanie 1
	mov ebx, 41650000h
	push ebx
	fld dword ptr [esp]
	add esp, 4

	popa
	push 0
	call _ExitProcess@4
_main ENDP
END