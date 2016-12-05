INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data

;=====================
;== BATTLESHIP ASCII =
;=====================

BattleshipTitle1 BYTE "  ____    _  _____ _____ _     _____ ____  _   _ ___ ____   ", 0
BattleshipTitle2 BYTE " | __ )  / \|_   _|_   _| |   | ____/ ___|| | | |_ _|  _ \  ", 0
BattleshipTitle3 BYTE " |  _ \ / _ \ | |   | | | |   |  _| \___ \| |_| || || |_) | ", 0
BattleshipTitle4 BYTE " | |_) / ___ \| |   | | | |___| |___ ___) |  _  || ||  __/  ", 0
BattleshipTitle5 BYTE " |____/_/   \_\_|   |_| |_____|_____|____/|_| |_|___|_|     ", 0

 Carrier1 BYTE "                                     |__", 0
 Carrier2 BYTE "                                     |\/", 0
 Carrier3 BYTE "                                     ---", 0
 Carrier4 BYTE "                                     / | [", 0
 Carrier5 BYTE "                              !      | |||", 0
 Carrier6 BYTE "                            _/|     _/|-++'", 0
 Carrier7 BYTE "                        +  +--|    |--|--|_ |-", 0
 Carrier8 BYTE "                     { /|__|  |/\__|  |--- |||__/", 0
 Carrier9 BYTE "                    +---------------___[}-_===_.'____                 /\", 0
Carrier10 BYTE "                ____`-' ||___-{]_| _[}-  |     |_[___\==--            \/   _", 0
Carrier11 BYTE " __..._____--==/___]_|__|_____________________________[___\==--____,------' .7", 0
Carrier12 BYTE "|                                                                     BB-61/", 0
Carrier13 BYTE " \_________________________________________________________________________|", 0

author1 BYTE "Created By:"
author2 BYTE "Brandie Holland", 0
author3 BYTE "Andrew Ryan", 0
author4 BYTE "Jiajun Chen", 0

Victory1 BYTE " __     _____ ____ _____ ___  ______   ___ ", 0
Victory2 BYTE " \ \   / /_ _/ ___|_   _/ _ \|  _ \ \ / / |", 0
Victory3 BYTE "  \ \ / / | | |     | || | | | |_) \ V /| |", 0
Victory4 BYTE "   \ V /  | | |___  | || |_| |  _ < | | |_|", 0
Victory5 BYTE "    \_/  |___\____| |_| \___/|_| \_\|_| (_)", 0

Defeat1 BYTE "  ____  _____ _____ _____    _  _____ _ ", 0
Defeat2 BYTE " |  _ \| ____|  ___| ____|  / \|_   _| |", 0
Defeat3 BYTE " | | | |  _| | |_  |  _|   / _ \ | | | |", 0
Defeat4 BYTE " | |_| | |___|  _| | |___ / ___ \| | |_|", 0
Defeat5 BYTE " |____/|_____|_|   |_____/_/   \_\_| (_)", 0

BattleshipASCIIRow1 BYTE " _  _ ______    __ __   ___ _ ", 0
BattleshipASCIIRow2 BYTE "|_)|_| |  | |  |_ (_ |_| | |_)", 0
BattleshipASCIIRow3 BYTE "|_)| | |  | |__|____)| |_|_|", 0

 explosion1 BYTE "                               ________________", 0
 explosion2 BYTE "                          ____/ (  (    )   )  \___", 0
 explosion3 BYTE "                         /( (  (  )   _    ))  )   )\", 0
 explosion4 BYTE "                       ((     (   )(    )  )   (   )  )", 0
 explosion5 BYTE "                     ((/  ( _(   )   (   _) ) (  () )  )", 0
 explosion6 BYTE "                    ( (  ( (_)   ((    (   )  .((_ ) .  )_", 0
 explosion7 BYTE "                   ( (  )    (      (  )    )   ) . ) (   )", 0
 explosion8 BYTE "                  (  (   (  (   ) (  _  ( _) ).  ) . ) ) ( )", 0
 explosion9 BYTE "                  ( (  (   ) (  )   (  ))     ) _)(   )  )  )", 0
explosion10 BYTE "                 ( (  ( \ ) (    (_  ( ) ( )  )   ) )  )) ( )", 0
explosion11 BYTE "                  (  (   (  (   (_ ( ) ( _    )  ) (  )  )   )", 0
explosion12 BYTE "                 ( (  ( (  (  )     (_  )  ) )  _)   ) _( ( )", 0
explosion13 BYTE "                  ((  (   )(    (     _    )   _) _(_ (  (_ )", 0
explosion14 BYTE "                   (_((__(_(__(( ( ( |  ) ) ) )_))__))_)___)", 0
explosion15 BYTE "                   ((__)        \\||lll|l||///          \_))", 0
explosion16 BYTE "                            (   /(/ (  )  ) )\   )", 0
explosion17 BYTE "                          (    ( ( ( | | ) ) )\   )", 0
explosion18 BYTE "                           (   /(| / ( )) ) ) )) )", 0
explosion19 BYTE "                         (     ( ((((_(|)_)))))     )", 0
explosion20 BYTE "                          (      ||\(|(|)|/||     )", 0
explosion21 BYTE "                        (        |(||(||)||||        )", 0
explosion22 BYTE "                          (     //|/l|||)|\\ \     )", 0
explosion23 BYTE "                        (/ / //  /|//||||\\  \ \  \ _)", 0
explosion24 BYTE "             _      _      _      _      _      _      _      _", 0
explosion25 BYTE "             )`'-.,_)`'-.,_)`'-.,_)`'-.,_)`'-.,_)`'-.,_)`'-.,_)`'-.,_", 0

PlayerShipSunkMessage BYTE "Player ship sunk!", 0
ComputerShipSunkMessage BYTE "Computer ship sunk!", 0

;=====================
;===== DIRECTIONS ====
;=====================

directionsMessage BYTE "Directions:", 0
clearLine BYTE "                                                                                                  ", 0
Line BYTE "|", 0

intro1 BYTE "Welcome to BATTLESHIP!", 0
intro2 BYTE "You are approaching the enemy, ready to start a naval battle. You will be assigned a grid.", 0
intro3 BYTE "This is used to place your ships for battle against the enemy.", 0
intro4 BYTE "You have five ships: Carrier, Battleship, Submarine, Destroyer, Sweeper.", 0
intro5 BYTE "Each ship uses a specified size on the grid, so plan your placements accordingly.", 0
intro6 BYTE "You will have view of another grid, the computer grid.", 0
intro7 BYTE "This will only show where you have struck in enemy waters.", 0
intro8 BYTE "The goal of the game is to sink every ship of your enemy.", 0
intro9 BYTE "Sink all five? You win. You don't? You lose. Good luck Captain!", 0
intro10 BYTE "Press any key to continue... ", 0

shipPlacementDirection1 BYTE "Ship Placement", 0
shipPlacementDirection2 BYTE "To place a ship, click a coordinate on the grid.", 0
shipPlacementDirection3 BYTE "Left Click: Vertical Placement	Right Click: Horizontal Placement", 0
shipPlacementDirection4 BYTE "All ship placements are final, so plan ahead Captain!", 0
shipToPlace BYTE "Ship to place: ", 0
ShipPlacementError BYTE "Invalid placement. Please try again."
ShipPlaced BYTE "Ship has been placed", 0

playerShipPlacementComplete BYTE "All ships have been placed. Prepare for battle!", 0
computerShipPlacementComplete BYTE "The computer is ready for battle.", 0

playerTurnDirection1 BYTE "Time to attack!", 0
playerTurnDirection2 BYTE "To attack, click a coordinate on the computer grid."

