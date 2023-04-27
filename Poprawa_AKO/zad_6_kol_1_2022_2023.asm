.686
.model flat
extern _ExitProcess@4 : PROC

.data

.code
_iteracja PROC
	push ebp
	
	
	pop ebp
	ret
_iteracja ENDP



_main PROC
	
	push 0
	call _ExitProcess@4
_main ENDP
END