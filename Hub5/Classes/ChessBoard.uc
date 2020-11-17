class ChessBoard extends Trigger;

struct	GamePiece
{
	var	ChessPiece	Piece;
	var vector		Position;
};

var	GamePiece			ChessSet[8];
var int					PieceOrder[8];
var int					iPieceMove;

var BaseHarry			Player;
var vector				HarrysPosition;

var float				PrevMoveTime;
var float				CurrentMoveTime;

var bool				bCombat;

var int					iDefendingPiece;

var ChessSelectFlaredSquare	SelectSquare;

var actor				A;

var int					iWait;

function SortPieces()
{
	local int	iPiece;
	local int	iCheckPiece;
	local int	iSortPiece;
	local int	iShufflePiece;

	// do a simple bubble sort
	// put first piece in 

	PieceOrder[0] = 0;

	for (iPiece = 1; iPiece < 8; iPiece ++)
	{
		if (ChessSet[iPiece].Piece != none)
		{
			log ("Checking piece " $string(ChessSet[iPiece].Piece.name));
		}
		if (ChessSet[iPiece].Piece != none)
		{
			for (iCheckPiece = iPiece - 1; iCheckPiece >= 0; iCheckPiece --)
			{
				if (!PieceIsCloser(iPiece, PieceOrder[iCheckPiece]))
				{
					// Found the position, insert piece in to the order
					// Shuffle the other pieces down

					for (iShufflePiece = iPiece - 1; iShufflePiece > iCheckPiece; iShufflePiece --)
					{
						PieceOrder[iShufflePiece + 1] = PieceOrder[iShufflePiece];

						log("moving " $string(ChessSet[PieceOrder[iShufflePiece]].Piece.name) $"to " $iShufflePiece + 1);
					}
					PieceOrder[iCheckPiece + 1] = iPiece;
					log("inserting " $string(ChessSet[PieceOrder[iCheckPiece + 1]].Piece.name) $"in " $iCheckPiece + 1);
					break;
				}
				else if (iCheckPiece == 0) // Special case of when we reach the top
				{
					for (iShufflePiece = iPiece - 1; iShufflePiece >= 0; iShufflePiece --)
					{
						PieceOrder[iShufflePiece + 1] = PieceOrder[iShufflePiece];
						log("moving " $string(ChessSet[PieceOrder[iShufflePiece]].Piece.name) $"to " $iShufflePiece + 1);
					}
					PieceOrder[0] = iPiece;
					log("inserting " $string(ChessSet[PieceOrder[0]].Piece.name) $"in 0");
					break;
				}
			}
		}
		else
		{
			PieceOrder[iPiece] = iPiece;
		}
	}

	for (iPiece = 0; iPiece < 8; iPiece ++)
	{
		if (ChessSet[iPiece].Piece != none)
		{
			log("Chess piece " $iPiece $" " $string(ChessSet[PieceOrder[iPiece]].Piece.name));
		}
	}
}

// Are there any chess pieces remaining
function bool PiecesRemaining()
{
	local int iPiece;

	for (iPiece = 0; iPiece < 8; iPiece ++)
	{
		if (ChessSet[iPiece].Piece != none)
		{
			// found a piece
			return true;
		}
	}

	// No pieces remaining

	return false;
}