playerTurnResult BYTE "Player attack resulted in a ", 0
computerTurnResult BYTE "Computer attack resulted in a ", 0
hitResult BYTE "hit!", 0
missResult BYTE "miss.", 0

;=====================
;======= SHIPS =======
;=====================

BattleShip BYTE "BattleShip(4)...		", 0
Carrier BYTE "Carrier(5)...		", 0
Submarine BYTE "Submarine(3)...		", 0
Destroyer BYTE "Detroyer(3)...		", 0
Sweeper BYTE "Sweeper(2)...		", 0

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
PlayerSubmarineHealth BYTE 3		; U
PlayerDestroyerHealth BYTE 3		; D
PlayerSweeperHealth BYTE 2			; S

ShipsPlaced BYTE 0					; Increments every time a ship is placed

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
ComputerSubmarineHealth BYTE 3		; U
ComputerDestroyerHealth BYTE 3		; D
ComputerSweeperHealth BYTE 2		; S

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
CurrentShipHealth BYTE ?
CurrentShipLocation DWORD ?
Collision BYTE "Collision!",0
Matches BYTE 0

;Ship arrays row, col, row, col...
ComputerCarrierShipArray BYTE 10 DUP (0)
ComputerBattleShipShipArray BYTE 8 DUP (0)
ComputerSubmarineShipArray BYTE 6 DUP (0)
ComputerDestroyerShipArray BYTE 6 DUP (0)
ComputerSweeperShipArray BYTE 4 DUP (0)

;=====================
;== Hit Detection  ===
;=====================

UnderScore BYTE "_", 0
Hit BYTE 'X', 0
Miss BYTE 'O', 0

;=====================
;=== UI MECHANICS ====
;=====================

BeginText BYTE "Welcome to BattleShip! Press OK to begin.", 0

PlayerText BYTE "Player", 0
ComputerText BYTE "Computer", 0

ShipPlacementTitle BYTE "Ship Placement", 0
ShipPlacementDirection BYTE "To place a ship, click a coordinate on the map", 0
ShipPlacementVertical BYTE "Vertical Placement: Left Click", 0
ShipPlacementHorizontal BYTE "Horizontal Placement: Right Click", 0

TotalHealthText BYTE "Total Health: ", 0
ShipsRemainingText BYTE "   Ships Remaining: ", 0

;=====================
;=== Computer Turn ===
;=====================

InitialHit BYTE 2 DUP (?)		;Coordinates of initial hit
LastHit BYTE 2 DUP (0)			;Coordinates of last hit
LastTurnOutcome BYTE 0			;0 miss, 1 initial hit, 2 hit streak
CurrentDirection BYTE ?
ComputerTarget BYTE ?
HitStreak BYTE 0

.code
main PROC

	call Randomize

	call GenerateSplashScreen
	call GenerateIntroductionScreen
	call GenerateGameTitle
	call GenerateMaps
	call GenerateUIMechanics

	mov edx, OFFSET ShipPlacementTitle
	call WriteString
	call Crlf

	call PlacePlayerShips
	call PlaceComputerShips
	TurnRotation:

	call PlayerTurn
	call ComputerTurn

	mov eax, 0

	cmp al, ComputerHealth
	je PlayerWin

	cmp al, PlayerHealth
	je ComputerWin

	jmp AnotherTurn

	PlayerWin:
	call PlayerWin
	jmp GameOver
	
	ComputerWin:
	call ComputerWin
	jmp GameOver
	
	AnotherTurn:
	jmp TurnRotation
	
	GameOver:

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

	cmp InputRecord.MouseEvent.dwButtonState, 2
	je HandleRightClick

	cmp InputRecord.MouseEvent.dwButtonState, 1
	jne skip
	je HandleLeftClick

	HandleLeftClick:

	mov ax, InputRecord.MouseEvent.dwMousePosition.X

	mov dx, 0
	mov bx, 2
	div bx
	cmp dx, 0
	je skip

	mov ax, InputRecord.MouseEvent.dwMousePosition.X
	mov bx, InputRecord.MouseEvent.dwMousePosition.Y

	mov mouseClickDirection, 1
	mov rowCoordinate, bx
	mov columnCoordinate, ax

	jmp Complete

	HandleRightClick:

	mov ax, InputRecord.MouseEvent.dwMousePosition.X

	mov dx, 0
	mov bx, 2
	div bx
	cmp dx, 0
	je skip

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

	ret
TranslateRowCoordinate ENDP

TranslateColumnCoordinate PROC

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

	ret
TranslateColumnCoordinate ENDP

GenerateSplashScreen PROC

	mov eax, yellow
	call SetTextColor

	mov dl, 28
	mov dh, 3
	call GoToXy

	mov edx, OFFSET BattleshipTitle1
	call WriteString

	mov dl, 28
	mov dh, 4
	call GoToXy

	mov edx, OFFSET BattleshipTitle2
	call WriteString

	mov dl, 28
	mov dh, 5
	call GoToXy

	mov edx, OFFSET BattleshipTitle3
	call WriteString

	mov dl, 28
	mov dh, 6
	call GoToXy

	mov edx, OFFSET BattleshipTitle4
	call WriteString

	mov dl, 28
	mov dh, 7
	call GoToXy

	mov edx, OFFSET BattleshipTitle5
	call WriteString

	mov eax, gray
	call SetTextColor

	mov dl, 18
	mov dh, 12
	call GoToXY

	mov edx, OFFSET Carrier1
	call WriteString

	mov dl, 18
	mov dh, 13
	call GoToXY

	mov edx, OFFSET Carrier2
	call WriteString

	mov dl, 18
	mov dh, 14
	call GoToXY

	mov edx, OFFSET Carrier3
	call WriteString

	mov dl, 18
	mov dh, 15
	call GoToXY

	mov edx, OFFSET Carrier4
	call WriteString

	mov dl, 18
	mov dh, 16
	call GoToXY

	mov edx, OFFSET Carrier5
	call WriteString

	mov dl, 18
	mov dh, 17
	call GoToXY

	mov edx, OFFSET Carrier6
	call WriteString

	mov dl, 18
	mov dh, 18
	call GoToXY

	mov edx, OFFSET Carrier7
	call WriteString

	mov dl, 18
	mov dh, 19
	call GoToXY

	mov edx, OFFSET Carrier8
	call WriteString

	mov dl, 18
	mov dh, 20
	call GoToXY

	mov edx, OFFSET Carrier9
	call WriteString

	mov dl, 18
	mov dh, 21
	call GoToXY

	mov edx, OFFSET Carrier10
	call WriteString

	mov dl, 18
	mov dh, 22
	call GoToXY

	mov edx, OFFSET Carrier11
	call WriteString

	mov dl, 18
	mov dh, 23
	call GoToXY

	mov edx, OFFSET Carrier12
	call WriteString

	mov dl, 18
	mov dh, 24
	call GoToXY

	mov edx, OFFSET Carrier13
	call WriteString

	mov eax, white
	call SetTextColor

	mov eax, 3000
	call Delay

	call Clrscr

	ret
GenerateSplashScreen ENDP

GenerateIntroductionScreen PROC

	mov dl, 42
	mov dh, 6
	call GoToXY

	mov edx, OFFSET intro1
	call WriteString

	mov dl, 15
	mov dh, 8
	call GoToXY

	mov edx, OFFSET intro2
	call WriteString

	mov dl, 25
	mov dh, 9
	call GoToXY

	mov edx, OFFSET intro3
	call WriteString

	mov dl, 22
	mov dh, 10
	call GoToXY

	mov edx, OFFSET intro4
	call WriteString

	mov dl, 16
	mov dh, 11
	call GoToXY

	mov edx, OFFSET intro5
	call WriteString

	mov dl, 28
	mov dh, 12
	call GoToXY

	mov edx, OFFSET intro6
	call WriteString

	mov dl, 25
	mov dh, 13
	call GoToXY

	mov edx, OFFSET intro7
	call WriteString

	mov dl, 25
	mov dh, 14
	call GoToXY

	mov edx, OFFSET intro8
	call WriteString

	mov dl, 23
	mov dh, 16
	call GoToXY

	mov edx, OFFSET intro9
	call WriteString

	mov dh, 18
	mov dl, 40
	call GoToXY

	mov edx, OFFSET intro10
	call WriteString
	call ReadChar

	call Clrscr

	ret
