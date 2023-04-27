; Zadanie jest testowane na bazie przyk�adu. Aby dosta� rozwi�zanie nale�y w rozwi�zaniu 
; zmieni� por�wnanie do 25 na 70. �rodowisko te� si� zmieni, ale to ju� nie jest cz�� zadania.
; Tablice s� dane w ESI i EDI.
.686
.model flat

extern _ExitProcess@4 : PROC

.data

; tablica dla macierzy 5x5
pierwsza_tablica db 1,1,1,0,0,0,1,1,0,0,1,1,1,0,0,0,1,1,0,0,1,1,1,1,1

; miejsce na skompresowan� macierz 5x5
; na ko�cu w tej tablicy powinno by�: 227 (1110 0011, w pami�ci tak samo, bo to tylko bajty),
;									  56  (0011 1000),
;									  207 (1100 1111),
;									  128 (1000 0000)
druga_tablica db 4 dup (?)


koniec_tab db 'kdt', 0

.code
_main PROC
; przygotowanie �rodowiska
	push ebp
	mov ebp, esp
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	mov esi, offset pierwsza_tablica
	mov edi, offset druga_tablica

; program docelowy

	mov al, 0	; rejestr na kompresje
	mov edx, 7	; licznik bts
	mov ecx, 0	; pozycja w pierwszej tablicy
	mov ebx, 0	; pozycja w drugiej tablicy

petla:
	cmp byte ptr [esi + ecx], 0
	je spr_rej_komp
	bts eax, edx
spr_rej_komp:
	dec edx
	cmp edx, -1
	jne dalej
	mov byte ptr [edi + ebx], al
	mov al, 0
	mov edx, 7
	inc ebx
dalej:
	inc ecx
	cmp ecx, 25	; tu w razie czego trzeba zmieni� na 70
	jne petla

	cmp edx, 7	; to znaczy, �e ostatni bajt by� pe�ny i na ostatek si� zapisa�
	je koniec
	mov byte ptr [edi + ebx], al	; wrzucenie to co jeszcze zosta�o

koniec:
; zwolnienie �rodowiska
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	pop ebp
	push 0
	call _ExitProcess@4
_main ENDP
END