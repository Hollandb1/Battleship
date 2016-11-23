INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data

;=====================
;== BATTLESHIP ASCII =
;=====================

BattleshipASCIIRow1 BYTE " _  _ ______    __ __   ___ _ ", 0
BattleshipASCIIRow2 BYTE "|_)|_| |  | |  |_ (_ |_| | |_)", 0
BattleshipASCIIRow3 BYTE "|_)| | |  | |__|____)| |_|_|", 0


;=====================
;======= SHIPS =======
;=====================

BattleShip BYTE "BattleShip(4)		", 0
Carrier BYTE "Carrier(5)		", 0
Submarine BYTE "Submarine(3)		", 0
Destroyer BYTE "Detroyer(3)		", 0
Sweeper BYTE "Sweeper(2)		", 0

;=====================
;==== PLAYER MAP =====
;=====================

PlayerMap BYTE "#: A|B|C|D|E|F|G|H|I|J0: _|_|_|_|_|_|_|_|_|_1: _|_|_|_|_|_|_|_|_|_2: _|_|_|_|_|_|_|_|_|_3: _|_|_|_|_|_|_|_|_|_4: _|_|_|_|_|_|_|_|_|_5: _|_|_|_|_|_|_|_|_|_6: _|_|_|_|_|_|_|_|_|_7: _|_|_|_|_|_|_|_|_|_8: _|_|_|_|_|_|_|_|_|_9: _|_|_|_|_|_|_|_|_|_",0

;=====================
;==== PLAYER SHIPS ===
;=====================

PlayerHealth BYTE 17
PlayerCarrierHealth BYTE 5			; C
PlayerBattleshipHealth BYTE 4		; B
PlayerSubmarineHealth BYTE 3		; S
PlayerDestroyerHealth BYTE 3		; D
PlayerSweeperHealth BYTE 2			; s

;=====================
;=== COMPUTER MAP ====
;=====================

ComputerMapViewable BYTE "#: A|B|C|D|E|F|G|H|I|J0: _|_|_|_|_|_|_|_|_|_1: _|_|_|_|_|_|_|_|_|_2: _|_|_|_|_|_|_|_|_|_3: _|_|_|_|_|_|_|_|_|_4: _|_|_|_|_|_|_|_|_|_5: _|_|_|_|_|_|_|_|_|_6: _|_|_|_|_|_|_|_|_|_7: _|_|_|_|_|_|_|_|_|_8: _|_|_|_|_|_|_|_|_|_9: _|_|_|_|_|_|_|_|_|_",0
ComputerMapHidden BYTE "#: A|B|C|D|E|F|G|H|I|J0: _|_|_|_|_|_|_|_|_|_1: _|_|_|_|_|_|_|_|_|_2: _|_|_|_|_|_|_|_|_|_3: _|_|_|_|_|_|_|_|_|_4: _|_|_|_|_|_|_|_|_|_5: _|_|_|_|_|_|_|_|_|_6: _|_|_|_|_|_|_|_|_|_7: _|_|_|_|_|_|_|_|_|_8: _|_|_|_|_|_|_|_|_|_9: _|_|_|_|_|_|_|_|_|_",0

;=====================
;=== COMPUTER SHIPS ==
;=====================

ComputerHealth BYTE 17
ComputerCarrierHealth BYTE 5		; C
ComputerBattleshipHealth BYTE 4		; B
ComputerSubmarineHealth BYTE 3		; S
ComputerDestroyerHealth BYTE 3		; D
ComputerSweeperHealth BYTE 2		; s

;=====================
;=== RAND PLACEMENT ==
;=====================

;Bounds
UpperBound DWORD ?
LowerBound DWORD ?
ColMin BYTE 63
ColMax BYTE 81
RowMin BYTE 6
RowMax BYTE 15
CurrentRow BYTE ?
CurrentCol BYTE ?

;Ship arrays row, col, row, col...
OccupiedCoordinatesArray BYTE 34 DUP (0)
ComputerCarrierShipArray BYTE 10 DUP (?)
ComputerBattleShipArray BYTE 8 DUP (?)
ComputerSubmarineShipArray BYTE 6 DUP (?)
ComputerDestroyerShipArray BYTE 6 DUP (?)
ComputerSweeperShipArray BYTE 4 DUP (?)