GenerateIntroductionScreen ENDP

GenerateGameTitle PROC

	mov eax, white
	call SetTextColor

	mov dl, 38
	mov dh, 0
	call GoToXY

	mov edx, OFFSET BattleshipASCIIRow1
	call WriteString

	mov dl, 38
	mov dh, 1
	call GoToXY

	mov edx, OFFSET BattleshipASCIIRow2
	call WriteString

	mov dl, 38
	mov dh, 2
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

	mov eax, lightCyan
	call SetTextColor

	mov ecx, 22
	PrintPlayerColumnCoordinates:

		mov eax, [esi]
		call WriteChar

		inc esi

	loop PrintPlayerColumnCoordinates

	mov dl, 20
	mov dh, 6
	call GoToXY

	mov ecx, 10

	CreatePlayerMap:
		push ecx
		mov ecx, 22
		PrintPlayerRow:
			mov al, [esi]

			; Missed Character

			cmp al, 79
			jne CheckPlayerHit
			mov eax, lightGreen
			call SetTextColor
			mov eax, 79
			call WriteChar
			jmp FoundPlayerMapCharacter

			CheckPlayerHit:

			cmp al, 88
			jne CheckCarrier
			mov eax, lightRed
			call SetTextColor
			mov eax, 88
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

			cmp al, 79
			jne CheckComputerHit
			mov eax, lightGreen
			call SetTextColor
			mov eax, 79
			call WriteChar
			jmp FoundComputerMapCharacter

			CheckComputerHit:

			cmp al, 88
			jne PrintComputerMapCharacter
			mov eax, lightRed
			call SetTextColor
			mov eax, 88
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

	mov dl, 28
	mov dh, 17
	call GoToXY

	mov edx, OFFSET PlayerText
	call WriteString

	mov dl, 68
	mov dh, 17
	call GoToXY

	mov edx, OFFSET ComputerText
	call WriteString

	mov dl, 20
	mov dh, 19
	call GoToXY

	mov edx, OFFSET TotalHealthText
	call WriteString
	mov al, PlayerHealth
	call WriteDec

	mov dl, 60
	mov dh, 19
	call GoToXY

	mov edx, OFFSET TotalHealthText
	call WriteString
	mov al, ComputerHealth
	call WriteDec

	mov dl, 17
	mov dh, 20
	call GoToXY

	mov edx, OFFSET ShipsRemainingText
	call WriteString
	call CalculatePlayerShipsRemaining

	mov dl, 57
	mov dh, 20
	call GoToXY

	mov edx, OFFSET ShipsRemainingText
	call WriteString
	call CalculateComputerShipsRemaining
	
	mov dl, 20
	mov dh, 22
	call GoToXY
	mov eax, lightmagenta
	call SetTextColor
	mov edx, OFFSET directionsMessage
	call WriteString
	mov eax, white
	call SetTextColor
	
	mov dl, 0
	mov dh, 0
	call GoToXY

	;mov dh, 0
	;mov dl, 85
	;mov eax, '|'
	;mov ecx, 30
	;Separate:
	;	call GoToXY
	;	call WriteChar
	;	inc dh
	;	loop Separate
	ret
GenerateUIMechanics ENDP

ClearDirections PROC
	mov dl, 20
	mov dh, 24
	call GoToXY
	mov edx, OFFSET clearLine
	call WriteString
	mov dl, 20
	mov dh, 25
	call GoToXY
	mov edx, OFFSET clearLine
	call WriteString
	mov dl, 20
	mov dh, 26
	call GoToXY
	mov edx, OFFSET clearLine
	call WriteString
	mov dl, 20
	mov dh, 27
	call GoToXY
	mov edx, OFFSET clearLine
	call WriteString
	mov dl, 20
	mov dh, 28
	call GoToXY
	mov edx, OFFSET clearLine
	call WriteString
	mov edx, 0
	call GoToXY
	ret
ClearDirections ENDP

CalculatePlayerShipsRemaining PROC

	mov ebx, 0

	mov al, PlayerCarrierHealth
	cmp al, 0
	je PBH
	inc ebx

	PBH:

	mov al, PlayerBattleshipHealth
	cmp al, 0
	je PUH
	inc ebx

	PUH:

	mov al, PlayerBattleshipHealth
	cmp al, 0
	je PDH
	inc ebx

	PDH:

	mov al, PlayerBattleshipHealth
	cmp al, 0
	je PSH
	inc ebx

	PSH:

	mov al, PlayerSweeperHealth
	cmp al, 0
	je PSRC
	inc ebx

	PSRC:

	cmp ebx, 1
	jg PSRYellow

	mov eax, red
	call SetTextColor
	mov eax, ebx
	call WriteDec
	jmp PSComplete

	PSRYellow:

	cmp ebx, 3
	jg PSRGreen

	mov eax, yellow
	call SetTextColor
	mov eax, ebx
	call WriteDec
	jmp PSComplete

	PSRGreen:

	mov eax, lightgreen
	call SetTextColor
	mov eax, ebx
	call WriteDec

	PSComplete:

	mov eax, white
	call SetTextColor

	ret
CalculatePlayerShipsRemaining ENDP

CalculateComputerShipsRemaining PROC

	mov ebx, 0

	mov al, ComputerCarrierHealth
	cmp al, 0
	je CBH
	inc ebx

	CBH:

	mov al, ComputerBattleshipHealth
	cmp al, 0
	je CUH
	inc ebx

	CUH:

	mov al, ComputerBattleshipHealth
	cmp al, 0
	je CDH
	inc ebx

	CDH:

	mov al, ComputerBattleshipHealth
	cmp al, 0
	je CSH
	inc ebx

	CSH:

	mov al, ComputerSweeperHealth
	cmp al, 0
	je CSRC
	inc ebx

	CSRC:

	cmp ebx, 1
	jg CSRYellow

	mov eax, red
	call SetTextColor
	mov eax, ebx
	call WriteDec
	jmp CSComplete

	CSRYellow:

	cmp ebx, 3
	jg CSRGreen

	mov eax, yellow
	call SetTextColor
	mov eax, ebx
	call WriteDec
	jmp CSComplete

	CSRGreen:

	mov eax, lightgreen
	call SetTextColor
	mov eax, ebx
	call WriteDec

	CSComplete:

	mov eax, white
	call SetTextColor

	ret
CalculateComputerShipsRemaining ENDP

