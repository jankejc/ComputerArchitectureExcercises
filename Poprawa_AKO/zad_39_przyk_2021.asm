; This program work with 0, 1, 2 as chars to decode into barcode value.
.686
.model flat

extern _ExitProcess@4 : PROC

.data
suma_kontrolna dd ?     ; place for control sum
znaki db 1, 1, 1, 5     ; column 2 from table 1
      dw 0              ; column 3 from table 1
      db 1, 1, 2, 4
      dw 15
      db 1, 1, 3, 3
      dw 17
      
      ;-----------------; rest of the array
      
      db 5, 1, 1, 1
      dw 10

lancuch db '0', '1', '2', '0', '1', '2', '0', '1'
bufor   dw 8 dup (?)
kb      db 'kb'

.code
_main PROC
; zadanie 1
    mov esi, OFFSET lancuch ; address of buffer containing string to encode
    mov edi, OFFSET bufor   ; address of buffer for BC412 codes
    mov ecx, 8              ; number of characters to be encoded
    mov suma_kontrolna, 0             ; initial value for sum

nastepny_znak:
    dec ecx
    mov ebx, 0
    mov bl, [esi + ecx]

    ; przygotowanie indeksu bazowego tablicy w ebx
    cmp ebx, 'A'
    jae litery
    sub ebx, 30h
    jmp przyg_koduj
litery:
    cmp ebx, 'O'
    ja nad_o
    sub ebx, 37h
    jmp przyg_koduj
nad_o:
    sub ebx, 36h

przyg_koduj:
    ; przygotowanie indeksu efektywnego 
    ; tablicy o okreœlonej strukturze bajtowej w ebx
    mov eax, ebx
    mov ebx, 6
    mul ebx
    mov ebx, eax
    
    add ebx, 4  ; dostanie siê do 5 elementu tabeli, do wartoœci znaku
    push edi 
    mov edi, suma_kontrolna
    add edi, dword ptr [znaki + ebx]
    mov suma_kontrolna, edi
    pop edi

    dec ebx  ; dostanie siê do 4 elementu spod indeksu danego znaku
    mov eax, 0
    push ecx
    mov ecx, -1 ; ¿eby pozycja bitu pzy bts siê zgadza³a w 1st obiegu
    push esi
    mov esi, 4

koduj:
    add cl, [znaki + ebx]
    inc ecx
    bts eax, ecx
    dec ebx
    dec esi
    cmp esi, 0
    ja koduj

    pop esi
    pop ecx
    mov [edi + 2*ecx], ax
    cmp ecx, 0
    ja nastepny_znak

	push 0
	call _ExitProcess@4
    
_main ENDP
END