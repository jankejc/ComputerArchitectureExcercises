.686
.model flat

extern _ExitProcess@4 : PROC

.data
	stale DW 2,1
	napis DW 10 dup (3),2
	tekst DB 7
		  DQ 1
	tekst_x DB 'aaaa', 0

; deklaracja obszaru u�ywaj�c dyrektywy dd
	obroty	LABEL dword
			ORG $ + 28
	; tutaj jest rezerwowane 28 bajt�w, gdzie 
	; b�d� mie�ci�y si� dane dword (28 / 4)= 7 takich

	a1_co	db 'a', 0 
	
	obro_dd	dd 7 dup (?)
	; Tutaj te� musz� by� zarezerwowane 28 bajt�w, 
	; czyli 7 dwords

	a2_con	db 'a', 0 

.code
_main PROC
	
; xor bez xora
	mov edi, 35
	mov esi, 24
	xor edi, esi

	mov edi, 35
	mov eax, edi
	mov esi, 24
	mov ebx, 24

	and edi, esi
	or eax, ebx
	not eax
	or edi, eax
	not edi

; co bedzie w ebx i cx
	mov ecx, 0
	mov ebx, 0
	 
	; ka�de dodawanie i odejmowanie na zmiennych w specyfikowaniu miejsca
	; to dzia�anie bajtowe na adresie, a nie na zmiennej
	MOV CX, napis -1 
	; zmienna napis rozpocznie si� o bajt wy�ej
	; to znaczy od 00, bo wcze�niej jest jedynka z 
	; poprzedniej zmiennej, a skoro to jest little endian
	; to bajt wy�ej wyjdzie na 00
	; do CX przejd� dwa bajty, a wi�c 00 i 03 -> 0300h (zn�w: little endian)

	SUB tekst, CH
	; CH to jest rejestr!!
	; 7 - 3 = 4

	MOV EDI,1 
	MOV tekst[4*EDI],CH
	; MEM: 04 01 00 00 | 03 00 00 00 00

	MOV EBX, DWORD PTR tekst+1
	; MEM: 04 | 01 00 00 03 00 00 00 00
	; EBX: 03 00 00 01 h

	; => trzeba pami�ta� jak s� u�o�one bajty w pami�ci
	; bior�c pod uwag� LE. To nie jest tak jak zapisze binarnie!!
 
 ; co zwroci OF, ZF, CF?
	xor eax, eax
	sub eax, 0FFFFFFFFh

	mov eax, 0FFFFFFFFh
	sub eax, 0FFFFFFFFh

	xor eax, eax
	add eax, 0FFFFFFFFh

	xor eax, eax
	bts eax, 31
	add eax, 0FFFFFFFFh

; zamiana z U2 na ZM
	mov ebx, 0FFFFFFFFh ; -1
	bt ebx, 31
	jnc koniec			; je�li dodatnia to koniec

	neg ebx
	bts ebx, 31

koniec:
	nop

; co bedzie w dh
	mov dh, 15
	xor dh, 12

; co stanie sie z wartoscia esi
	mov esi, 1
	lea esi, [esi + esi*8]

; co jest bledem
	sub esp, 4
	mov [esp], dword PTR 'A'

; wyj�tek procesora i jakie flagi
	mov ax, 0
	mov dx, 1
	;div dx zakomentowane, �eby b��d nie by� podnoszony

	push 0
	call _ExitProcess@4 ; zako�czenie programu
_main ENDP
END