PlacePlayerShips PROC

	mov eax, 0

	mov al, ShipsPlaced

	cmp al, 0
	je PlaceCarrier

	cmp al, 1
	je PlaceBattleship

	cmp al, 2
	je PlaceSubmarine

	cmp al, 3
	je PlaceDestroyer

	cmp al, 4
	je PlaceSweeper
	jge AllShipsPlaced

	PlaceCarrier:

	mov dl, 20
	mov dh, 23
	call GoToXY

	mov edx, OFFSET shipPlacementDirection1
	call WriteString

	mov dl, 20
	mov dh, 24
	call GoToXY

	mov edx, OFFSET shipPlacementDirection2
	call WriteString

	mov dl, 20
	mov dh, 25
	call GoToXY

	mov edx, OFFSET shipPlacementDirection3
	call WriteString

	mov dl, 20
	mov dh, 26
	call GoToXY

	mov edx, OFFSET shipPlacementDirection4
	call WriteString

	mov dl, 20
	mov dh, 27
	call GoToXY

	mov edx, OFFSET shipToPlace
	call WriteString

	mov edx, OFFSET Carrier
	call WriteString

	call PlacePlayerCarrier

	call ClearDirections

	PlaceBattleship:

	mov dl, 20
	mov dh, 23
	call GoToXY

	mov edx, OFFSET shipPlacementDirection1
	call WriteString

	mov dl, 20
	mov dh, 24
	call GoToXY

	mov edx, OFFSET shipPlacementDirection2
	call WriteString

	mov dl, 20
	mov dh, 25
	call GoToXY

	mov edx, OFFSET shipPlacementDirection3
	call WriteString

	mov dl, 20
	mov dh, 26
	call GoToXY

	mov edx, OFFSET shipPlacementDirection4
	call WriteString

	mov dl, 20
	mov dh, 27
	call GoToXY

	mov edx, OFFSET shipToPlace
	call WriteString

	mov edx, OFFSET Battleship
	call WriteString

	call PlacePlayerBattleship

	call ClearDirections

	PlaceSubmarine:

	mov dl, 20
	mov dh, 23
	call GoToXY

	mov edx, OFFSET shipPlacementDirection1
	call WriteString

	mov dl, 20
	mov dh, 24
	call GoToXY

	mov edx, OFFSET shipPlacementDirection2
	call WriteString

	mov dl, 20
	mov dh, 25
	call GoToXY

	mov edx, OFFSET shipPlacementDirection3
	call WriteString

	mov dl, 20
	mov dh, 26
	call GoToXY

	mov edx, OFFSET shipPlacementDirection4
	call WriteString

	mov dl, 20
	mov dh, 27
	call GoToXY

	mov edx, OFFSET shipToPlace
	call WriteString

	mov edx, OFFSET Submarine
	call WriteString

	call PlacePlayerSubmarine

	call ClearDirections

	PlaceDestroyer:

	mov dl, 20
	mov dh, 23
	call GoToXY

	mov edx, OFFSET shipPlacementDirection1
	call WriteString

	mov dl, 20
	mov dh, 24
	call GoToXY

	mov edx, OFFSET shipPlacementDirection2
	call WriteString

	mov dl, 20
	mov dh, 25
	call GoToXY

	mov edx, OFFSET shipPlacementDirection3
	call WriteString

	mov dl, 20
	mov dh, 26
	call GoToXY

	mov edx, OFFSET shipPlacementDirection4
	call WriteString

	mov dl, 20
	mov dh, 27
	call GoToXY

	mov edx, OFFSET shipToPlace
	call WriteString

	mov edx, OFFSET Destroyer
	call WriteString

	call PlacePlayerDestroyer

	call ClearDirections

	PlaceSweeper:

	mov dl, 20
	mov dh, 23
	call GoToXY

	mov edx, OFFSET shipPlacementDirection1
	call WriteString

	mov dl, 20
	mov dh, 24
	call GoToXY

	mov edx, OFFSET shipPlacementDirection2
	call WriteString

	mov dl, 20
	mov dh, 25
	call GoToXY

	mov edx, OFFSET shipPlacementDirection3
	call WriteString

	mov dl, 20
	mov dh, 26
	call GoToXY

	mov edx, OFFSET shipPlacementDirection4
	call WriteString

	mov dl, 20
	mov dh, 27
	call GoToXY

	mov edx, OFFSET shipToPlace
	call WriteString

	mov edx, OFFSET Sweeper
	call WriteString

	call PlacePlayerSweeper

	call ClearDirections

	AllShipsPlaced:

	mov dl, 20
	mov dh, 23
	call GoToXY

	mov edx, OFFSET playerShipPlacementComplete
	call WriteString

	mov eax, 3000
	call Delay

	call ClearDirections

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
		add edi, 2

	loop PHC

	CarrierPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	mov eax, 0

	mov al, ShipsPlaced
	inc al
	mov ShipsPlaced, al

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

	mov eax, 4
	call CheckVerticalShipPlacementCollision

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

	mov eax, 4
	call CheckHorizontalShipPlacementCollision

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 4

	PHB:

		mov al, 66
		mov [edi], al
		add edi, 2

	loop PHB

	BattleshipPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	mov eax, 0

	mov al, ShipsPlaced
	inc al
	mov ShipsPlaced, al

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

	mov eax, 3
	call CheckVerticalShipPlacementCollision

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

	mov eax, 3
	call CheckHorizontalShipPlacementCollision

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 3
	PHU:

		mov al, 85
		mov [edi], al
		add edi, 2
		call WriteChar

	loop PHU

	SubmarinePlaced:

	call GenerateMaps
	call GenerateUIMechanics

	mov eax, 0

	mov al, ShipsPlaced
	inc al
	mov ShipsPlaced, al

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

	mov eax, 3
	call CheckVerticalShipPlacementCollision

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

	mov eax, 3
	call CheckHorizontalShipPlacementCollision

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 3
	PHD:

		mov al, 68
		mov [edi], al
		add edi, 2

	loop PHD

	DestroyerPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	mov eax, 0

	mov al, ShipsPlaced
	inc al
	mov ShipsPlaced, al

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

	mov eax, 2
	call CheckVerticalShipPlacementCollision

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

	mov eax, 2
	call CheckHorizontalShipPlacementCollision

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, 2
	PHS:

		mov al, 83
		mov [edi], al
		add edi, 2

	loop PHS

	SweeperPlaced:

	call GenerateMaps
	call GenerateUIMechanics

	mov eax, 0

	mov al, 5
	mov ShipsPlaced, 5

	ret
PlacePlayerSweeper ENDP

.data

ShipPlacementErrorMessage BYTE "Error: Ships cannot overlap. Please try again.", 0

.code

CheckVerticalShipPlacementCollision PROC

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, eax

	mov ah, 95

	CheckV:

		cmp [edi], ah
		je N

		jne ShipPlacementErrorVertical

		N:

		add edi, 22
		dec ecx

	cmp ecx, 0
	jne CheckV

	jmp ValidVerticalPlacement

	ShipPlacementErrorVertical:

	mov edx, OFFSET ShipPlacementErrorMessage
	call WriteString

	mov al, ShipsPlaced
	cmp al, 5
	jge ValidVerticalPlacement

	call PlacePlayerShips

	ValidVerticalPlacement:

	ret
CheckVerticalShipPlacementCollision ENDP

CheckHorizontalShipPlacementCollision PROC

	mov edi, OFFSET PlayerMap
	add edi, mapIndex

	mov ecx, eax

	mov ah, 95

	CheckH:

		cmp [edi], ah
		je N

		jne ShipPlacementErrorHorizontal

		N:

		add edi, 2
		dec ecx

	cmp ecx, 0
	jne CheckH

	jmp ValidHorizontalPlacement

	ShipPlacementErrorHorizontal:

	mov edx, OFFSET ShipPlacementErrorMessage
	call WriteString

	mov al, ShipsPlaced
	cmp al, 5
	jge ValidHorizontalPlacement

	call PlacePlayerShips

	ValidHorizontalPlacement:

	ret
CheckHorizontalShipPlacementCollision ENDP

;-----------------------------------------------------
; PlaceComputerShips
; Fills the computer ship arrays with coordinates that
; correspond with spots on the computer map.
; (row, column, row, column, row, column....)
; Returns: EAX = the random int
;-----------------------------------------------------

PlaceComputerShips PROC

	call PlaceComputerCarrier
	call PlaceComputerBattleship
	call PlaceComputerSubmarine
	call PlaceComputerDestroyer
	call PlaceComputerSweeper
	
	mov dl, 20
	mov dh, 24
	call GoToXY
	mov edx, OFFSET computerShipPlacementComplete
	call WriteString
	mov eax, 3000
	call Delay
	call ClearDirections


	ret
