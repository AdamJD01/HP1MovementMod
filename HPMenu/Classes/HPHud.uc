//=============================================================================
// HPHud
//=============================================================================
class HPHud extends baseHUD;


#EXEC TEXTURE IMPORT NAME=frogIcon  FILE=TEXTURES\frogIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=fullPotionIcon  FILE=TEXTURES\fullPotionIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=halfPotionIcon  FILE=TEXTURES\halfPotionIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=EnemyBarFull  FILE=TEXTURES\EnemyBarFull.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=EnemyBarEmpty  FILE=TEXTURES\EnemyBarEmpty.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=EnemyHead1  FILE=TEXTURES\EnemyHead1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=EnemyHead2  FILE=TEXTURES\EnemyHead2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=EnemyHead3  FILE=TEXTURES\EnemyHead3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=EnemyHead4  FILE=TEXTURES\EnemyHead4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=EnemyHead5  FILE=TEXTURES\EnemyHead5.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=EnemyHead6  FILE=TEXTURES\EnemyHead6.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=MalfoyHead	FILE=TEXTURES\MalfoyHead.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=VoldemortHead	FILE=TEXTURES\VoldemortHead.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=PeevesHead	FILE=TEXTURES\PeevesHead.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

//#EXEC TEXTURE IMPORT NAME=FluffyHead	FILE=TEXTURES\HUD\Fluffybar.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=FluffyHeadEmpty   FILE=TEXTURES\HUD\FluffyEmpty.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=FluffyHeadMAwake	FILE=TEXTURES\FluffyHeadMAwake.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=FluffyHeadMAsleep	FILE=TEXTURES\FluffyHeadMAsleep.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

//#exec Font Import File=Textures\Lrgred.pcx Name=LargeRedFont

event Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if(bCountingDown)
	{
		fCountdownTime-=deltaTime;
		if(fCountdownTime<=0)
			fCountDownTime=0;
	}

	if(bScoreCountup)
	{
		fScoreCountTime -= deltaTime;
		if(fScoreCountTime <= 0)
		{
			fScoreCountTime = 0;
			bScoreCountup = false;
		}
	}
}

function DrawSpellIcon(Canvas canvas)
{
local Texture icon;

	icon=baseWand(PlayerPawn(Owner).weapon).GetSpellIcon();

	if(Icon!=None)
		{
		Canvas.SetPos(5,(Canvas.SizeY-64)-5);
		Canvas.DrawIcon(icon,1);
		}
}


function DrawHoops(Canvas canvas, int iNumber, int iMaxNumber)
{
	local int	Ox, Oy;

	Ox = 8;
	Oy = Canvas.SizeY - 156;			// magic numbers I'm afraid, the bitmaps have to be of a certain

	if (iNumber < 10)
	{
		Canvas.SetPos(Ox + 94, Oy + 100);
	}
	else
	{
		Canvas.SetPos(Ox + 85, Oy + 100);
	}
	Canvas.DrawText(iNumber $"/" $iMaxNumber, False);
/*	Canvas.SetPos(Ox + 135,Oy + 104);
	Canvas.DrawText(iMaxNumber , False);*/
//	Ox = Canvas.SizeX / 2 - 128;
//	Oy = Canvas.SizeY - 176;			// magic numbers I'm afraid, the bitmaps have to be of a certain
									// size, and the actual graphic is inside it.
/*	Canvas.SetPos(Ox - 8,Oy + 128 - 10);
	Canvas.DrawText(iNumber, False);
	Canvas.SetPos(Ox + 256,Oy + 128 - 10);
	Canvas.DrawText(iMaxNumber , False);*/
}


