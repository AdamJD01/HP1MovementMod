class baseConsole expands WindowConsole;

//Edited by- AdamJD (edited code will have AdamJD by it)

var bool	bLeftKeyDown;
var bool	bRightKeyDown;
var bool	bForwardKeyDown;
var bool	bBackKeyDown;
var bool	bUpKeyDown;
var bool	bDownKeyDown;
var bool	bRotateLeftKeyDown;
var bool	bRotateRightKeyDown;
var bool	bRotateUpKeyDown;
var bool	bRotateDownKeyDown;


var bool bSpaceReleased;
var bool bSpacePressed;

var globalconfig bool bDebugMode; //this was already here in the retail code but was only set up to be typed in game... -AdamJD
var globalconfig bool bUseSystemFonts;

var bool bUseAsianFont;
var bool bUseThaiFont;
var string LanguageCode;

var font LocalHugeFont,LocalBigFont,LocalMedFont,LocalSmallFont,LocalIconMessageFont;
var font LocalTinyFont;


	//overridden in hpconsole
function SaveSelectedSlot()
{
}
	//overridden in hpconsole
function LoadSelectedSlot()
{
}

	//overridden in hpconsole
function ChangeLevel(string lev,bool flag)
{
}

function DrawLevelAction( canvas C )
{
	local string BigMessage;
	local float	fTextWidth, fTextHeight;

	if ( (Viewport.Actor.Level.Pauser != "") && (Viewport.Actor.Level.LevelAction == LEVACT_None) )
	{
		C.Font = C.MedFont;
		BigMessage = PausedMessage; // Add pauser name?
		PrintActionMessage(C, BigMessage);
		return;
	}
	if ( (Viewport.Actor.Level.LevelAction == LEVACT_None)
		 || Viewport.Actor.bShowMenu )
	{
		BigMessage = "";
		return;
	}
	else if ( Viewport.Actor.Level.LevelAction == LEVACT_Loading )
	{
		BigMessage = LoadingMessage;
	}
	else if ( Viewport.Actor.Level.LevelAction == LEVACT_Saving )
	{
		BigMessage = Localize("all","nearly_nick_40","HPDialog");

//		BigMessage = SavingMessage;
	}
	else if ( Viewport.Actor.Level.LevelAction == LEVACT_Connecting )
	{
		BigMessage = ConnectingMessage;
	}
	else if ( Viewport.Actor.Level.LevelAction == LEVACT_Precaching )
	{
		BigMessage = PrecachingMessage;
	}
	
	if ( BigMessage != "" )
	{
		C.Style = 1;

		C.TextSize(BigMessage, fTextWidth, fTextHeight);

		if (fTextWidth > (C.SizeX - 32))
		{
			C.Font = LocalMedFont;	
		}
		else
		{
			C.Font = LocalBigFont;	
		}
		PrintActionMessage(C, BigMessage);
	}
}

defaultproperties
{
     bUseSystemFonts=True
	 //bDebugMode=True //old default prop added by me, debug mode is now not hard coded and can be turned on by changing bDebugMode=False to bDebugMode=True in the HP.ini config file or by typing "HarryDebugModeOn" in game -AdamJD
	 bDebugMode=False //debug mode is now turned off by default and can be turned off by pressing F7 in game if turned on -AdamJD
}