PlaceComputerShips ENDP

PlaceComputerCarrier PROC
	mov lowerbound, 1
	mov upperbound, 2
	call BetterRandomNumber
	cmp al, 1
	je vertical

	horizontal:
		mov esi, OFFSET ComputerCarrierShipArray
		inc esi
		mov bl, ComputerCarrierHealth
		call PlaceHorizontal

		movzx ecx, ComputerCarrierHealth
		dec ecx
		call FillArrayHorizontally
		jmp return

	vertical:
		mov esi, OFFSET ComputerCarrierShipArray
		mov bl, ComputerCarrierHealth
		call PlaceVertical

		movzx ecx, ComputerCarrierHealth
		dec ecx
		call FillArrayVertically

	return:
	ret
PlaceComputerCarrier ENDP

PlaceComputerBattleship PROC
	start:
		mov lowerbound, 1
		mov upperbound, 2
		call BetterRandomNumber
		cmp al, 1
		je vertical

		horizontal:
			mov esi, OFFSET ComputerBattleshipShipArray
			inc esi
			mov bl, ComputerBattleShipHealth
			call PlaceHorizontal

			movzx ecx, ComputerBattleShipHealth
			dec ecx
			call FillArrayHorizontally
			jmp return

		vertical:
			mov esi, OFFSET ComputerBattleshipShipArray
			mov bl, ComputerBattleShipHealth
			call PlaceVertical

			movzx ecx, ComputerBattleShipHealth
			dec ecx
			call FillArrayVertically

		return:
		mov esi, OFFSET ComputerBattleshipShipArray
		movzx ecx, ComputerBattleshipHealth
		call checkrandplacementcollision
		cmp matches, 1
		jne start

	ret
PlaceComputerBattleship ENDP

PlaceComputerSubmarine PROC
	start:
		mov lowerbound, 1
		mov upperbound, 2
		call BetterRandomNumber
		cmp al, 1
		je vertical

		horizontal:
			mov esi, OFFSET ComputerSubmarineShipArray
			inc esi
			mov bl, ComputerSubmarineHealth
			call PlaceHorizontal

			movzx ecx, ComputerSubmarineHealth
			dec ecx
			call FillArrayHorizontally
			jmp return

		vertical:
			mov esi, OFFSET ComputerSubmarineShipArray
			mov bl, ComputerSubmarineHealth
			call PlaceVertical

			movzx ecx, ComputerSubmarineHealth
			dec ecx
			call FillArrayVertically

		return:
			mov esi, OFFSET ComputerSubmarineShipArray
			movzx ecx, ComputerSubmarineHealth
			call CheckRandPlacementCollision
			cmp matches, 1
			jne start
		ret
PlaceComputerSubmarine ENDP

PlaceComputerDestroyer PROC
	start:
		mov lowerbound, 1
		mov upperbound, 2
		call BetterRandomNumber
		cmp al, 1
		je vertical

		horizontal:
			mov esi, OFFSET ComputerDestroyerShipArray
			inc esi
			mov bl, ComputerDestroyerHealth
			call PlaceHorizontal

			movzx ecx, ComputerDestroyerHealth
			dec ecx
			call FillArrayHorizontally
			jmp return

		vertical:
			mov esi, OFFSET ComputerDestroyerShipArray
			mov bl, ComputerDestroyerHealth
			call PlaceVertical

			movzx ecx, ComputerDestroyerHealth
			dec ecx
			call FillArrayVertically

		return:
			mov esi, OFFSET ComputerDestroyerShipArray
			movzx ecx, ComputerDestroyerHealth
			call CheckRandPlacementCollision
			cmp matches, 1
			jne start
	ret
PlaceComputerDestroyer ENDP

PlaceComputerSweeper PROC
	start:
		mov lowerbound, 1
		mov upperbound, 2
		call BetterRandomNumber
		cmp al, 1
		je vertical

		horizontal:
			mov esi, OFFSET ComputerSweeperShipArray
			inc esi
			mov bl, ComputerSweeperHealth
			call PlaceHorizontal

			movzx ecx, ComputerSweeperHealth
			dec ecx
			call FillArrayHorizontally
			jmp return

		vertical:
			mov esi, OFFSET ComputerSweeperShipArray
			mov bl, ComputerSweeperHealth
			call PlaceVertical

			movzx ecx, ComputerSweeperHealth
			dec ecx
			call FillArrayVertically

			
		return:
			mov esi, OFFSET ComputerSweeperShipArray
			movzx ecx, ComputerSweeperHealth
			call CheckRandPlacementCollision
			cmp matches, 0
			jne start
		ret
PlaceComputerSweeper ENDP

PlaceHorizontal PROC

	mov bh, ColMax
	sub bh, bl
	movzx ebx, bh
	mov upperbound, ebx
	movzx ebx, ColMin
	mov lowerbound, ebx
	call BetterRandomOdd
	mov currentCol, al
	mov [esi], al
	dec esi

	movzx ebx, RowMax						;1st row coorinate
	mov upperbound, ebx
	movzx ebx, RowMin
	mov lowerbound, ebx
	call BetterRandomNumber
	mov currentRow, al						;dh = row coordinate
	mov [esi], al
	inc esi

	ret
PlaceHorizontal ENDP

PlaceVertical PROC

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

	ret
PlaceVertical ENDP

FillArrayVertically PROC
	mov dh, currentRow
	mov dl, currentCol

	FillArray:
		inc esi
		inc dh
		mov [esi], dh
		inc esi
		mov [esi], dl
	loop FillArray

ret
FillArrayVertically ENDP
FillArrayHorizontally PROC
mov dh, currentRow
mov dl, currentCol

	FillArray:
		inc esi
		add dl, 2
		mov [esi], dh
		inc esi
		mov [esi], dl
	loop FillArray

ret
FillArrayHorizontally ENDP

CheckRandPlacementCollision PROC
	mov matches, 0
	mov ebx, esi
	mov edx, ecx

	mov CurrentShipLocation, OFFSET ComputerCarrierShipArray
	movzx eax, ComputerCarrierHealth
	mov CurrentShipHealth, al
	call CheckShipCollision
	add matches, al

	mov esi, ebx
	mov ecx, edx
	mov CurrentShipLocation, OFFSET ComputerBattleshipShipArray
	movzx eax, ComputerBattleshipHealth
	mov CurrentShipHealth, al
	call CheckShipCollision
	add matches, al

	mov esi, ebx
	mov ecx, edx
	mov CurrentShipLocation, OFFSET ComputerSubmarineShipArray
	movzx eax, ComputerSubmarineHealth
	mov CurrentShipHealth, al
	call CheckShipCollision
	add matches, al


	mov esi, ebx
	mov ecx, edx
	mov CurrentShipLocation, OFFSET ComputerDestroyerShipArray
	movzx eax, ComputerDestroyerHealth
	mov CurrentShipHealth, al
	call CheckShipCollision
	add matches, al

	return:

ret
CheckRandPlacementCollision ENDP

CheckShipCollision PROC uses EBX EDX
	mov al, 0
	LoopOuter:
		mov bh, [esi]
		inc esi
		mov bl, [esi]
		inc esi
		push ecx
		mov edi, currentshiplocation
		movzx ecx, currentshiphealth
		LoopInner:
			mov dh, [edi]
			inc edi
			mov dl, [edi]
			inc edi
			cmp dh, bh
			jne next
			cmp dl, bl
			jne next
			inc al

			next:
			loop LoopInner
		pop ecx
		cmp al, 1
		je return
		loop LoopOuter

	    return:
ret
CheckShipCollision ENDP

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
; (Column coordinates are only odd numbers)
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

