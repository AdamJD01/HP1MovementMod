class SpellLessonFinalScore expands basePopup;


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
	local string LessonText;

	local color	SaveColor;
	local float fTextWidth, fTextHeight;

	saveFont=canvas.font;
	SaveColor = canvas.DrawColor;

	canvas.font = baseconsole(PlayerHarry.player.console).LocalBigFont;
	canvas.DrawColor.r = 255;
	canvas.DrawColor.g = 255;
	canvas.DrawColor.b = 0;

	LessonText = Localize("all","lesson_text_03","Pickup");
	Canvas.TextSize(LessonText, fTextWidth, fTextHeight);
	Canvas.SetPos((Canvas.SizeX / 2) - (fTextWidth / 2), (Canvas.SizeY / 2) - 40);
//	Canvas.SetPos((Canvas.SizeX / 2) - 160, (Canvas.SizeY / 2) - 40);
	Canvas.DrawText(LessonText $" " $PlayerHarry.iLevelReached $"/4", False);

	switch (PlayerHarry.iLessonPoints)
	{
		case 5:
			LessonText = Localize("all","lesson_text_04","Pickup");
			break;

		case 15:
			LessonText = Localize("all","lesson_text_05","Pickup");
			break;

		case 30:
			LessonText = Localize("all","lesson_text_06","Pickup");
			break;

		case 50:
			LessonText = Localize("all","lesson_text_07","Pickup");
			break;

	}

	Canvas.TextSize(LessonText, fTextWidth, fTextHeight);
	Canvas.SetPos((Canvas.SizeX / 2) - (fTextWidth / 2), (Canvas.SizeY / 2));

	Canvas.DrawText(LessonText, False);

	canvas.font = saveFont;
	canvas.DrawColor = SaveColor;
}

defaultproperties
{
     fMaxTime=5
     LifeSpan=5
}
