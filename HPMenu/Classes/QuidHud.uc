//=============================================================================
// QuidHud - HUD for use during Quidditch matches
//=============================================================================
class QuidHud extends BroomHUD;

//Add to your harry
//HUDType=class'HPMenu.QuidHud';

function bool HUDGameGrab()
{
	return QHudGame.Grab();
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
	}
	else
	{
		DrawHealth(Canvas);
		DrawPopup(Canvas);			// PAB 10/18 Moved after health so it appears on top of it
		DrawEnemyHealth(Canvas);	// Used in Remembrall Chase

		if (bDrawHoopProgressBar)
		{
			DrawHoopBar(Canvas, CurrentNumberHoops, MaxNumberHoops);
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
		else
		{
			if(QHudGame != None)
			{
				QHudGame.Destroy();
				QHudGame = None;
			}
		}
	}

//	DrawDebug(Canvas);
}

defaultproperties
{
}