PrintComputerArrays PROC

mov esi, OFFSET ComputerCarrierShipArray
mov ecx, lengthof ComputerCarrierShipArray
call PrintArray

mov esi, OFFSET ComputerBattleshipShipArray
mov ecx, lengthof ComputerBattleShipShipArray
call PrintArray

mov esi, OFFSET ComputerSubmarineShipArray
mov ecx, lengthof ComputerSubmarineShipArray
call PrintArray

mov esi, OFFSET ComputerDestroyerShipArray
mov ecx, lengthof ComputerDestroyerShipArray
call PrintArray

mov esi, OFFSET ComputerSweeperShipArray
mov ecx, lengthof ComputerSweeperShipArray
call PrintArray
ret
PrintComputerArrays ENDP

PrintArray PROC

	mov eax, 0
	loopx:
	mov al, [esi]
	call Writeint
	inc esi
	loop loopx
	call crlf

ret
PrintArray ENDP

PlayerTurn PROC

	call GetMouseCoordinates
	call TranslateRowCoordinate
	call TranslateColumnCoordinate

	call CheckPlayerAttack

	call GenerateMaps
	call GenerateUIMechanics

	ret
PlayerTurn ENDP

.data

FoundRowMessage BYTE "Found Row of Player Attack!", 0
PlayerHitMessage BYTE "Player has Hit!", 0

.code

CheckPlayerAttack PROC

	mov ax, rowCoordinate
	mov bx, columnCoordinate

	mov esi, OFFSET ComputerCarrierShipArray

	mov ecx, 5

	CarrierHitDetection:

		cmp [esi], al
		je CheckCarrierColumn
		jne NextCarrierPlace

		CheckCarrierColumn:

		inc esi
		cmp [esi], bl
		je PlayerCarrierHit

		dec esi
		jmp NextCarrierPlace

		PlayerCarrierHit:

		mov eax, 0

		mov al, ComputerCarrierHealth
		dec al
		mov ComputerCarrierHealth, al

		cmp eax, 0
		je ComputerCarrierSunk
		jmp ComputerCarrierNotSunk

		ComputerCarrierSunk:

		call ComputerShipSunk

		ComputerCarrierNotSunk:

		jmp ShipAttacked

		NextCarrierPlace:

		dec ecx

		cmp ecx, 0
		je CheckBattleshipAttack

		add esi, 2

	jmp CarrierHitDetection

	CheckBattleshipAttack:

	mov esi, OFFSET ComputerBattleshipShipArray

	mov ecx, 4

	BattleshipHitDetection:

		cmp [esi], al
		je CheckBattleshipColumn
		jne NextBattleshipPlace

		CheckBattleshipColumn:

		inc esi
		cmp [esi], bl
		je PlayerBattleshipHit

		dec esi
		jmp NextBattleshipPlace

		PlayerBattleshipHit:

		mov eax, 0

		mov al, ComputerBattleshipHealth
		dec al
		mov ComputerBattleshipHealth, al

		cmp al, 0
		je ComputerBattleshipSunk
		jmp ComputerBattleshipNotSunk

		ComputerBattleshipSunk:

		call ComputerShipSunk

		ComputerBattleshipNotSunk:

		jmp ShipAttacked

		NextBattleshipPlace:

		dec ecx

		cmp ecx, 0
		je CheckSubmarineAttack

		add esi, 2

	jmp BattleshipHitDetection

	CheckSubmarineAttack:

	mov esi, OFFSET ComputerSubmarineShipArray

	mov ecx, 3

	SubmarineHitDetection:

		cmp [esi], al
		je CheckSubmarineColumn
		jne NextSubmarinePlace

		CheckSubmarineColumn:

		inc esi
		cmp [esi], bl
		je PlayerSubmarineHit

		dec esi
		jmp NextSubmarinePlace

		PlayerSubmarineHit:

		mov eax, 0

		mov al, ComputerSubmarineHealth
		dec al
		mov ComputerSubmarineHealth, al

		cmp al, 0
		je ComputerSubmarineSunk
		jmp ComputerSubmarineNotSunk

		ComputerSubmarineSunk:

		call ComputerShipSunk

		ComputerSubmarineNotSunk:

		jmp ShipAttacked

		NextSubmarinePlace:

		dec ecx

		cmp ecx, 0
		je CheckDestroyerAttack

		add esi, 2

	jmp SubmarineHitDetection

	CheckDestroyerAttack:

	mov esi, OFFSET ComputerDestroyerShipArray

	mov ecx, 3

	DestroyerHitDetection:

		cmp [esi], al
		je CheckDestroyerColumn
		jne NextDestroyerPlace

		CheckDestroyerColumn:

		inc esi
		cmp [esi], bl
		je PlayerDestroyerHit

		dec esi
		jmp NextDestroyerPlace

		PlayerDestroyerHit:

		mov eax, 0

		mov al, ComputerDestroyerHealth
		dec al
		mov ComputerDestroyerHealth, al

		cmp al, 0
		je ComputerDestroyerSunk
		jmp ComputerDestroyerNotSunk

		ComputerDestroyerSunk:

		call ComputerShipSunk

		ComputerDestroyerNotSunk:

		jmp ShipAttacked

		NextDestroyerPlace:

		dec ecx

		cmp ecx, 0
		je CheckSweeperAttack

		add esi, 2

	jmp DestroyerHitDetection

	CheckSweeperAttack:

	mov esi, OFFSET ComputerSweeperShipArray

	mov ecx, 2

	SweeperHitDetection:

		cmp [esi], al
		je CheckSweeperColumn
		jne NextSweeperPlace

		CheckSweeperColumn:

		inc esi
		cmp [esi], bl
		je PlayerSweeperHit

		dec esi
		jmp NextSweeperPlace

		PlayerSweeperHit:

		mov eax, 0
		mov al, ComputerSweeperHealth
		dec al
		mov ComputerSweeperHealth, 0

		cmp al, 0
		je ComputerSweeperSunk
		jmp ComputerSweeperNotSunk

		ComputerSweeperSunk:

		call ComputerShipSunk

		ComputerSweeperNotSunk:

		jmp ShipAttacked

		NextSweeperPlace:

		dec ecx

		cmp ecx, 0
		je ShipAvoided

		add esi, 2

	jmp SweeperHitDetection

	ShipAttacked:
	call RegisterPlayerHit

	jmp PlayerAttackComplete

	ShipAvoided:
	call RegisterPlayerMiss

	PlayerAttackComplete:

	ret
CheckPlayerAttack ENDP

RegisterPlayerHit PROC

	mov eax, 0
	mov al, ComputerHealth
	dec al
	mov ComputerHealth, al

	mov edi, OFFSET ComputerMapViewable
	add edi, mapIndex
	sub edi, 40

	mov bl, 88

	mov [edi], bl

	ret
RegisterPlayerHit ENDP

RegisterPlayerMiss PROC

	mov edi, OFFSET ComputerMapViewable
	add edi, mapIndex
	sub edi, 40

	mov bl, 79

	mov [edi], bl

	ret
RegisterPlayerMiss ENDP