;=====================
;=== UI MECHANICS ====
;=====================

BeginText BYTE "Welcome to BattleShip! Press OK to begin.", 0

PlayerText BYTE "Player", 0
ComputerText BYTE "Computer", 0

TotalHealthText BYTE "Total Health: ", 0
ShipsRemainingText BYTE "Ships Remaining: ", 0

PlayerTurnMessage BYTE "Your turn has resulted in a: ", 0
ComputerMoveMessage BYTE "The computer's turn has resulted in a: ", 0

.code
main PROC

	call Randomize
	call GenerateGameTitle
	call GenerateMaps
	call GenerateUIMechanics
	call PlacePlayerShips
	;call PlaceComputerShips
	call PlaceComputerCarrier

INVOKE ExitProcess, 0
main ENDP

.data

rowCoordinate WORD ?
columnCoordinate WORD ?
mapIndex DWORD ?

mouseClickDirection BYTE ?	; 1: Left, 2: Right
leftClickMessage BYTE "Left Click!", 0
rightClickMessage BYTE "Right Click!", 0

_INPUT_RECORD STRUCT
	EventType WORD ?
	WORD ?
	UNION
		KeyEvent KEY_EVENT_RECORD <>
		MouseEvent MOUSE_EVENT_RECORD <>
	ENDS
_INPUT_RECORD ENDS

InputRecord _INPUT_RECORD <>
ConsoleMode DWORD 0
hStdln DWORD 0
nRead DWORD 0

yoloz COORD 10 DUP (<>)
pt COORD <>

.code

;===============================
GetMouseCoordinates PROC
;===============================
; 
; Returns mouse coordinates 
; on left and right mouse clicks
;
; X: rowCoordinate
; Y: columnCoordinate
;
;================================

	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov hStdln, eax

	INVOKE GetConsoleMode, hStdln, ADDR ConsoleMode
	mov eax, 0090h
	INVOKE SetConsoleMode, hStdln, eax

	mainLoop:

	INVOKE ReadConsoleInput, hStdln, ADDR InputRecord, 1, ADDR nRead

	movzx eax, InputRecord.EventType
	jne skip

	cmp InputRecord.MouseEvent.dwButtonState, 1
	jne skip
	je HandleLeftClick
	

	cmp InputRecord.MouseEvent.dwButtonState, 2
	jne skip
	je HandleRightClick

	HandleLeftClick:

	mov ax, InputRecord.MouseEvent.dwMousePosition.X
	mov bx, InputRecord.MouseEvent.dwMousePosition.Y

	mov mouseClickDirection, 1
	mov rowCoordinate, bx
	mov columnCoordinate, ax

	jmp Complete
	
	HandleRightClick:

	mov ax, InputRecord.MouseEvent.dwMousePosition.X
	mov bx, InputRecord.MouseEvent.dwMousePosition.Y

	mov mouseClickDirection, 2
	mov rowCoordinate, bx
	mov columnCoordinate, ax

	jmp Complete

	skip:

	cmp ecx, 0
	jne mainLoop

	Complete:

	ret
GetMouseCoordinates ENDP

TranslateRowCoordinate PROC

	mov ax, rowCoordinate
	call WriteInt

	mov eax, 0
	mov eax, 25	; A1 in Map
	mov bx, 6	; Starting X-Row coordinate in console

	SeekRow:

	cmp bx, rowCoordinate
	je RowFound

	add eax, 22
	inc bx
	jmp SeekRow

	RowFound:

	mov mapIndex, eax
	call WriteInt

	ret
TranslateRowCoordinate ENDP

TranslateColumnCoordinate PROC

	mov ax, columnCoordinate
	call WriteInt

	mov eax, mapIndex	; Starting from where we are in the row of the map
	;call WriteInt
	mov bx, 23			; Starting coordinate for A-column

	SeekColumn:

	cmp bx, columnCoordinate
	je ColumnFound

	add ebx, 2
	add eax, 2

	jmp SeekColumn

	ColumnFound:

	mov mapIndex, eax
	call WriteInt

	ret
TranslateColumnCoordinate ENDP

