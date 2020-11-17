class SpellLessonScore expands basePopup;

var baseHarry	PlayerHarry;
var float		fMaxTime;

function PostBeginPlay()
{
	// Find Harry!
	foreach AllActors( class'baseHarry', PlayerHarry )
	{
		break;
	}

	Super.PostBeginPlay();
}

function Draw(Canvas canvas)
{
	local font	saveFont;
	local float fScore;
	local int	iScore;
	local int	iPassMark;
	local int	iDecimal;
	local string	LessonText;

	local color		SaveColor;
	local float		fTextWidth, fTextHeight;

	iScore = int(PlayerHarry.LessonScore * 100);
	iPassMark = int(PlayerHarry.LessonPass * 100);
	iDecimal = int(PlayerHarry.LessonScore * 1000) - (iScore * 10);

//	log("SpellLessonScore: show score " $iScore $"." $iDecimal $"%");

	saveFont=canvas.font;
	SaveColor = canvas.DrawColor;

	canvas.font = baseconsole(PlayerHarry.player.console).LocalBigFont;
	canvas.DrawColor.r = 255;
	canvas.DrawColor.g = 255;
	canvas.DrawColor.b = 0;

//	Canvas.SetPos((Canvas.SizeX / 2) - 64, Canvas.SizeY / 2);

	if (iScore >= 0)
	{

		if (baseHUD(PlayerHarry.myHUD).bScoreCountUp)
		{
			iScore = iScore * (baseHUD(PlayerHarry.myHUD).fMaxScoreCountTime - baseHUD(PlayerHarry.myHUD).fScoreCountTime) / baseHUD(PlayerHarry.myHUD).fMaxScoreCountTime;
//			baseHUD(PlayerHarry.myHUD).DebugString2 = "TRUE";
		}
		else
		{
//			baseHUD(PlayerHarry.myHUD).DebugString2 = "FALSE";
		}

		baseHUD(PlayerHarry.myHUD).DebugValA = baseHUD(PlayerHarry.myHUD).fScoreCountTime;


		LessonText = Localize("all","lesson_text_02","Pickup");
		Canvas.TextSize(LessonText, fTextWidth, fTextHeight);
//		Canvas.SetPos((Canvas.SizeX / 2) - 64, Canvas.SizeY - 80);
		Canvas.SetPos((Canvas.SizeX / 2) - (fTextWidth / 2), Canvas.SizeY - 80);
		Canvas.DrawText(LessonText $" " $iScore $"%", False);

		LessonText = Localize("all","lesson_text_01","Pickup");
		Canvas.TextSize(LessonText, fTextWidth, fTextHeight);
		Canvas.SetPos((Canvas.SizeX / 2) - (fTextWidth / 2), Canvas.SizeY - 48);
//		Canvas.SetPos((Canvas.SizeX / 2) - 96, Canvas.SizeY - 48);
		Canvas.DrawText(LessonText $" " $iPassMark $"%", False);
	}
	else
	{
		Canvas.SetPos(32, Canvas.SizeY - 48);
		LessonText = Localize("all","lesson_text_01","Pickup");
		Canvas.DrawText(LessonText $" " $iPassMark $"%", False);
	}

	canvas.font=saveFont;
	canvas.DrawColor = SaveColor;
}

defaultproperties
{
     fMaxTime=3
     LifeSpan=0
}