ComputerTurn PROC
call Pause2
movzx eax, LastTurnOutcome

	start:
		cmp HitStreak, 0
		je RandomTurn

		call SmartComputerTurn
		cmp HitStreak, 0
		je RandomTurn

		jmp Continue

		RandomTurn:
			mov HitStreak, 0
			mov lowerbound, 6
			mov upperbound, 15
			call BetterRandomNumber
			mov rowCoordinate, ax
			mov lowerbound, 23
			mov upperbound, 41
			call BetterRandomOdd
			mov columnCoordinate, ax

		Continue:
			call TranslateRowCoordinate
			call TranslateColumnCoordinate

			mov edi, OFFSET PlayerMap
			add edi, mapIndex

			mov esi, OFFSET Underscore
			mov al, [esi]
			cmp al, [edi]
			je cMiss

			mov esi, OFFSET Miss
			mov al, [esi]
			cmp al, [edi]
			je RandomTurn

			mov esi, OFFSET Hit
			mov al, [esi]
			cmp al, [edi]
			je RandomTurn

			cHit:
				mov al, HitStreak					;hit counter
				inc al
				mov HitStreak, al

				call saveHitInfo
				call CheckComputerTurnHit

				mov al, 88
				mov [edi], al
				jmp redraw

			cMiss:
				cmp HitStreak, 0
				je skip
				mov LastTurnOutcome, 3

				skip:
				mov al, 79
				mov [edi], al

			redraw:
				call GenerateMaps
				call GenerateUIMechanics
			ret
ComputerTurn ENDP

SmartComputerTurn PROC			;6 23/15 41

	mov eax, 'S'
	call writeChar

	cmp LastTurnOutcome, 1					;begin streak
	je left
	cmp LastTurnOutcome, 2					;continue in a direction
	je continueStreak
	cmp LastTurnOutcome, 3					;pick a new direction (hit then miss without sinking)
	je backtrack
	jmp error

	left:
		mov eax, 0
		mov esi, OFFSET LastHit
		mov al, [esi]
		mov rowCoordinate, ax

		inc esi
		mov al, [esi]
		cmp al, 23
		je leftWall
		sub al, 2
		movzx eax, al
		mov columnCoordinate, ax
		mov CurrentDirection, 0
		jmp return
	right:
		mov eax, 0
		mov esi, OFFSET LastHit
		mov al, [esi]
		mov rowCoordinate, ax
		inc esi
		mov al, [esi]
		cmp al, 41
		je error
		add al, 2
		movzx eax, al
		mov columnCoordinate, ax
		mov CurrentDirection, 1
		jmp return
	up:
		mov eax, 0
		mov esi, OFFSET LastHit
		mov al, [esi]
		cmp al, 6
		je topWall
		dec al
		mov rowCoordinate, ax
		inc esi
		mov al, [esi]
		mov columnCoordinate, ax
		mov CurrentDirection, 2
		jmp return

	down:
		mov eax, 0
		mov esi, OFFSET LastHit
		mov al, [esi]
		inc al
		mov rowCoordinate, ax
		inc esi
		mov al, [esi]
		mov columnCoordinate, ax
		mov CurrentDirection, 3
		jmp return

	continueStreak:
		cmp CurrentDirection, 0
		je left
		cmp CurrentDirection, 1
		je right
		cmp CurrentDirection, 2
		je up
		cmp CurrentDirection, 3
		je down
		jmp error

	backtrack:
		cmp HitStreak, 1
		jne opposite
		cmp CurrentDirection, 0
		je up
		cmp CurrentDirection, 2
		je right
		cmp CurrentDirection, 1
		je down
		jmp error

		opposite:
			cmp currentDirection, 0
			je jumpRight
			cmp currentDirection, 2
			je jumpDown

			jmp error

		jumpRight:
			mov eax, 0
			mov esi, OFFSET InitialHit
			mov al, [esi]
			mov rowCoordinate, ax
			inc esi
			mov al, [esi]
			add al, 2
			cmp al, 41								;this shouldn't ever be out of bounds, but just to be safe.
			jg error
			mov columnCoordinate, ax
			mov CurrentDirection, 1
			jmp return

		jumpDown:
			mov eax, 0
			mov esi, OFFSET InitialHit
			mov al, [esi]
			inc al
			mov rowCoordinate, ax
			inc esi
			mov al, [esi]
			mov columnCoordinate, ax
			mov CurrentDirection, 3
			jmp return

      leftWall:
  			cmp LastTurnOutcome, 1
  			je up
  			cmp LastTurnOutcome, 2
  			je jumpRight
  			jmp error
		  topWall:
  			cmp LastTurnOutcome, 1
  			je right
  			cmp LastTurnOutcome, 2
  			je jumpDown
  			jmp error

	error:
	mov HitStreak, 0
	return:
ret
SmartComputerTurn ENDP

CheckComputerTurnHit PROC
	mov dh, 0

	mov bl, 66
	cmp [edi], bl
	je PlayerBHit

	mov bl, 67
	cmp [edi], bl
	je PlayerCHit

	mov bl, 68
	cmp [edi], bl
	je PlayerDHit

	mov bl, 85
	cmp [edi], bl
	je PlayerUHit

	mov al, PlayerSweeperHealth
	dec al
	mov PlayerSweeperHealth, al
	cmp al, 0										;if it sunk, set computer turn back to random
	jne HealthAdjusted
	mov HitStreak, 0
	jmp HealthAdjusted

	PlayerBHit:

	mov al, PlayerBattleshipHealth
	dec al
	mov PlayerBattleshipHealth, al
	cmp al, 0										;if it sunk, set computer turn back to random
	jne HealthAdjusted
	mov HitStreak, 0
	jmp HealthAdjusted

	PlayerCHit:

	mov al, PlayerCarrierHealth
	dec al
	mov PlayerCarrierHealth, al
	cmp al, 0										;if it sunk, set computer turn back to random
	jne HealthAdjusted
	mov HitStreak, 0
	jmp HealthAdjusted

	PlayerDHit:

	mov al, PlayerDestroyerHealth
	dec al
	mov PlayerDestroyerHealth, al
	cmp al, 0										;if it sunk, set computer turn back to random
	jne HealthAdjusted
	mov HitStreak, 0
	jmp HealthAdjusted

	PlayerUHit:

	mov al, PlayerSubmarineHealth
	dec al
	mov PlayerSubmarineHealth, al
	cmp al, 0										;if it sunk, set computer turn back to random
	jne HealthAdjusted
	mov HitStreak, 0
	jmp HealthAdjusted

	HealthAdjusted:

	mov al, PlayerHealth
	dec al
	mov PlayerHealth, al

	ret
CheckComputerTurnHit ENDP
SaveHitInfo PROC

	mov LastTurnOutcome, 2
	movzx eax, RowCoordinate
	movzx ebx, ColumnCoordinate
	mov esi, OFFSET LastHit
	mov [esi], al
	inc esi
	mov [esi], bl

	cmp HitStreak, 1					;is it the first hit
	jne return

	mov LastTurnOutcome, 1
	mov esi, OFFSET InitialHit
	mov [esi], al
	inc esi
	mov [esi], bl

	return:
ret
SaveHitInfo ENDP