GenerateGameTitle PROC

	mov eax, white
	call SetTextColor

	mov dl, 38
	mov dh, 1
	call GoToXY

	mov edx, OFFSET BattleshipASCIIRow1
	call WriteString

	mov dl, 38
	mov dh, 2
	call GoToXY

	mov edx, OFFSET BattleshipASCIIRow2
	call WriteString

	mov dl, 38
	mov dh, 3
	call GoToXY

	mov edx, OFFSET BattleshipASCIIRow3
	call WriteString

	mov dl, 0
	mov dh, 0
	call GoToXY

	call Crlf

	ret
GenerateGameTitle ENDP

GenerateMaps PROC

	mov esi, 0
	mov esi, OFFSET PlayerMap ; esi points to the player board

	mov dl, 20
	mov dh, 5
	call GoToXY

	mov ecx, 11

	CreatePlayerMap:
		push ecx
		mov ecx, 22
		PrintPlayerRow:
			mov al, [esi]

			; Missed Character

			cmp al, 176
			jne CheckPlayerHit
			mov eax, blue
			call SetTextColor
			mov eax, 176
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckPlayerHit:

			cmp al, 178
			jne CheckCarrier
			mov eax, red
			call SetTextColor
			mov eax, 178
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckCarrier:

			cmp al, 67
			jne CheckBattleship
			mov eax, gray
			call SetTextColor
			mov eax, 67
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckBattleship:

			cmp al, 66
			jne CheckSubmarine
			mov eax, gray
			call SetTextColor
			mov eax, 66
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckSubmarine:

			cmp al, 85
			jne CheckDestroyer
			mov eax, gray
			call SetTextColor
			mov eax, 85
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckDestroyer:

			cmp al, 68
			jne CheckSweeper
			mov eax, gray
			call SetTextColor
			mov eax, 68
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckSweeper:

			cmp al, 83
			jne PrintPlayerMapCharacter
			mov eax, gray
			call SetTextColor
			mov eax, 83
			call WriteChar
			jmp FoundPlayerMapCharacter

			PrintPlayerMapCharacter:

			mov eax, lightCyan
			call SetTextColor
			mov eax, [esi]
			call WriteChar

			FoundPlayerMapCharacter:

			inc esi

			cmp ecx, 0
			je PlayerRowComplete
			dec ecx
		jne PrintPlayerRow

		PlayerRowComplete:

		pop ecx
		inc dh

		call GoToXY
		;call Crlf

		cmp ecx, 0
		dec ecx
	jne CreatePlayerMap

	mov edi, 0
	mov edi, OFFSET ComputerMapViewable ; edi points to the viewable computer board

	mov dl, 60
	mov dh, 5
	call GoToXY

	mov ecx, 11

	CreateComputerBoard:
		push ecx
		mov ecx, 22
		PrintComputerRow:
			mov al, [edi]

			; Missed Character

			cmp al, 176
			jne CheckComputerHit
			mov eax, blue
			call SetTextColor
			mov eax, 176
			call WriteChar
			jmp FoundComputerMapCharacter

			CheckComputerHit:

			cmp al, 178
			jne PrintComputerMapCharacter
			mov eax, red
			call SetTextColor
			mov eax, 178
			call WriteChar
			jmp FoundComputerMapCharacter

			PrintComputerMapCharacter:

			mov eax, lightCyan
			call SetTextColor
			mov eax, [edi]
			call WriteChar

			FoundComputerMapCharacter:
		
			inc edi

		loop PrintComputerRow
		
		pop ecx
		inc dh

		call GoToXY
		;call Crlf

	loop CreateComputerBoard

	mov eax, white
	call SetTextColor

	ret
GenerateMaps ENDP

GenerateUIMechanics PROC

	mov dl, 30
	mov dh, 18
	call GoToXY

	mov edx, OFFSET PlayerText
	call WriteString

	mov dl, 68
	mov dh, 18
	call GoToXY

	mov edx, OFFSET ComputerText
	call WriteString

	mov dl, 20
	mov dh, 20
	call GoToXY

	mov edx, OFFSET TotalHealthText
	call WriteString

	mov dl, 60
	mov dh, 20
	call GoToXY

	mov edx, OFFSET TotalHealthText
	call WriteString

	mov dl, 17
	mov dh, 21
	call GoToXY

	mov edx, OFFSET ShipsRemainingText
	call WriteString

	mov dl, 57
	mov dh, 21
	call GoToXY

	mov edx, OFFSET ShipsRemainingText
	call WriteString

	mov dl, 0
	mov dh, 0
	call GoToXY

	ret
