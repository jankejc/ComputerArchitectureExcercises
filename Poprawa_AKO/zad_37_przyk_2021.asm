.686
.model flat

extern _ExitProcess@4 : PROC

.data
; przygotowanie 128 bajtowego rejestru
; i test czy bêdzie coœ w CF
; w tym przypadku, po jedny, przesuniêciu 
; wszêdzie s¹ dwójki na 4 bajtach oprócz trójki na samym pocz¹tku
; gdzie przesz³o CF = 1. CF = 1.
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
				; ¿eby mo¿na go by³o wrzuciæ
				; na zerowy bit pierwszych 4 bajtów

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