// Direct distance is not what we want, we just need orthoganal distances
function bool PieceIsCloser(int iPiece1, int iPiece2)
{
	local int	iLongest1, iLongest2, iShortest1, iShortest2;
	local bool	bCloser;
	local vector	HarrysPosition;

	bCloser = true;

	HarrysPosition = GetPiecePosition(Player.Location);

	// If the other piece is invalid, then this piece is closer
	if (ChessSet[iPiece2].Piece == none)
	{
		return true;
	}

	// first of all find the longest axis

	if (abs(ChessSet[iPiece1].Position.x - HarrysPosition.x) > abs(ChessSet[iPiece1].Position.y - HarrysPosition.y))
	{
		iLongest1 = abs(ChessSet[iPiece1].Position.x - HarrysPosition.x);
		iShortest1 = abs(ChessSet[iPiece1].Position.y - HarrysPosition.y);
	}
	else
	{
		iLongest1 = abs(ChessSet[iPiece1].Position.y - HarrysPosition.y);
		iShortest1 = abs(ChessSet[iPiece1].Position.x - HarrysPosition.x);
	}

	if (abs(ChessSet[iPiece2].Position.x - HarrysPosition.x) > abs(ChessSet[iPiece2].Position.y - HarrysPosition.y))
	{
		iLongest2 = abs(ChessSet[iPiece2].Position.x - HarrysPosition.x);
		iShortest2 = abs(ChessSet[iPiece2].Position.y - HarrysPosition.y);
	}
	else
	{
		iLongest2 = abs(ChessSet[iPiece2].Position.y - HarrysPosition.y);
		iShortest2 = abs(ChessSet[iPiece2].Position.x - HarrysPosition.x);
	}

	if (iLongest1 > iLongest2)
	{
		bCloser = false;
	}
	else if (iLongest1 < iLongest2)
	{
		bCloser = true;
	}
	else if (iShortest1 > iShortest2)
	{
		bCloser = false;
	}
	else
	{
		bCloser = true;
	}

	return bCloser;
}

function MovePiece(int iPiece)
{
	local vector		HarrysPosition;
	local vector		PiecePosition;

	//move piece closer to Harry
	HarrysPosition = GetPiecePosition(Player.Location);

	PiecePosition = ChessSet[iPiece].Position;

	if (HarrysPosition.x > PiecePosition.x)
	{
		PiecePosition.x += 1;
	}
	else if (HarrysPosition.x < PiecePosition.x)
	{
		PiecePosition.x  -= 1;
	}

	if (HarrysPosition.y > PiecePosition.y)
	{
		PiecePosition.y  += 1;
	}
	else if (HarrysPosition.y < PiecePosition.y)
	{
		PiecePosition.y  -= 1;
	}

	ChessSet[iPiece].Piece.bMoved = false;
	ChessSet[iPiece].Piece.ChessTargetLocation = GetPieceLocation(PiecePosition);
	if (SquareIsEmpty(PiecePosition))
	{
		// Do a simply check to see if Harry is there
		if (PiecePosition.x == HarrysPosition.x && PiecePosition.y == HarrysPosition.y)
		{
			ChessSet[iPiece].Piece.ChessTargetLocation = ((ChessSet[iPiece].Piece.ChessTargetLocation - ChessSet[iPiece].Piece.location) / 2) + ChessSet[iPiece].Piece.Location;
			ChessSet[iPiece].Piece.DesiredRotation = rotator(Player.Location - ChessSet[iPiece].Piece.Location);
			ChessSet[iPiece].Piece.GotoState('PieceAttacking');
			iDefendingPiece = -1;		// Denotes that it is Harry
			Player.DesiredRotation = rotator(ChessSet[iPiece].Piece.Location - Player.Location);
			Player.GotoState('ChessDeath');
			bCombat = true;
		}
		else
		{
			ChessSet[iPiece].Piece.DesiredRotation = rotator(Player.Location - ChessSet[iPiece].Piece.Location);
			ChessSet[iPiece].Piece.GotoState('PieceMoving');
			bCombat = false;
		}
	}
	else
	{
		// Don't move the piece as far
		ChessSet[iPiece].Piece.ChessTargetLocation = ((ChessSet[iPiece].Piece.ChessTargetLocation - ChessSet[iPiece].Piece.location) / 2) + ChessSet[iPiece].Piece.Location;
		iDefendingPiece = GetPieceFromPosition(PiecePosition);
		ChessSet[iPiece].Piece.DesiredRotation = rotator(ChessSet[iDefendingPiece].Piece.Location - ChessSet[iPiece].Piece.Location);
		ChessSet[iDefendingPiece].Piece.DesiredRotation = rotator(ChessSet[iPiece].Piece.Location - ChessSet[iDefendingPiece].Piece.Location);
		ChessSet[iPiece].Piece.GotoState('PieceAttacking');
		ChessSet[iDefendingPiece].Piece.GotoState('PieceDefending');
		bCombat = true;
	}
	ChessSet[iPiece].Position = PiecePosition;
	log ("Moving " $string(ChessSet[iPiece].Piece.name) $" to " $PiecePosition.x $" " $PiecePosition.y);
	log ("Moving " $string(ChessSet[iPiece].Piece.name) $" to " $ChessSet[iPiece].Piece.ChessTargetLocation.x $" " $ChessSet[iPiece].Piece.ChessTargetLocation.y);
	Player.clientMessage("Moving " $string(ChessSet[iPiece].Piece.name) $" to " $PiecePosition.x $" " $PiecePosition.y);
	Player.clientMessage("Moving " $string(ChessSet[iPiece].Piece.name) $" to " $ChessSet[iPiece].Piece.ChessTargetLocation.x $" " $ChessSet[iPiece].Piece.ChessTargetLocation.y);
}