GenerateUIMechanics ENDP

PlacePlayerShips PROC

	call PlacePlayerCarrier
	call PlacePlayerBattleship
	call PlacePlayerSubmarine
	call PlacePlayerDestroyer
	call PlacePlayerSweeper

	ret
PlacePlayerShips ENDP

PlacePlayerCarrier PROC

	call GetMouseCoordinates
	call TranslateRowCoordinate
	call TranslateColumnCoordinate

	cmp mouseClickDirection, 1
	je VerticalCarrierPlacement

	cmp mouseClickDirection, 2
	je HorizontalCarrierPlacement

	VerticalCarrierPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex
	inc edi

	mov ecx, 5
	PVC:

		mov al, 67
		mov [edi], al
		add edi, 22

	loop PVC

	jmp CarrierPlaced

	HorizontalCarrierPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 5
	PHC:

		mov al, 67
		mov [edi], al
		inc edi

	loop PHC

	CarrierPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	ret
PlacePlayerCarrier ENDP

PlacePlayerBattleship PROC

	call GetMouseCoordinates
	call TranslateRowCoordinate
	call TranslateColumnCoordinate

	cmp mouseClickDirection, 1
	je VerticalBattleshipPlacement

	cmp mouseClickDirection, 2
	je HorizontalBattleshipPlacement

	VerticalBattleshipPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 4
	PVB:

		mov al, 66
		mov [edi], al
		add edi, 22

	loop PVB

	jmp BattleshipPlaced

	HorizontalBattleshipPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 4
	PHB:

		mov al, 66
		mov [edi], al
		inc edi

	loop PHB

	BattleshipPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	ret
PlacePlayerBattleship ENDP

PlacePlayerSubmarine PROC

	call GetMouseCoordinates
	call TranslateRowCoordinate
	call TranslateColumnCoordinate

	cmp mouseClickDirection, 1
	je VerticalSubmarinePlacement

	cmp mouseClickDirection, 2
	je HorizontalSubmarinePlacement

	VerticalSubmarinePlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 3
	PVU:

		mov al, 85
		mov [edi], al
		add edi, 22

	loop PVU

	jmp SubmarinePlaced

	HorizontalSubmarinePlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 3
	PHU:

		mov al, 85
		mov [edi], al
		inc edi

	loop PHU

	SubmarinePlaced:

	call GenerateMaps
	call GenerateUIMechanics

	ret
PlacePlayerSubmarine ENDP

PlacePlayerDestroyer PROC

	call GetMouseCoordinates
	call TranslateRowCoordinate
	call TranslateColumnCoordinate

	cmp mouseClickDirection, 1
	je VerticalDestroyerPlacement

	cmp mouseClickDirection, 2
	je HorizontalDestroyerPlacement

	VerticalDestroyerPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 3
	PVD:

		mov al, 68
		mov [edi], al
		add edi, 22

	loop PVD

	jmp DestroyerPlaced

	HorizontalDestroyerPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 3
	PHD:

		mov al, 68
		mov [edi], al
		inc edi

	loop PHD

	DestroyerPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	ret
PlacePlayerDestroyer ENDP

PlacePlayerSweeper PROC

	call GetMouseCoordinates
	call TranslateRowCoordinate
	call TranslateColumnCoordinate

	cmp mouseClickDirection, 1
	je VerticalSweeperPlacement

	cmp mouseClickDirection, 2
	je HorizontalSweeperPlacement

	VerticalSweeperPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 2
	PVS:

		mov al, 83
		mov [edi], al
		add edi, 22

	loop PVS

	jmp SweeperPlaced

	HorizontalSweeperPlacement:

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 2
	PHS:

		mov al, 83
		mov [edi], al
		inc edi

	loop PHS

	SweeperPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	ret
PlacePlayerSweeper ENDP

PlaceComputerShips PROC

	call PlaceComputerCarrier
	call PlaceComputerBattleship
	call PlaceComputerSubmarine
	call PlaceComputerDestroyer
	call PlaceComputerSweeper

	ret
PlaceComputerShips ENDP

