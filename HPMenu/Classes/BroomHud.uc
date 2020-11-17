//=============================================================================
// BroomHud - HUD for use during Broom Practice (Tut2)
//=============================================================================
class BroomHud extends HPHud;

#EXEC TEXTURE IMPORT NAME=ProgressBarFull  FILE=TEXTURES\ProgressBarFull.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ProgressBarEmpty  FILE=TEXTURES\ProgressBarEmpty.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=EmptyHoop  FILE=TEXTURES\EmptyHoop.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=HoopTimer  FILE=TEXTURES\HoopTimer.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=KeyBar  FILE=TEXTURES\KeyBar.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=SnitchBar  FILE=TEXTURES\SnitchBar.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

//Add to your harry
//HUDType=class'HPMenu.BroomHud';

var int CurrentNumberHoops;
var int MaxNumberHoops;
var bool bDrawHoopCount;
var bool bDrawHoopProgressBar;

enum EHoopBarType
{
	BT_Practice,
	BT_Quidditch,
	BT_FlyingKeys
};

var texture	HoopBar;

function PreBeginPlay()
{
	// Initialize
	Super.PreBeginPlay();

	CurrentNumberHoops = 0;
	MaxNumberHoops = 99;
	bDrawHoopCount = false;
	QHUDGame = none;
}

function SetHoopBarType(EHoopBarType HoopBarType)
{
	switch(HoopBarType)
	{
		case BT_Practice:
			HoopBar = Texture'HoopTimer';
			break;

		case BT_Quidditch:
			HoopBar = Texture'SnitchBar';
			break;

		case BT_FlyingKeys:
			HoopBar = Texture'keybar';
			break;
	}
}

function SetHoopCounts( int NewCurrentNumberHoops, int NewMaxNumberHoops )
{
	CurrentNumberHoops = NewCurrentNumberHoops;
	MaxNumberHoops = NewMaxNumberHoops;
}

function EnableHoopCountDraw( bool bEnable )
{
	bDrawHoopCount = bEnable;
}

function EnableHoopBarDraw( bool bEnable )
{
	bDrawHoopProgressBar = bEnable;
}

function DrawHoopBar(Canvas canvas, int CurrentNumberHoops, int MaxNumberHoops)
{
	local int		Ox, Oy;
	local float		fHoops;

	local Texture	EmptyBar;

	if (HoopBar == none)
	{
		return;
	}

	Ox = 8;
	Oy = Canvas.SizeY - 156;			// magic numbers I'm afraid, the bitmaps have to be of a certain
									// size, and the actual graphic is inside it.

	EmptyBar = Texture'TimerBarEmpty';
	Canvas.SetPos(Ox,Oy);
	Canvas.DrawIcon(HoopBar,1);

	fHoops = fclamp( float(CurrentNumberHoops) / float(MaxNumberHoops), 0, 1.0);

	Canvas.SetPos(ox + 97 + (fHoops * (EmptyBar.Usize - 97)), oy);
	Canvas.DrawTile(EmptyBar, (EmptyBar.USize - 97 ) * (1 - fHoops) + 97, EmptyBar.VSize, 97 + (fHoops * (EmptyBar.Usize - 97)), 0, (EmptyBar.USize - 97 ) * (1 - fHoops) + 97, EmptyBar.VSize);
}

simulated function PostRender( canvas Canvas )
{
	HUDSetup(canvas);

	if ( PlayerPawn(Owner) != None )
	{
		if ( PlayerPawn(Owner).PlayerReplicationInfo == None )
			return;

	}

	DrawCutSceneBoarder(Canvas);
	DrawIconMessages(Canvas);

	if ( bCutSceneMode  || curIconMessage.valid)
	{
		DrawPopup(Canvas);

//		DrawPoints(Canvas);
//		DrawBeans(Canvas);

//		DrawCountdown(Canvas);
	}
	else
	{		
		DrawPopup(Canvas);

//		DrawPoints(Canvas);
//		DrawBeans(Canvas);
//		DrawFrogs(Canvas);
		DrawCountdown(Canvas);

		if (bDrawHoopProgressBar)
		{
			DrawHoopBar(Canvas, CurrentNumberHoops, MaxNumberHoops);
		}

		if ( bDrawHoopCount )
		{
			DrawHoops(Canvas, CurrentNumberHoops, MaxNumberHoops);
		}

		if ( bPlayQHUDGame )
		{
			if(QHudGame == None)
			{
				QHudGame = spawn(class'BaseQHudGame');
				QHudGame.Player = baseHarry(owner);
				if (HUDGameType == HUDG_QUIDDITCH)
				{
					QHudGame.SetQuidditchMatch();
				}
				else
				{
					QHudGame.SetFlyingKeys();
				}
			}
			else
			{
				QHudGame.Paint(canvas);
			}
		}
	}


//	DrawDebug(Canvas);
}

defaultproperties
{
}