function vector GetPiecePosition(vector PieceLocation)
{
	local vector	RelativeLocation;
	local vector	PiecePosition;		// X contains column, Y contains row 0 - 7

	RelativeLocation = PieceLocation - Location;

	PiecePosition.x = int((RelativeLocation.x / CollisionWidth) * 4 + 4);
	PiecePosition.y = int((RelativeLocation.y / CollisionRadius) * 4 + 4);

	if (PiecePosition.x > 7)
	{
		PiecePosition.x = 7;
	}

	if (PiecePosition.x < 0)
	{
		PiecePosition.x = 0;
	}

	if (PiecePosition.y > 7)
	{
		PiecePosition.y = 7;
	}

	if (PiecePosition.y < 0)
	{
		PiecePosition.y = 0;
	}

	return PiecePosition;
}

function vector GetPieceLocation(vector PiecePosition)
{
	local vector	PieceLocation;

	// calculate relative location, and move to centre of square

	PieceLocation.z = 0;
	PieceLocation.x = ((PiecePosition.x - 4) / 4) * CollisionWidth + CollisionWidth / 8;
	PieceLocation.y = ((PiecePosition.y - 4) / 4) * CollisionRadius + CollisionRadius / 8;

	PieceLocation = PieceLocation + Location;

	return PieceLocation;
}

function touch(actor other)
{
	local vector		HarrysPosition;
	local int			iPiece;
	local ChessPiece	Piece;

	// At this point, we go in to the chess game proper
	// First of all, find Harry

	if (!other.isa('baseharry'))
	{
		return;
	}
	else
	{
		Player = baseharry(other);
		Player.cam.gotostate('StandardState');
		Player.cam.CameraOffset = vect(0, 0, 120);
		Player.GotoState('ChessMode');
		Harry(Player).bHarrysMove = true;
		Harry(Player).ChessTargetLocation = vect(0, 0, 0);
		disable('touch');
	}

	// Now find all the chess pieces

	iPiece = 0;
	foreach AllActors(class'ChessPiece', Piece)
	{
		ChessSet[iPiece].Piece = Piece;
		ChessSet[iPiece].Position = GetPiecePosition(ChessSet[iPiece].Piece.Location);

		log("Piece " $string(ChessSet[iPiece].Piece.name) $" " $ChessSet[iPiece].Position.x $" " $ChessSet[iPiece].Position.y);
		iPiece ++;

		if (iPiece > 7)
		{
			break;
		}
	}

	SortPieces();

	// we need to decide what side Harry is on
	HarrysPosition = GetPiecePosition(Player.Location);
	Harry(Player).ChessTargetLocation = GetPieceLocation(HarrysPosition);
	Harry(Player).bChessMoving = true;

	gotostate('GameActive');
}

