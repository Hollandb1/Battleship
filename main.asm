INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data

;=====================
;=== BATTLESHIP ART ==
;=====================

BattleshipASCIIRow1 BYTE " _  _ ______    __ __   ___ _ ", 0
BattleshipASCIIRow2 BYTE "|_)|_| |  | |  |_ (_ |_| | |_)", 0
BattleshipASCIIRow3 BYTE "|_)| | |  | |__|____)| |_|_|", 0


;=====================
;======= Ships =======
;=====================

BattleShip BYTE "BattleShip(4)		", 0
Carrier BYTE "Carrier(5)		", 0
Submarine BYTE "Submarine(3)		", 0
Destroyer BYTE "Detroyer(3)		", 0
Sweeper BYTE "Sweeper(2)		", 0

;=====================
;==== PLAYER MAP =====
;=====================

PlayerMapColumnCoord BYTE "#: |A|B|C|D|E|F|G|H|I|J|", 0
PlayerMapRow0 BYTE "0: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow1 BYTE "1: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow2 BYTE "2: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow3 BYTE "3: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow4 BYTE "4: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow5 BYTE "5: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow6 BYTE "6: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow7 BYTE "7: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow8 BYTE "8: |_|_|_|_|_|_|_|_|_|_|", 0
PlayerMapRow9 BYTE "9: |_|_|_|_|_|_|_|_|_|_|", 0

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

ComputerMapColumnCoord BYTE "#: |A|B|C|D|E|F|G|H|I|J|", 0
ComputerMapRow0 BYTE "0: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow1 BYTE "1: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow2 BYTE "2: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow3 BYTE "3: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow4 BYTE "4: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow5 BYTE "5: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow6 BYTE "6: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow7 BYTE "7: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow8 BYTE "8: |_|_|_|_|_|_|_|_|_|_|", 0
ComputerMapRow9 BYTE "9: |_|_|_|_|_|_|_|_|_|_|", 0

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
;= GAME UI MECHANICS =
;=====================

BeginText BYTE "Welcome to BattleShip! Press OK to begin.", 0

PlayerText BYTE "Player", 0
ComputerText BYTE "Computer", 0

ShipPlacementDirection BYTE "Would you like to place this ship vertical(0) or horizontal(1)? ", 0
Clear BYTE "															", 0
ShipPlacementVertical BYTE "On the Player Map, select the topmost position for your ship...", 0
ShipPlacementHorizontal BYTE "On the Player Map, select the leftmost positoin for your ship...", 0
ShipPlacementError BYTE "Invalid placement. Please try again."

TotalHealthText BYTE "Total Health: ", 0
ShipsRemainingText BYTE "Ships Remaining: ", 0

PlayerTurnMessage BYTE "Your turn has resulted in a: ", 0
ComputerMoveMessage BYTE "The computer's turn has resulted in a: ", 0

.code
main PROC

	call Randomize
	call GeneratePlayerMap
	call GenerateComputerMap
	call GenerateUIMechancis
	call BeginGame
	call PlaceShips

INVOKE ExitProcess, 0
main ENDP

GenerateGameTitle PROC

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

	ret
GenerateGameTitle ENDP

GeneratePlayerMap PROC

	call GenerateGameTitle

	mov dl, 20
	mov dh, 5
	call GoToXY

	mov edx, OFFSET PlayerMapColumnCoord
	call WriteString

	mov dl, 20
	mov dh, 6
	call GoToXY

	mov edx, OFFSET PlayerMapRow0
	call WriteString

	mov dl, 20
	mov dh, 7
	call GoToXY

	mov edx, OFFSET PlayerMapRow1
	call WriteString

	mov dl, 20
	mov dh, 8
	call GoToXY

	mov edx, OFFSET PlayerMapRow2
	call WriteString

	mov dl, 20
	mov dh, 9
	call GoToXY

	mov edx, OFFSET PlayerMapRow3
	call WriteString

	mov dl, 20
	mov dh, 10
	call GoToXY

	mov edx, OFFSET PlayerMapRow4
	call WriteString

	mov dl, 20
	mov dh, 11
	call GoToXY

	mov edx, OFFSET PlayerMapRow5
	call WriteString

	mov dl, 20
	mov dh, 12
	call GoToXY

	mov edx, OFFSET PlayerMapRow6
	call WriteString

	mov dl, 20
	mov dh, 13
	call GoToXY

	mov edx, OFFSET PlayerMapRow7
	call WriteString

	mov dl, 20
	mov dh, 14
	call GoToXY

	mov edx, OFFSET PlayerMapRow8
	call WriteString

	mov dl, 20
	mov dh, 15
	call GoToXY

	mov edx, OFFSET PlayerMapRow9
	call WriteString

	mov dl, 0
	mov dh, 0
	call GoToXY

	ret
