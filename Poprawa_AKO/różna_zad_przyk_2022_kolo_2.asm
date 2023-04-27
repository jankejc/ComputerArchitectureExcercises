.686
.model flat
extern _ExitProcess@4 : PROC

.data
piec_float	dw 5.0
pol			dd 0.5
fl_a	dd 3f800001h
fl_b	dd 412c0000h
fl_wyn  real4 0.0

L1	dd	01000000010000000000000000000001b
L2	dd	01000000100000000000000000000001b
L3	dd	0

ciag1 db 'abcd'
ciag2 db 'efgh'
ciag3 db 'ijkl'

.code
_iteracja PROC
	push ebp
	mov ebp, esp
	mov al, [ebp + 8]
	sal al, 1

	jc zakoncz
	inc al
	push eax
	call _iteracja
	add esp, 4
	pop ebp
	ret

zakoncz:
	rcr al, 1
	
	pop ebp
	ret
_iteracja ENDP



_main PROC
	finit
	pusha

; zadanie 12 - iloraz x / y (obie float)
; (sprawdzenie)
	mov eax, offset pol
	fld dword ptr [eax]

; zadanie 10
; 1 w pierwszym to 100h, 1 w drugim to 80h
	mov esi, 80000103h
	mov edi, 40000081h
	bt edi, 31
	jc zeruj
	
	mov eax, esi
	mov edx, edi
	shr eax, 1
	shl edx, 1
	shr edx, 1
	cmp eax, edx
	jb zeruj
	je dalej_1
	stc
	jmp koniec_1

dalej_1:
	bt esi, 0
	jnc zeruj
	stc
	jmp koniec_1

zeruj: 
	clc
koniec_1:
	nop


; zad. 9: zaokr¹glenie liczby
	mov edx, 0FFFFFCC0h
	
	bt edx, 6	; 2^-1
	jc w_gore
	
	shr edx, 7
	shl edx, 7
	jmp koniec_2

w_gore:
	mov eax, edx
	shl eax, 1
	shr eax, 8
	inc eax
	shl eax, 7
	bt edx, 31
	jc ujemna

	mov edx, eax
	jmp koniec_2

ujemna:
	bts eax, 31
	mov edx, eax

koniec_2:
	nop


; zad. 8: 
	mov ebx, 100h
	
	shr ebx, 7
	cmp ebx, 0
	jne ustaw
	clc
	jmp koniec_3
ustaw:
	stc
koniec_3:
	nop

; zad. 7: wynik w
	push 32
	call _iteracja
	add esp, 4
	nop

; zad. jaki wynik?
	push offset fl_wyn
	push fl_b
	push fl_a
	push 0
	push ebp
	mov ebp, esp
	push ebx
	push edi

	mov eax, [ebp+8]
	mov ebx, [ebp+12]
	mov edi, [ebp+16]

	and eax, 7FFFFFh
	shl eax, 23
	add ebx, eax

	mov [edi], ebx

	pop edi
	pop ebx
	pop ebp
	add esp, 16

; zad. (w przeciwieñstwie do koprocesora, my chcemy odci¹æ ostani bit, 
; bo nam siê nie mieœci koprocesorowi siê mieœci)
	fld L1
	fadd L2
	fst L3

; zad.
	push dword ptr ciag3
	push dword ptr ciag2
	push dword ptr ciag1
	mov eax, 2 ; 'c' - od zera liczone

	mov al, [esp][eax]
	add esp, 12

	popa
	push 0
	call _ExitProcess@4
_main ENDP
END