function int GetPieceFromPosition(vector Square)
{
	local	int		iPiece;
	local	vector	PiecePosition;

	for (iPiece = 0; iPiece < 8; iPiece ++)
	{
		if (ChessSet[PieceOrder[iPiece]].Piece != none)
		{
			PiecePosition = GetPiecePosition(ChessSet[PieceOrder[iPiece]].Piece.location);

			log("Index " $iPiece $"PieceOrder " $PieceOrder[iPiece] $" " $string(ChessSet[PieceOrder[iPiece]].Piece.name) $"Square " $Square.x $" " $Square.y $" " $"Piece " $PiecePosition.x $" " $PiecePosition.y $" ");
			if (PiecePosition.x == Square.x && PiecePosition.y == Square.y)
			{
				// piece in this square, return piece

				return PieceOrder[iPiece];
			}
		}
	}

	return -1;
}

function bool SquareIsEmpty(vector Square)
{
	local	int		iPiece;
	local	vector	PiecePosition;

	for (iPiece = 0; iPiece < 8; iPiece ++)
	{
		if (ChessSet[PieceOrder[iPiece]].Piece != none)
		{
			PiecePosition = GetPiecePosition(ChessSet[PieceOrder[iPiece]].Piece.location);

//		log("Index " $iPiece $"PieceOrder " $PieceOrder[iPiece] $" " $string(ChessSet[PieceOrder[iPiece]].Piece.name) $"Square " $Square.x $" " $Square.y $" " $"Piece " $PiecePosition.x $" " $PiecePosition.y $" ");
			if (PiecePosition.x == Square.x && PiecePosition.y == Square.y)
			{
			// piece in this square, return failure

				return false;
			}
		}
	}

	return true;
}