PlaceComputerCarrier PROC
	mov dl, 30
	mov dh, 30
	call gotoxy
	mov lowerbound, 1
	mov upperbound, 2

	call BetterRandomNumber
	cmp al, 1
	je vertical 

	horizontal:
		mov esi, OFFSET ComputerCarrierShipArray
		movzx ebx, RowMax						;1st row coorinate
		mov upperbound, ebx
		movzx ebx, RowMin
		mov lowerbound, ebx
		call BetterRandomNumber
		mov currentRow, al						;dh = row coordinate
		mov [esi], al
		inc esi

		mov bl, ComputerCarrierHealth		;1st column coordinate
		mov bh, ColMax
		sub bh, bl
		movzx ebx, bh
		mov upperbound, ebx
		movzx ebx, ColMin
		mov lowerbound, ebx
		call BetterRandomOdd
		mov currentCol, al
		mov [esi], al

		movzx ecx, ComputerCarrierHealth
		dec ecx
		call FillArrayVertically
			
		jmp return

	vertical:
		mov esi, OFFSET ComputerCarrierShipArray

		mov bl, ComputerCarrierHealth		;1st row coorinate
		mov bh, RowMax		
		sub bh, bl
		movzx ebx, bh				
		mov upperbound, ebx
		movzx ebx, RowMin
		mov lowerbound, ebx
		call BetterRandomNumber
		mov currentRow, al							;dh = row coordinate
		mov [esi], al
		inc esi

		
		movzx ebx, ColMax			;1st column coordinate
		mov upperbound, ebx
		movzx ebx, ColMin
		mov lowerbound, ebx
		call BetterRandomOdd
		mov currentCol, al					;dl=col coordinate
		mov [esi], al

		movzx ecx, ComputerCarrierHealth
		dec ecx
		call FillArrayHorizontally

	
	return:
	mov esi, OFFSET ComputerCarrierShipArray
	mov ecx, lengthof ComputerCarrierShipArray
	
	mov eax, 0
	loopx:
	mov al, [esi]
	call Writeint
	inc esi
	loop loopx
	ret
PlaceComputerCarrier ENDP

PlaceComputerBattleship PROC

	ret
PlaceComputerBattleship ENDP

PlaceComputerSubmarine PROC

	ret
PlaceComputerSubmarine ENDP

PlaceComputerDestroyer PROC

	ret
PlaceComputerDestroyer ENDP

PlaceComputerSweeper PROC

	ret
PlaceComputerSweeper ENDP

CheckCollision PROC
ret 
CheckCollision ENDP
;-----------------------------------------------------
; BetterRandomNumber
; produces a random int with lower and upper bound
; Receives: upperbound, lowerbound
; Returns: EAX = the random int
;-----------------------------------------------------
BetterRandomNumber proc

	mov ebx, lowerbound
	mov eax, upperbound
	sub eax, ebx
	inc eax
	call RandomRange
	add eax, ebx

ret
BetterRandomNumber endp

;-----------------------------------------------------
; BetterRandomOdd
; produces a random odd int with lower and upper bound
; Receives: upperbound, lowerbound
; Returns: EAX = the random int
;-----------------------------------------------------

BetterRandomOdd proc
	
	mov ebx, lowerbound
	mov eax, upperbound
	sub eax, ebx
	inc eax
	call RandomRange
	add eax, ebx

	mov edx, eax
	mov bl, 2
	div bl
	cmp ah, 0
	jne write
	cmp edx, upperbound
	je decrement
	inc edx
	jmp write

	decrement:
	dec edx

	write:
		mov eax, edx

ret
BetterRandomOdd endp
FillArrayVertically PROC
	mov dh, currentRow
	mov dl, currentCol

	FillArray:
		inc esi
		inc dh
		mov [esi], dh
		mov [edi], dh
		inc esi
		inc edi
		mov [esi], dl
		mov [edi], dl
	loop FillArray

ret
FillArrayVertically ENDP
FillArrayHorizontally PROC
mov dh, currentRow
mov dl, currentCol

	FillArray:
		inc edi
		inc esi
		add dl, 2
		mov [esi], dh
		mov [edi], dh
		inc esi
		inc edi
		mov [esi], dl
		mov [edi], dl
	loop FillArray

ret
FillArrayHorizontally ENDP
END main
