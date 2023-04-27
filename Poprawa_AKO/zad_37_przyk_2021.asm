.686
.model flat

extern _ExitProcess@4 : PROC

.data
; przygotowanie 128 bajtowego rejestru
; i test czy b�dzie co� w CF
; w tym przypadku, po jedny, przesuni�ciu 
; wsz�dzie s� dw�jki na 4 bajtach opr�cz tr�jki na samym pocz�tku
; gdzie przesz�o CF = 1. CF = 1.
rejestr1024 dd	31 dup (1), 80000001h
kt db 'aaaaaaa'

.code
_przesun PROC
	push eax
	push ebx
	push ecx
	
	mov ecx, 32
	mov ebx, 0
	mov eax, dword ptr [rejestr1024 + 124]
	bt eax, 31	; sprawdzenie ostatniego bitu
				; �eby mo�na go by�o wrzuci�
				; na zerowy bit pierwszych 4 bajt�w

kolejne_4_bajty:
	mov eax, dword ptr [rejestr1024 + 4*ebx]
	rcl eax, 1	; CF -> bit 0, bit 31 -> CF
	mov dword ptr [rejestr1024 + 4*ebx], eax 
	inc ebx
	loop kolejne_4_bajty

	pop ecx
	pop ebx
	pop eax
	ret
_przesun ENDP

_main PROC
	call _przesun

	push 0
	call _ExitProcess@4
_main ENDP
END