function bool ValidHarryMove(int iNewSquare)
{
	local bool		bValidMove;
	local vector	OrigHarrysPosition;

	OrigHarrysPosition = HarrysPosition;

	bValidMove = true;

	log("New square " $iNewSquare $"Position " $HarrysPosition.x $" " $HarrysPosition.y);

	switch(iNewSquare)
	{
		case 0:
			if (HarrysPosition.x < 7)
			{
				HarrysPosition.x += 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 1:
			if (HarrysPosition.x < 7)
			{
				HarrysPosition.x += 1;
			}
			else
			{
				bValidMove = false;
			}

			if (HarrysPosition.y < 7)
			{
				HarrysPosition.y += 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 2:
			if (HarrysPosition.y < 7)
			{
				HarrysPosition.y += 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 3:
			if (HarrysPosition.x > 0)
			{
				HarrysPosition.x -= 1;
			}
			else
			{
				bValidMove = false;
			}

			if (HarrysPosition.y < 7)
			{
				HarrysPosition.y += 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 4:
			if (HarrysPosition.x > 0)
			{
				HarrysPosition.x -= 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 5:
			if (HarrysPosition.x > 0)
			{
				HarrysPosition.x -= 1;
			}
			else
			{
				bValidMove = false;
			}

			if (HarrysPosition.y > 0)
			{
				HarrysPosition.y -= 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 6:
			if (HarrysPosition.y > 0)
			{
				HarrysPosition.y -= 1;
			}
			else
			{
				bValidMove = false;
			}
			break;

		case 7:
			if (HarrysPosition.x < 7)
			{
				HarrysPosition.x += 1;
			}
			else
			{
				bValidMove = false;
			}

			if (HarrysPosition.y > 0)
			{
				HarrysPosition.y -= 1;
			}
			else
			{
				bValidMove = false;
			}
			break;
	}

	if (bValidMove)
	{
		Player.clientMessage("Valid move");
		// Make sure there is not an enemy piece in the square
		if (!SquareIsEmpty(HarrysPosition))
		{
			bValidMove = false;
			HarrysPosition = OrigHarrysPosition;
			Player.clientMessage("square not empty");
		}
	}
	else
	{
		Player.clientMessage("invalid move");
	}

	return bValidMove;
}

function vector HarrysNewPosition(int iNewSquare)
{
	local bool		bValidMove;
	local vector	HarrysNewPosition;

	HarrysNewPosition = HarrysPosition;

	bValidMove = true;

	log("New square " $iNewSquare $" Position " $HarrysPosition.x $" " $HarrysPosition.y);

	switch(iNewSquare)
	{
		case 0:
			if (HarrysNewPosition.x < 7)
			{
				HarrysNewPosition.x += 1;
			}
			break;

		case 1:
			if (HarrysNewPosition.x < 7)
			{
				HarrysNewPosition.x += 1;
			}

			if (HarrysNewPosition.y < 7)
			{
				HarrysNewPosition.y += 1;
			}
			break;

		case 2:
			if (HarrysNewPosition.y < 7)
			{
				HarrysNewPosition.y += 1;
			}
			break;

		case 3:
			if (HarrysNewPosition.x > 0)
			{
				HarrysNewPosition.x -= 1;
			}

			if (HarrysNewPosition.y < 7)
			{
				HarrysNewPosition.y += 1;
			}
			break;

		case 4:
			if (HarrysNewPosition.x > 0)
			{
				HarrysNewPosition.x -= 1;
			}
			break;

		case 5:
			if (HarrysNewPosition.x > 0)
			{
				HarrysNewPosition.x -= 1;
			}

			if (HarrysNewPosition.y > 0)
			{
				HarrysNewPosition.y -= 1;
			}
			break;

		case 6:
			if (HarrysNewPosition.y > 0)
			{
				HarrysNewPosition.y -= 1;
			}
			break;

		case 7:
			if (HarrysNewPosition.x < 7)
			{
				HarrysNewPosition.x += 1;
			}

			if (HarrysNewPosition.y > 0)
			{
				HarrysNewPosition.y -= 1;
			}
			break;
	}

	// Make sure there is not an enemy piece in the square
	if (!SquareIsEmpty(HarrysNewPosition))
	{
		HarrysNewPosition = HarrysPosition;
	}

	return HarrysNewPosition;
}

function PostBeginPlay()
{
	iWait = 2;
}

auto state Inactive
{
}

state GameActive
{
        ignores touch;

	function tick(float deltatime)
	{
		local int		iNewSquare;

		if (Harry(Player).bChessMoving)
		{
			// wait for Harry to finish his first move
			return;
		}
		else
		{
			gotostate('HarrysMove');
		}
	}
}

state HarrysMove
{
        ignores touch;

	function BeginState()
	{
		local	vector	SquareLocation;
		local	int		iNewSquare;

		Player.cam.gotostate('StandardState');
		Player.cam.CameraOffset = vect(0, 0, 120);

		iWait --;
		if (iWait == 0)
		{
			baseHUD(player.myHUD).ShowPopup(class'basewarning');
			basewarning(baseHUD(player.myHUD).curPopup).DisplayText = Localize( "all", "ingame_help_25","Pickup" );
			basewarning(baseHUD(player.myHUD).curPopup).lifespan=10;
		}

		if (!PiecesRemaining())
		{
			//game is finished, Harry has won!
			gotostate('EndGame');
		}
		else
		{
			Player.clientMessage("Harry's move");
			Player.GotoState('ChessMode');

			iNewSquare = ((Player.Rotation.yaw + 0xfff) & 0xffff) * 8 / 0x10000;
	
			SquareLocation = GetPieceLocation(HarrysNewPosition(iNewSquare));
	
			SelectSquare = spawn(class'ChessSelectFlaredSquare', [spawnlocation]SquareLocation);
		}
	}

	function tick(float deltatime)
	{
		local int		iNewSquare;
		local vector	SquareLocation;

		HarrysPosition = GetPiecePosition(Player.Location);

		BaseHUD(player.MyHUD).DebugValX = HarrysPosition.x;
		BaseHUD(player.MyHUD).DebugValY = HarrysPosition.y;

		BaseHUD(player.MyHUD).DebugValX2 = Player.Location.x;
		BaseHUD(player.MyHUD).DebugValY2 = Player.Location.y;
		BaseHUD(player.MyHUD).DebugValZ2 = Player.Location.z;

		iNewSquare = ((Player.Rotation.yaw + 0xfff) & 0xffff) * 8 / 0x10000;

		if (Harry(Player).bChessMoving && Harry(Player).ChessTargetLocation == vect(0, 0, 0))
		{
			if (ValidHarryMove(iNewSquare))
			{
				Harry(Player).ChessTargetLocation = GetPieceLocation(HarrysPosition);
			}
			else
			{
				Harry(Player).bChessMoving = false;
			}
		}
		else if (!Harry(Player).bChessMoving)
		{
			SquareLocation = GetPieceLocation(HarrysNewPosition(iNewSquare));
			SelectSquare.SetLocation(SquareLocation);
		}

		if (!Harry(Player).bHarrysMove)
		{
			SelectSquare.Destroy();
			gotostate('ChessPiecesMove');
		}
	}
}

state ChessPiecesMove
{
        ignores touch;

	function BeginState()
	{
		baseHud(player.myhud).bCutSceneMode = true;
		iPieceMove = 0;
		Player.cam.SetCameraRotSpeed(0.5);
		Player.clientMessage("Piece move");
		SortPieces();
	}

	function tick(float deltatime)
	{
		if (ChessSet[PieceOrder[iPieceMove]].Piece != none)
		{
			if (ChessSet[PieceOrder[iPieceMove]].Piece.bMoved)
			{
				ChessSet[PieceOrder[iPieceMove]].Piece.bMoved = false;
				if (bCombat)
				{
					if (iDefendingPiece == -1)
					{
						// Attacking Harry
						Player.bAllowHarryToDie = true;
						Player.GotoState('stateDead');
						//game is finished, Harry has lost!
						gotostate('EndGame');
					}
					else
					{
						ChessSet[PieceOrder[iPieceMove]].Piece.Explode();
						ChessSet[iDefendingPiece].Piece.Explode();
						ChessSet[PieceOrder[iPieceMove]].Piece = none;
						ChessSet[iDefendingPiece].Piece = none;
					}
				}
				iPieceMove ++;
				Player.clientMessage("Piece moved " $string(ChessSet[PieceOrder[iPieceMove]].Piece.name));
			}
			else if (ChessSet[PieceOrder[iPieceMove]].Piece.ChessTargetLocation == vect(0, 0, 0))
			{
				// piece needs a move
				Player.clientMessage("Piece move " $string(ChessSet[PieceOrder[iPieceMove]].Piece.name));
				MovePiece(PieceOrder[iPieceMove]);
				Player.cam.gotostate('CutState');
				Player.cam.DirectionActor = ChessSet[PieceOrder[iPieceMove]].Piece;
				Player.cam.CameraOffset = vect(0, 0, 200);
			}
		}
		else
		{
			iPieceMove ++;
		}

		if (iPieceMove > 7)
		{
		// It is now Harry's move
			Harry(Player).bHarrysMove = true;
			Harry(Player).ChessTargetLocation = vect(0, 0, 0);
			Player.cam.SetCameraRotSpeed(1.0);
			baseHud(player.myhud).bCutSceneMode = false;
			Player.cam.DirectionActor = none;
			gotostate('HarrysMove');
		}
	}
}

state EndGame
{
        ignores touch;

begin:
	Player.clientMessage("Game ended!");
	if (!PiecesRemaining())
	{
		// Harry has won!

		// Trigger the end scene
		if( Event != '' )
		{
			foreach AllActors( class 'Actor', A, Event )
			{
				A.Trigger( Player, Player );
			}
		}
		Player.cam.CameraOffset = vect(0, 0, 0);
		Player.gotostate('playerwalking');
		Destroy();
	}

loop:
	sleep(1.0);
	goto 'begin';
}

defaultproperties
{
}