function DrawEnemyHealth(Canvas canvas)
{
	local int Ox, Oy;
	local float	Health;
	local texture HealthBar;
	local texture Head;
//	local int number;


	if(baseHarry(owner)==None)
	{
		return;
	}

	if(baseHarry(owner).BossTarget==None)
	{
		return;
	}
	
//	HealthBar = Texture'EnemyBarFull';
	if (baseHarry(owner).BossTarget.IsA('BaseBossQuirrel'))
	{
		HealthBar = Texture'VoldemortHead';
	}
	else if (baseHarry(owner).BossTarget.IsA('Peeves'))
	{
		HealthBar = Texture'PeevesHead';
	}
	else if (baseHarry(owner).BossTarget.IsA('fluffy'))
	{
		//HealthBar = Texture'FluffyHead';
		DrawFluffyEnemyHealth( canvas );
		return;
	}
	else if (baseHarry(owner).BossTarget.IsA('BossRailMove') || baseHarry(owner).BossTarget.IsA('BroomDraco'))
	{
		HealthBar = Texture'MalfoyHead';
	}
	else
	{
		return;		// No bar available
	}


	Ox = 8;
	Oy = Canvas.SizeY - (HealthBar.VSize / 2) - 36;

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawIcon(Texture'EnemyBarEmpty',1);

	Health = baseHarry(owner).BossTarget.GetHealth();
	Health = fclamp( Health, 0, 1.0);

/*	Canvas.SetPos(ox, oy);
	Canvas.DrawTile(HealthBar, HealthBar.USize * Health, HealthBar.VSize, 0, 0, HealthBar.USize * Health, HealthBar.VSize);
*/
	Canvas.SetPos(ox, oy);
	Canvas.DrawTile(HealthBar, (HealthBar.USize - 97 ) * Health + 97, HealthBar.VSize, 0, 0, (HealthBar.USize - 97) * Health + 97, HealthBar.VSize);

/*		// PAB fudge for top and bottom of sand
		// 11 pixels from top, 9 from bottom
//		RealVSize = TimerFull.VSize - 11 - 9;
		Canvas.SetPos(ox, oy + (TimerFull.VSize - 11 - 9) * (1 - TimeRemaining) + 11);
		Canvas.DrawTile(TimerFull, TimerFull.USize, (TimerFull.VSize - 20) * TimeRemaining + 9, 0, (TimerFull.VSize - 11 - 9 ) * (1 - TimeRemaining) + 11, TimerFull.USize, (TimerFull.VSize - 20) * TimeRemaining + 9);
*/
	Ox = HealthBar.USize;
	Oy = Canvas.SizeY - HealthBar.VSize - 8;
	Canvas.SetPos(ox, oy);

//	Ox = 8 + HealthBar.USize - 24;
//	Oy += 25;

/*	if (Health > 1.0 * 5 / 6)
	{
		Head = Texture'EnemyHead1';
	}
	else if (Health > 1.0 * 4 / 6)
	{
		Head = Texture'EnemyHead2';
	}
	else if (Health > 1.0 * 3 / 6)
	{
		Head = Texture'EnemyHead3';
	}
	else if (Health > 1.0 * 2 / 6)
	{
		Head = Texture'EnemyHead4';
	}
	else if (Health > 1.0 * 1 / 6)
	{
		Head = Texture'EnemyHead5';
	}
	else
	{
		Head = Texture'EnemyHead6';
	}
*/

/*	Ox = HealthBar.USize;
	Oy = Canvas.SizeY - Head.VSize - 8;
	Canvas.SetPos(ox, oy);
	Canvas.DrawIcon(Head, 1);*/
}