PlayerShipSunk PROC

	call Clrscr

	mov eax, yellow
	call SetTextColor

	mov dl, 40
	mov dh, 2
	call GoToXY

	mov edx, OFFSET PlayerShipSunkMessage
	call WriteString

	mov eax, lightRed
	call SetTextColor

	mov dl, 10
	mov dh, 3
	call GoToXY

	mov edx, OFFSET explosion1
	call WriteString

	mov dl, 10
	mov dh, 4
	call GoToXY

	mov edx, OFFSET explosion2
	call WriteString

	mov dl, 10
	mov dh, 5
	call GoToXY

	mov edx, OFFSET explosion3
	call WriteString

	mov dl, 10
	mov dh, 6
	call GoToXY

	mov edx, OFFSET explosion4
	call WriteString

	mov dl, 10
	mov dh, 7
	call GoToXY

	mov edx, OFFSET explosion5
	call WriteString

	mov dl, 10
	mov dh, 8
	call GoToXY

	mov edx, OFFSET explosion6
	call WriteString

	mov dl, 10
	mov dh, 9
	call GoToXY

	mov edx, OFFSET explosion7
	call WriteString

	mov dl, 10
	mov dh, 10
	call GoToXY

	mov edx, OFFSET explosion8
	call WriteString

	mov dl, 10
	mov dh, 11
	call GoToXY

	mov edx, OFFSET explosion9
	call WriteString

	mov dl, 10
	mov dh, 12
	call GoToXY

	mov edx, OFFSET explosion10
	call WriteString

	mov dl, 10
	mov dh, 13
	call GoToXY

	mov edx, OFFSET explosion11
	call WriteString

	mov dl, 10
	mov dh, 14
	call GoToXY

	mov edx, OFFSET explosion12
	call WriteString

	mov dl, 10
	mov dh, 15
	call GoToXY

	mov edx, OFFSET explosion13
	call WriteString

	mov dl, 10
	mov dh, 16
	call GoToXY

	mov edx, OFFSET explosion14
	call WriteString

	mov dl, 10
	mov dh, 17
	call GoToXY

	mov edx, OFFSET explosion15
	call WriteString

	mov dl, 10
	mov dh, 18
	call GoToXY

	mov edx, OFFSET explosion16
	call WriteString

	mov dl, 10
	mov dh, 19
	call GoToXY

	mov edx, OFFSET explosion17
	call WriteString

	mov dl, 10
	mov dh, 20
	call GoToXY

	mov edx, OFFSET explosion18
	call WriteString

	mov dl, 10
	mov dh, 21
	call GoToXY

	mov edx, OFFSET explosion19
	call WriteString

	mov dl, 10
	mov dh, 22
	call GoToXY

	mov edx, OFFSET explosion20
	call WriteString

	mov dl, 10
	mov dh, 23
	call GoToXY

	mov edx, OFFSET explosion21
	call WriteString

	mov dl, 10
	mov dh, 24
	call GoToXY

	mov edx, OFFSET explosion22
	call WriteString

	mov dl, 10
	mov dh, 25
	call GoToXY

	mov edx, OFFSET explosion23
	call WriteString

	mov eax, lightCyan
	call SetTextColor

	mov dl, 10
	mov dh, 26
	call GoToXY

	mov edx, OFFSET explosion24
	call WriteString

	mov dl, 10
	mov dh, 27
	call GoToXY

	mov edx, OFFSET explosion25
	call WriteString

	mov eax, white
	call SetTextColor

	mov eax, 3000
	call Delay

	call Clrscr

	call GenerateGameTitle
	call GenerateMaps
	call GenerateUIMechanics

	ret
PlayerShipSunk ENDP

ComputerShipSunk PROC

	call Clrscr

	mov eax, yellow
	call SetTextColor

	mov dl, 40
	mov dh, 2
	call GoToXY

	mov edx, OFFSET ComputerShipSunkMessage
	call WriteString

	mov eax, lightRed
	call SetTextColor

	mov dl, 10
	mov dh, 3
	call GoToXY

	mov edx, OFFSET explosion1
	call WriteString

	mov dl, 10
	mov dh, 4
	call GoToXY

	mov edx, OFFSET explosion2
	call WriteString

	mov dl, 10
	mov dh, 5
	call GoToXY

	mov edx, OFFSET explosion3
	call WriteString

	mov dl, 10
	mov dh, 6
	call GoToXY

	mov edx, OFFSET explosion4
	call WriteString

	mov dl, 10
	mov dh, 7
	call GoToXY

	mov edx, OFFSET explosion5
	call WriteString

	mov dl, 10
	mov dh, 8
	call GoToXY

	mov edx, OFFSET explosion6
	call WriteString

	mov dl, 10
	mov dh, 9
	call GoToXY

	mov edx, OFFSET explosion7
	call WriteString

	mov dl, 10
	mov dh, 10
	call GoToXY

	mov edx, OFFSET explosion8
	call WriteString

	mov dl, 10
	mov dh, 11
	call GoToXY

	mov edx, OFFSET explosion9
	call WriteString

	mov dl, 10
	mov dh, 12
	call GoToXY

	mov edx, OFFSET explosion10
	call WriteString

	mov dl, 10
	mov dh, 13
	call GoToXY

	mov edx, OFFSET explosion11
	call WriteString

	mov dl, 10
	mov dh, 14
	call GoToXY

	mov edx, OFFSET explosion12
	call WriteString

	mov dl, 10
	mov dh, 15
	call GoToXY

	mov edx, OFFSET explosion13
	call WriteString

	mov dl, 10
	mov dh, 16
	call GoToXY

	mov edx, OFFSET explosion14
	call WriteString

	mov dl, 10
	mov dh, 17
	call GoToXY

	mov edx, OFFSET explosion15
	call WriteString

	mov dl, 10
	mov dh, 18
	call GoToXY

	mov edx, OFFSET explosion16
	call WriteString

	mov dl, 10
	mov dh, 19
	call GoToXY

	mov edx, OFFSET explosion17
	call WriteString

	mov dl, 10
	mov dh, 20
	call GoToXY

	mov edx, OFFSET explosion18
	call WriteString

	mov dl, 10
	mov dh, 21
	call GoToXY

	mov edx, OFFSET explosion19
	call WriteString

	mov dl, 10
	mov dh, 22
	call GoToXY

	mov edx, OFFSET explosion20
	call WriteString

	mov dl, 10
	mov dh, 23
	call GoToXY

	mov edx, OFFSET explosion21
	call WriteString

	mov dl, 10
	mov dh, 24
	call GoToXY

	mov edx, OFFSET explosion22
	call WriteString

	mov dl, 10
	mov dh, 25
	call GoToXY

	mov edx, OFFSET explosion23
	call WriteString

	mov eax, lightCyan
	call SetTextColor

	mov dl, 10
	mov dh, 26
	call GoToXY

	mov edx, OFFSET explosion24
	call WriteString

	mov dl, 10
	mov dh, 27
	call GoToXY

	mov edx, OFFSET explosion25
	call WriteString

	mov eax, white
	call SetTextColor

	mov eax, 3000
	call Delay

	call Clrscr

	call GenerateGameTitle
	call GenerateMaps
	call GenerateUIMechanics

	ret
ComputerShipSunk ENDP

Pause2 PROC
mov eax, 2000
call Delay
ret
Pause2 ENDP

PlayerWin PROC
	call Clrscr
	mov eax, lightGreen
	call SetTextColor
	mov dl, 32
	mov dh, 10
	call GoToXY
	mov edx, OFFSET Victory1
	call WriteString
	mov dl, 32
	mov dh, 11
	call GoToXY
	mov edx, OFFSET Victory2
	call WriteString
	mov dl, 32
	mov dh, 12
	call GoToXY
	mov edx, OFFSET Victory3
	call WriteString
	mov dl, 32
	mov dh, 13
	call GoToXY
	mov edx, OFFSET Victory4
	call WriteString
	mov dl, 32
	mov dh, 14
	call GoToXY
	mov edx, OFFSET Victory5
	call WriteString
	mov edx, 0
	call GoToXY
	mov eax, white
	call SetTextColor
	ret
PlayerWin ENDP
ComputerWin PROC
	call Clrscr
	mov eax, lightRed
	call SetTextColor
	mov dl, 32
	mov dh, 10
	call GoToXY
	mov edx, OFFSET Defeat1
	call WriteString
	mov dl, 32
	mov dh, 11
	call GoToXY
	mov edx, OFFSET Defeat2
	call WriteString
	mov dl, 32
	mov dh, 12
	call GoToXY
	mov edx, OFFSET Defeat3
	call WriteString
	mov dl, 32
	mov dh, 13
	call GoToXY
	mov edx, OFFSET Defeat4
	call WriteString
	mov dl, 32
	mov dh, 14
	call GoToXY
	mov edx, OFFSET Defeat5
	call WriteString
	mov edx, 0
	call GoToXY
	mov eax, white
	call SetTextColor
	ret
ComputerWin ENDP

END main
