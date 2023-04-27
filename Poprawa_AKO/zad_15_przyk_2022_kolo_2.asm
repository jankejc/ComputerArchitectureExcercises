.686
.model flat

extern _ExitProcess@4 : PROC

.data
tablica dd 1.0, 2.0, 3.0, 4.0
wagi	dd 4.0, 3.0, 2.0, 1.0

.code
_avg_wd PROC
	push ebp
	mov ebp, esp
	push edi
	push esi

	finit
	mov edi, [ebp + 16] ; wagi
	mov esi, [ebp + 12] ; tablica
	mov ebx, [ebp + 8]	; n

	mov ecx, 0
	fldz	; podstawa do liczenia sumy wag
	petla_2:
		fld dword ptr [esi + 4*ecx]
		fld dword ptr [edi + 4*ecx]
		fmulp
		faddp
		inc ecx
		cmp ecx, ebx
		jb petla_2
	; mamy sumê iloczynów wyrazu i wagi
	
	mov ecx, 0
	fldz	; podstawa do liczenia sumy iloczynu
	petla_1:
		fld dword ptr [edi + 4*ecx]
		faddp
		inc ecx
		cmp ecx, ebx
		jb petla_1
	; mamy sumê wag w ST(0)

	fdivp	; fdivp = fdivp st(1), st(0)
	; mamy œredni¹ wa¿on¹ na stosie koprocesora
	; wszystkie poœrednie zmienne zosta³y zdjête

	pop esi
	pop edi
	pop ebp
	ret
_avg_wd ENDP

_main PROC
	push offset wagi
	push offset tablica
	push 4
	call _avg_wd

	push 0
	call _ExitProcess@4
_main ENDP
END