//****************************************************************************************************************************************
function DrawFluffyEnemyHealth(Canvas canvas)
{
	local int     Ox, Oy;
	local float	  Health;
	local Texture HealthBar;
	local int     iAsleep; //1 if asleep, 0 if not
	local int     Border, HeadWidth;

	Border = 8;
	HeadWidth = 38;

	//First bar
	Health = baseHarry(owner).BossTarget.GetSpecialHealth(2, iAsleep);
	Health = fclamp( Health, 0, 1.0);

	if( iAsleep == 1 )
		HealthBar = texture'FluffyHeadMAsleep';
	else
		HealthBar = texture'FluffyHeadMAwake';

	Ox = Border;
	Oy = Canvas.SizeY - (HealthBar.VSize / 2) - 36;

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawIcon(Texture'EnemyBarEmpty',1);

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawTile(HealthBar, (HealthBar.USize - HeadWidth ) * Health + HeadWidth, HealthBar.VSize, 0, 0, (HealthBar.USize - HeadWidth) * Health + HeadWidth, HealthBar.VSize);

	//Second bar
	Health = baseHarry(owner).BossTarget.GetSpecialHealth(1, iAsleep);
	Health = fclamp( Health, 0, 1.0);

	if( iAsleep == 1 )
		HealthBar = texture'FluffyHeadMAsleep';
	else
		HealthBar = texture'FluffyHeadMAwake';

	Ox = Canvas.SizeX/2 - HealthBar.USize/2;
	Oy = Canvas.SizeY - (HealthBar.VSize / 2) - 36;

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawIcon(Texture'EnemyBarEmpty',1);

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawTile(HealthBar, (HealthBar.USize - HeadWidth ) * Health + HeadWidth, HealthBar.VSize, 0, 0, (HealthBar.USize - HeadWidth) * Health + HeadWidth, HealthBar.VSize);

	//Third bar
	Health = baseHarry(owner).BossTarget.GetSpecialHealth(0, iAsleep);
	Health = fclamp( Health, 0, 1.0);

	if( iAsleep == 1 )
		HealthBar = texture'FluffyHeadMAsleep';
	else
		HealthBar = texture'FluffyHeadMAwake';

	Ox = Canvas.SizeX - Border - HealthBar.USize;
	Oy = Canvas.SizeY - (HealthBar.VSize / 2) - 36;

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawIcon(Texture'EnemyBarEmpty',1);

	Canvas.SetPos(Ox, Oy);
	Canvas.DrawTile(HealthBar, (HealthBar.USize - HeadWidth ) * Health + HeadWidth, HealthBar.VSize, 0, 0, (HealthBar.USize - HeadWidth) * Health + HeadWidth, HealthBar.VSize);


	//Ox = HealthBar.USize;
	//Oy = Canvas.SizeY - HealthBar.VSize - Border;
	//Canvas.SetPos(ox, oy);
}

//****************************************************************************************************************************************
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

simulated function bool DisplayMessages(canvas Canvas)
{
	if(HPConsole(playerpawn(owner).player.console).bDebugMode)
		return(false);	//allow base class to draw messages

	return true;	//tell base class not to draw messages
}

function DrawHudItems(Canvas canvas)
{
	if(BeanItem==None)
	{
		BeanItem=spawn(class'BeansHudItem');
		BeanItem.playerHarry=baseHarry(owner);
	}
	else
	{
		BeanItem.Paint(canvas);
	}


	if(SeedItem==None)
	{
		SeedItem=spawn(class'SeedHudItem');
		SeedItem.playerHarry=baseHarry(owner);
	}
	else
	{
		SeedItem.Paint(canvas);
	}

	if(StarItem==None)
	{
		StarItem=spawn(class'StarHudItem');
		StarItem.playerHarry=baseHarry(owner);
	}
	else
	{
		StarItem.Paint(canvas);
	}

	if(PointItem==None)
	{
		PointItem=spawn(class'PointHudItem');
		PointItem.playerHarry=baseHarry(owner);
	}
	else
		PointItem.Paint(canvas);
}

simulated function PostRender( canvas Canvas )
{
	local FEBook menuBook;

	HUDSetup(canvas);

	if ( PlayerPawn(Owner) != None )
		{
		if ( PlayerPawn(Owner).PlayerReplicationInfo == None )
			return;
		}

	menuBook = HPConsole(playerpawn(owner).player.console).MenuBook;
	if (menuBook != None)
	{
		if (menuBook.bIsOpen)
			return;
	}

	DrawCutSceneBoarder(Canvas);
	DrawIconMessages(Canvas);

	DrawHudItems(canvas);

	if(!bCutSceneMode)
		{	

		DrawHealth(Canvas);
		DrawCountdown(Canvas);
		DrawEnemyHealth(Canvas);
		// @PAB debug info
//		DrawDebug(Canvas);

		}

	DrawPopup(Canvas);		//moved here by gk 7/26 to allow popup during cutscene
							// PAB 10/18 Moved here so that they appear on top of health etc

}

defaultproperties
{
}