GeneratePlayerMap ENDP

GenerateComputerMap PROC

	mov dl, 60
	mov dh, 5
	call GoToXY

	mov edx, OFFSET PlayerMapColumnCoord
	call WriteString

	mov dl, 60
	mov dh, 6
	call GoToXY

	mov edx, OFFSET PlayerMapRow0
	call WriteString

	mov dl, 60
	mov dh, 7
	call GoToXY

	mov edx, OFFSET PlayerMapRow1
	call WriteString

	mov dl, 60
	mov dh, 8
	call GoToXY

	mov edx, OFFSET PlayerMapRow2
	call WriteString

	mov dl, 60
	mov dh, 9
	call GoToXY

	mov edx, OFFSET PlayerMapRow3
	call WriteString

	mov dl, 60
	mov dh, 10
	call GoToXY

	mov edx, OFFSET PlayerMapRow4
	call WriteString

	mov dl, 60
	mov dh, 11
	call GoToXY

	mov edx, OFFSET PlayerMapRow5
	call WriteString

	mov dl, 60
	mov dh, 12
	call GoToXY

	mov edx, OFFSET PlayerMapRow6
	call WriteString

	mov dl, 60
	mov dh, 13
	call GoToXY

	mov edx, OFFSET PlayerMapRow7
	call WriteString

	mov dl, 60
	mov dh, 14
	call GoToXY

	mov edx, OFFSET PlayerMapRow8
	call WriteString

	mov dl, 60
	mov dh, 15
	call GoToXY

	mov edx, OFFSET PlayerMapRow9
	call WriteString

	mov dl, 0
	mov dh, 0
	call GoToXY

	ret
GenerateComputerMap ENDP

GenerateUIMechancis PROC

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
GenerateUIMechancis ENDP

BeginGame PROC

	mov ebx, 0
	mov edx, OFFSET BeginText
	mov eax, 2000
	call Delay
	call MsgBox

	ret
BeginGame ENDP

PlaceShips PROC

	mov ebx, OFFSET BattleShip
	mov cl, PlayerBattleShipHealth
	call AskPlacement
	mov ebx, OFFSET Carrier
	mov cl, PlayerCarrierHealth
	call AskPlacement

ret
PlaceShips ENDP

AskPlacement PROC
mov eax, 0
	Ask:
		mov dl, 0
		mov dh, 25
		call GoToXY

		mov edx, ebx
		call WriteString
		call crlf
		mov edx, OFFSET Clear
		call WriteString
		call crlf
		call WriteString

		mov dl, 0
		mov dh, 26
		call GoToXY
		mov edx, OFFSET ShipPlacementDirection
		call WriteString
		call ReadInt
		
		cmp eax, 0
		je vertical
		cmp eax, 1
		je horizontal
		jmp Ask

		Error:
			mov edx, OFFSET ShipPlacementError
			call WriteString

		horizontal:
			mov edx, OFFSET ShipPlacementHorizontal
			call WriteString
			call PlaceHorizontal
			jmp return
		vertical:
			mov edx, OFFSET ShipPlacementVertical
			call WriteString
return:
ret
AskPlacement ENDP

PlaceHorizontal PROC

check:

jmp check

return:
ret
PlaceHorizontal ENDP

END main
