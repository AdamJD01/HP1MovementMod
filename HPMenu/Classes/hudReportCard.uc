//=============================================================================
// hudReportCard - Report Card to pop up when Harry reaches certain points
//=============================================================================
class hudReportCard extends basePopup;

#EXEC TEXTURE IMPORT NAME=ReportPiece1	 FILE=TEXTURES\ReportPiece1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ReportPiece2	 FILE=TEXTURES\ReportPiece2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ReportPiece3	 FILE=TEXTURES\ReportPiece3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ReportPiece4	 FILE=TEXTURES\ReportPiece4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=ReportGreenSand	 FILE=TEXTURES\ReportGreenSand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ReportYellowSand	 FILE=TEXTURES\ReportYellowSand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ReportPurpleSand	 FILE=TEXTURES\ReportPurpleSand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ReportRedSand		 FILE=TEXTURES\ReportRedSand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

var float cardWidth, cardHeight;
var	float left_x, top_y;

var float TimePassed;

var int maxPoints;
var name TriggerOnDeath;

var basehud myhud;

struct HousePointAnimData
{
	var float StartTime;
	var Texture Sand;
	var float sandPosX;
	var int numPoints;
};

var HousePointAnimData housePoints [4];

var baseHarry	PlayerHarry;




function Tick (float DeltaTime)
{
	TimePassed += DeltaTime;
}

auto state NewCard
{
	function beginState ()
	{
		local int i;

		cardWidth  = 334;
		cardHeight = 377;

		left_x = (640-cardWidth)/2;
		top_y  = (480-cardHeight)/2 + 0.5;

		housePoints[0].startTime = 0;
		housePoints[1].startTime = 0;
		housePoints[2].startTime = 0;
		housePoints[3].startTime = 0;

		housePoints[0].Sand = Texture'ReportGreenSand';
		housePoints[1].Sand = Texture'ReportYellowSand';
		housePoints[2].Sand = Texture'ReportPurpleSand';
		housePoints[3].Sand = Texture'ReportRedSand';

		housePoints[0].sandPosX = 53;
		housePoints[1].sandPosX = housePoints[0].sandPosX + 64;
		housePoints[2].sandPosX = housePoints[1].sandPosX + 63;
		housePoints[3].sandPosX = housePoints[2].sandPosX + 66;

		// Find Harry!
		foreach AllActors( class'baseHarry', PlayerHarry )
		{
			break;
		}

		housepoints[0].numPoints = PlayerHarry.getnumhousePointsSlytherin ();
		housepoints[1].numPoints = PlayerHarry.getnumhousePointsRavenclaw ();
		housepoints[2].numPoints = PlayerHarry.getnumHousePointsHufflePuff ();
		housepoints[3].numPoints = PlayerHarry.getnumHousePointsGryffindor ();

		maxPoints = PlayerHarry.maxPointsPerHouse;

		TimePassed = 0;
	}

	function endState ()
	{
//		log("End of Report Card state...");
	}
}

event Destroyed()
{
//	Log("Report card about to be destroyed"@ TimePassed);

	if( TriggerOnDeath != '' )
	{
		PlayerHarry.TriggerEvent( TriggerOnDeath, none, none );
	}
}

event Expired()
{
//	Log("Report card about expire"@ TimePassed);
}


function bool DrawSandTimer(Canvas canvas, int i, float time)
{
	local float ToDo, done, tmp, amountLeft;

	local int bottleIntlHeight;

	local float bottle_x, bottle_y;
	local float bottle_intl_x, bottle_intl_y;
	local string strNumPoints;


	bottleIntlHeight = 90;
	bottle_intl_x = 50;
	bottle_intl_y = 18;

	bottle_y = 121;

	done = time/2;

	ToDo = housePoints[i].numPoints;
	ToDo /= maxPoints;
	//log("report card: bottle " $i $" fraction to do " $ToDo);

	if (done > toDo)
		done = toDo;

	amountLeft = bottleIntlHeight - (done*bottleIntlHeight);

	//log("report card: bottle " $i $" pixels to do " $ToDo);
	
	Canvas.SetPos(left_x + housePoints[i].sandPosX-bottle_intl_x, 
		top_y + bottle_y + amountLeft
		);

	tmp = bottle_intl_y + amountLeft;
	
	Canvas.DrawTile(housePoints[i].sand, 
		128, 128.0f - tmp,		// width, height
		0, tmp,	// x,y
		128, 128.0f - tmp);						// total size of texture

	// Do text underneath the bottle
	//------------------------------

	Canvas.SetPos(left_x + housePoints[i].sandPosX, top_y+218);

	strNumPoints = string(int(done*maxPoints));

	Canvas.DrawText(strNumPoints);
}

function Draw(Canvas canvas)
{
	local int i;

	local float numbersX, numbersY;

	//log ("report Card Draw");

	// Draw the background
	//--------------------

	Canvas.SetPos(left_x, top_y);
	Canvas.DrawIcon(Texture'ReportPiece1',1.0);

	Canvas.SetPos(left_x + 256, top_y);
	Canvas.DrawIcon(Texture'ReportPiece2',1.0);

	Canvas.SetPos(left_x, top_y + 256);
	Canvas.DrawIcon(Texture'ReportPiece3',1.0);

	Canvas.SetPos(left_x + 256, top_y + 256);
	Canvas.DrawIcon(Texture'ReportPiece4',1.0);

	// Draw the house point bottles
	//-----------------------------

	for (i=0; i<ArrayCount(housePoints); ++i)
	{
		if (housePoints[i].startTime >= 0 &&
			housePoints[i].startTime < TimePassed
			)
			DrawSandTimer(canvas, i, TimePassed - housePoints[i].startTime);
	}

	// Display text for the other collected things ...
	//--------------------------------------------------

	numbersY = top_y + 315;
	numbersX = left_x + 40;

	Canvas.SetPos(numbersX, numbersY);
	Canvas.DrawText( string (0));

	numbersX+= 72;

	Canvas.SetPos(numbersX, numbersY);
	Canvas.DrawText( string (0));

	numbersX+= 72;

	Canvas.SetPos(numbersX, numbersY);
//	Canvas.DrawText( string (playerharry.numBeans));

	numbersX+= 72;

	Canvas.SetPos(numbersX, numbersY);
	Canvas.DrawText( string (PlayerHarry.numStars));
}

defaultproperties
{
     LifeSpan=5
}
