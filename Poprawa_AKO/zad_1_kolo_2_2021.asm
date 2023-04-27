.686
.model flat
extern _ExitProcess@4 : PROC

.data

.code
_traverse_tree PROC
	
_traverse_tree ENDP

_main PROC
	

	push 0
	call _ExitProcess@4
_main ENDP
END