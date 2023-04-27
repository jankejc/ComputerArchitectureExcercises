.686
.model flat

extern _ExitProcess@4 : PROC
extern _GetSystemInfo@4 : PROC

.data
wsk dd 0

.code
_liczba_procesorow PROC
;	push 'pter'
	push offset wsk
	call _GetSystemInfo@4
;	add esp, 4
	mov eax, wsk[20]

	ret
_liczba_procesorow ENDP

_main PROC
	call _liczba_procesorow

	push 0
	call _ExitProcess@4
_main ENDP
END