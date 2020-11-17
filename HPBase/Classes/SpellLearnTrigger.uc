//=============================================================================
// SpellLearnTrigger -- manager class for spell-learning sequence.
//=============================================================================

class SpellLearnTrigger extends Trigger;

var(Spells) class<BaseSpell>	Spell;

var(Spells) class<SpellLearnFX> LearnFXClass[3];
var(Spells) class<Actor> WandClass;
var(Spells) class<ParticleFX> WandFXClass[3];
var(Spells) class<ParticleFX> DrawFXClass[3];
var(Spells) class<ParticleFX> WinFXClass[3];

var(Spells) sound	CastSound;

var(Spells) float TemplateDist, WandDist;
var(Spells) float DrawTime;
var(Spells) float FOVRatio;

var(Spells) float fAccuracy;
var(Spells) float fDecayTime;

var vector OriginalLocation;

var(Spells) BaseChar Teacher;

var(NextTrigger) name	NextTriggerEvent;
var float fCountdown;

var(Strings) string	LessonIntro[10];
var(Strings) string	LessonJudgeVBad[10];
var(Strings) string	LessonJudgeFailure[10];
var(Strings) string	LessonJudgeSuccess[10];
var(Strings) string	LessonJudgeVGood[10];
var(Strings) string	LessonRepeatFailure[10];
var(Strings) string	LessonRepeatSuccess[10];
var(Strings) string	LessonFullMarks;

var(Strings) string LessonPoints[4];

var(Spells) float fVGoodThreshold;
var(Spells) float fVBadThreshold;
var(Spells) int	  iNumHousePoints[10];

var bool			bFirstTime;

var BaseHarry Player;				// Player we're controlling.
var BaseCam Cam;
var Gesture SpellGesture;				// Pattern of spell we're learning.

// Created actors.
var Actor Wand;
var ParticleFX WandFX, DrawFX, ReDrawFX;

var SpellBlackboard LessonBlackboard;

// Temp vars.
var int SpellLevel;
var bool bSaveSmoothing;
var float WandX, WandY;
var float TimeDrawn;
var float TotalDrawnTime;
var bool bCountedUp;

var array<vector> DrawnPoints;

var	float		TemplateDrawTime;

var CamTarget TempActor;
var class<actor> tempClass;
var float CameraDist;

var float Success;

var SpellLearnFX TemplateFX;

var float	PassMark[10];
var int		LessonLevel;
var int		TotalHousePointScore;

var bool	bStartedDrawing;

var ParticleFX	BadPointFX;
var int			iPoint;
var float		fDist;

var int			iFirstPoint, iLastPoint;

var sound		outSound;
var string		outText;

var float		fSoundDuration;

enum eSpellLevel
{
	SL_Bronze,
	SL_Silver,
	SL_Gold,
};

function Trigger(actor Other, pawn EventInstigator)
{
	local int	i;

	// Find Harry
	foreach AllActors(class'baseharry', Player)
	{
		if( Player.bIsPlayer && Player != Self)
		{
			break;
		}
	}

	Cam = Player.Cam;
	Cam.SaveState();
	SpellGesture = Spell.default.Gesture;

	// Test
/*	for (i = 0; i < int(SpellGesture.Points); i ++)
	{
		log("Spell lesson points " $i $" of " $int(SpellGesture.Points) $SpellGesture.Points[i].x $SpellGesture.Points[i].y);
	}
*/
	bSaveSmoothing = Player.bMaxMouseSmoothing;
	Player.bMaxMouseSmoothing = false;

	// We can't fail this lesson, add the spell to Harry now
	BaseWand(Player.Weapon).AddSpell(Spell);

	// Put player in right state.
	BaseWand(Player.Weapon).SelectSpell(Spell);

	Player.gotoState('SpellLearning');

	// Halt the player.
	Player.Velocity = vect(0,0,0);
	Player.Acceleration = vect(0,0,0);
	Player.PlayAnim('breathe');

	TempActor = Spawn(class'camtarget');
	TempActor.GotoState('Free');
	TempActor.SetLocation(Location + (vec(TemplateDist,0,0) >> Rotation));
	Cam.DirectionActor = TempActor;
	// Change the camera mode.
	Cam.PositionActor = none;
	CameraDist = 20;	// Hard code for the mo
	Cam.GotoState('CutState');
	Cam.SetLocation(Location + (vec(CameraDist,0,0) >> Rotation));
	Cam.SetRotation(rotator(TempActor.Location - Location));

	// Init spell level.
	SpellLevel = 0;

	TemplateDrawTime = DrawTime / 4;

	LessonLevel = 0;
	TotalHousePointScore = 0;

	LessonBlackboard = spawn(class'spellblackboard', 
		[SpawnLocation] Location + (vec(TemplateDist + 50, 0, 0) >> Rotation) );

/*
	if (LessonBlackboard == none)
	{
		log("Blackboard is none");
	}
	else
	{
		log("Blackboard is OK");
	}
*/

	if (Teacher != none)
	{
		Teacher.GotoState('idle');
	}

	bFirstTime = true;
	gotoState('Template', 'Init');
}

function TriggerNext()
{
	local actor A;

	if( Event != '' )
	{
		player.clientMessage("Triggering next trigger ");
		foreach AllActors( class 'Actor', A, Event )
		{
			A.Trigger(self, self.instigator);
			player.clientMessage("Next trigger's actor is " $string(a.name));
		}
	}
}

event Destroyed()
{
	// Score the house points

//	player.AddHousePoints(iNumHousePoints[LessonLevel - 1]);
	

	// Done.
	Cam.RestoreState();
//	Cam.gotoState('StandardState');
	Player.gotoState('PlayerWalking');
	Player.bSkipKeyPressed = false;

	Player.bMaxMouseSmoothing = bSaveSmoothing;
	DestroyWand();
	DestroyTemplate();
	TempActor.Destroy();
	TempActor = none;
	Cam.DirectionActor = none;

	LessonBlackboard.Destroy();

	if (Teacher != none)
	{
		Teacher.loopanim('breathe',,1);
	}

	TriggerNext();

	Super.Destroyed();
}

function DestroyWand()
{
	Wand.Destroy();
	WandFX.Destroy();
	DrawFX.Destroy();
	ReDrawFX.Destroy();
}

function DestroyTemplate()
{
	TemplateFX.Destroy();
}

function ClearArray()
{
	local int n;

	n = 0;
	while (n < 500)
	{
		DrawnPoints[n] = vec(0, 0, -1);	// Z set to -1 is used to denote unused
		n = n + 1;
	}
}

// Functions.
function DrawTemplate(int SpellLevel)
{
	// Spawn an appropriate particle system in front of us.
//	local SpellLearnFX TemplateFX;
	TemplateFX = Cam.Spawn( class'SpellLearnFX', 
		[SpawnLocation] Cam.Location + (vec(TemplateDist,0,0) >> Cam.Rotation) );

	TemplateFX.DrawSpell( SpellGesture, TemplateDist*FOVRatio, TemplateDrawTime, SpellLevel, fAccuracy, fDecayTime);
}

function DrawWinFX()
{
	local particlefx Winfx;

	// Spawn an appropriate particle system in front of us.

	Winfx = Cam.Spawn( Spell.default.hitParticleEffectClass,
		[SpawnLocation] Cam.Location + (vec(TemplateDist,0,0) >> Cam.Rotation) );
	
	Winfx.DrawScale = TemplateDist*FOVRatio;
	Winfx.Pattern = SpellGesture;
	Winfx.Period.Base = 0.f;
	Winfx.Period.Rand = 1.f;
    Winfx.SizeWidth.Base=12.000000;
	Winfx.SizeLength.Base=12.000000;
	Winfx.Lifetime.Base = 3.0;

	Winfx = Cam.Spawn( WinFXClass[2],
		[SpawnLocation] Cam.Location + (vec(TemplateDist,0,0) >> Cam.Rotation) );

	Winfx.DrawScale = TemplateDist*FOVRatio;
	Winfx.Pattern = SpellGesture;
	Winfx.Period.Base = 0.f;
	Winfx.Period.Rand = 1.f;
    Winfx.SizeWidth.Base=12.000000;
	Winfx.SizeLength.Base=12.000000;
	Winfx.Lifetime.Base = 3.0;

//	RewardSequence();
}

function DrawLoseFX()
{
	local particlefx Losefx;

	// Spawn an appropriate particle system in front of us.

	Losefx = Cam.Spawn( class'RewardFail',
		[SpawnLocation] Cam.Location + (vec(TemplateDist,0,0) >> Cam.Rotation) );

	Losefx.DrawScale = TemplateDist*FOVRatio;
	Losefx.Pattern = SpellGesture;
	Losefx.Period.Base = 0.f;
	Losefx.Period.Rand = 1.f;
/*    Losefx.SizeWidth.Base=12.000000;
	Losefx.SizeLength.Base=12.000000;
	Losefx.Lifetime.Base = 3.0;*/
}

function TeacherSpeaks()
{
	local int	iRand;

	if (Teacher != none)
	{
		Teacher.loopanim('talk',,1);
	}
}

function TeacherDrawsSpell()
{
	if (Teacher != none)
	{
		if (Spell.default.class == class'spellAloho')
		{
			Teacher.Gotostate('SpellLesson');
		}
		else if (Spell.default.class == class'spellflip')
		{
			Teacher.PlayAnim('flipendo');
		}
		else if (Spell.default.class == class'spellIncendio')
		{
			Teacher.PlayAnim('Incendio');
		}
		else if (Spell.default.class == class'spellLev')
		{
			Teacher.PlayAnim('Wingardium');
		}
		else if (Spell.default.class == class'spellLumas')
		{
			Teacher.PlayAnim('Lumos');
		}
	}
}

function float SayIntro()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonIntro[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonIntro[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5.0;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayPoints(int iLevel)
{
	local string	Text;
	local sound		dlgSound;

	player.theNarrator.FindDialog(LessonPoints[iLevel], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayJudgeVBad()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonJudgeVBad[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonJudgeVBad[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayJudgeFailure()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonJudgeFailure[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonJudgeFailure[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayJudgeSuccess()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonJudgeSuccess[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonJudgeSuccess[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayJudgeVGood()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonJudgeVGood[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonJudgeVGood[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayRepeatFailure()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonRepeatFailure[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonRepeatFailure[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

function float SayRepeatSuccess()
{
	local int		iString;
	local int		iNumber;
	local string	Text;
	local sound		dlgSound;

	for (iNumber = 0; iNumber < 10 && LessonRepeatSuccess[iNumber] != ""; iNumber ++)
	{
	}

	iString = rand(iNumber);
	player.theNarrator.FindDialog(LessonRepeatSuccess[iString], dlgSound, text);

	if (dlgSound!=None)
	{
		PlaySound(dlgSound, SLOT_Talk);
		fSoundDuration = GetSoundDuration(dlgSound) + 1;
	}
	else
	{
		fSoundDuration = 5;
	}
	player.ReceiveIconMessage(None, text, fSoundDuration);

	return fSoundDuration;
}

state Template
{
init:

	player.MoveSmooth(Location - player.Location) ;
//	Cam.MoveSmooth(Location + (vec(CameraDist,0,0) >> Rotation) - cam.Location);
	sleep(2.0);
	player.Turntoward(TempActor);

	if (Teacher != none)
	{
		Teacher.Turntoward(Cam);
	}

	// Make sure wand is visible.
	TemplateDist = Max(TemplateDist, WandDist+5);

begin:

	player.LessonScore = -1;	// Stop your grade from being displayed
	player.LessonPass = PassMark[LessonLevel];

	// Make sure the camera is in the correct place
	Cam.SetLocation(Location + (vec(CameraDist,0,0) >> Rotation));

	// Draw the spell template, and wait the same time.
	// This has to be done here as sleep is not accepted outside....
	ClearArray();

	baseHUD(player.myHUD).DestroyPopup();
	baseHud(player.myhud).bCutSceneMode=true;

	TeacherSpeaks();

	if (LessonLevel == 0)
	{
		if (bFirstTime)
		{
			fSoundDuration = SayIntro();
		}
		else
		{
			fSoundDuration = SayRepeatFailure();
		}
	}
	else
	{
		fSoundDuration = SayRepeatSuccess();
	}

	bFirstTime = false;

//	player.ReceiveIconMessage(None,IntroMsg[0],3.0);

	TeacherDrawsSpell();

	DrawTemplate(SpellLevel);

//	fCountdown = TemplateDrawTime;
	sleep(fSoundDuration);

/*	if (IntroMsg[1] != "")
	{
		player.ReceiveIconMessage(None,IntroMsg[1],3.0);

		fCountdown = 3.0;
		while (fCountdown > 0 && Player.bSkipKeyPressed)
		{
			sleep(0.5);
			fCountdown -= 0.5;
		}
		Player.bSkipKeyPressed = true;
	}*/
//	PlaySound(sound'spell_example_loop', SLOT_Interact, 0);
	Teacher.loopanim('breathe',,1);
	baseHud(player.myhud).bCutSceneMode=false;
	baseHUD(player.myHUD).ShowPopup(class'SpellLessonScore');

	gotoState('Draw');
}

state Draw
{
	function Tick( float DeltaTime )
	{
		local vector d;
		local int n;

		Super.Tick(DeltaTime);

		// Get mouse input, and move wand.
		WandX = FClamp( WandX + (Player.SmoothMouseX * 30 * deltatime ) / 64000.0, -1.0, 1.0 );
		WandY = FClamp( WandY + (Player.SmoothMouseY * 30 * deltatime ) / 64000.0, -1.0, 1.0 );
		WandX = FClamp( WandX + (Player.asidemove * 20 * deltatime ) / 64000.0, -1.0, 1.0 );
		WandY = FClamp( WandY + (Player.aformove * 20 * deltatime ) / 64000.0, -1.0, 1.0 );
		d = vec(1, WandX*FOVRatio, WandY*FOVRatio) * WandDist;
		Wand.SetLocation( Cam.Location + (d >> Rotation) );
		WandFX.SetLocation( Wand.Location );
		DrawFX.SetLocation( Wand.Location );

		BaseHUD(player.MyHUD).DebugValX2 = Player.astrafe;
		BaseHUD(player.MyHUD).DebugValY2 = Player.aturn;
		BaseHUD(player.MyHUD).DebugValZ2 = Player.aSideMove;

		if (TimeDrawn == 0)
		{
			basehud(player.myhud).StartCountdown(DrawTime);
		}

		if( Player.bAltFire != 0 && TimeDrawn <= DrawTime)
		{
			if (!bStartedDrawing)
			{
				bStartedDrawing = true;
				
				// AE:
				PlaySound( sound'HPSounds.magic_sfx.spell_learn_begin_02' );
				Wand.PlaySound(sound'HPSounds.magic_sfx.spell_learn_trace_08', SLOT_Interact);
			}

		// Enable particles.
			DrawFX.ParticlesPerSec = DrawFX.default.ParticlesPerSec;

		// Store the points, converted to (0..1, 1..0)
			n = 500 * TimeDrawn / DrawTime;
			if( n < 500 )
			{
				DrawnPoints[n] = vec(WandX+0.5, 0.5-WandY, 0);
/*				fDist = SpellGesture.CompareGesturePoint(DrawnPoints[n], fAccuracy);

				log("Point " $n $" is out by " $fDist);*/
			}
		}
		else if( (TimeDrawn > 0.0 && bStartedDrawing) || TimeDrawn > DrawTime)
		{
			gotostate('judge');
		}
		else
		{
			DrawFX.ParticlesPerSec.Base = 0;
			DrawFX.LastEmitLocation = DrawFX.Location;
		}
		TimeDrawn += DeltaTime;
	}

begin:
	// Go into mouse drawing mode.

	bStartedDrawing = false;
	WandX = SpellGesture.Points[0].x - 0.5;
	WandY = 0.5 - SpellGesture.Points[0].y;
	Wand = Cam.Spawn( WandClass, 
		[SpawnLocation] Cam.Location + (vec(WandDist,WandX * WandDist, WandY * WandDist) >> Cam.Rotation),
		[SpawnRotation] rot(-5000,0,5000) );
//		[SpawnRotation] rot(-5000,0,-27000) );
	WandFX = Cam.Spawn( WandFXClass[SpellLevel], [SpawnLocation] Wand.Location );
	DrawFX = Cam.Spawn( DrawFXClass[SpellLevel], [SpawnLocation] Wand.Location );

	TimeDrawn = 0.0;
	if (SpellLevel > 0)
	{
//		DrawTime *= 0.75;
		DrawTime *= 0.95;
//		fDecayTime *= 0.5;
//		fAccuracy *= 0.75;
	}

	// Force drawing particles to last the designated time, and fade out just before.
/*	DrawFX.AlphaDelay = DrawTime*0.9;
	DrawFX.ColorDelay = DrawTime*0.9;
	DrawFX.SizeDelay = DrawTime*0.9;
	DrawFX.Lifetime.Base = DrawTime;
	DrawFX.Lifetime.Max = 0;
	DrawFX.Lifetime.Rand = 0;*/
//	DrawFX.Lifetime.Base = 0;
    DrawFX.SizeWidth.Base = 5.0;
    DrawFX.SizeLength.Base = 5.0;
}

function RewardSequence()
{
	local	Reward01 RewardFX;

	RewardFX = Cam.Spawn( class'Reward01', 
		[SpawnLocation] Cam.Location + (vec(TemplateDist, Rand(50) - 25, Rand(50) - 25) >> Cam.Rotation) );
	RewardFX = Cam.Spawn( class'Reward01', 
		[SpawnLocation] Cam.Location + (vec(TemplateDist, Rand(50) - 25, Rand(50) - 25) >> Cam.Rotation) );
	RewardFX = Cam.Spawn( class'Reward01', 
		[SpawnLocation] Cam.Location + (vec(TemplateDist, Rand(50) - 25, Rand(50) - 25) >> Cam.Rotation) );
	RewardFX = Cam.Spawn( class'Reward01', 
		[SpawnLocation] Cam.Location + (vec(TemplateDist, Rand(50) - 25, Rand(50) - 25) >> Cam.Rotation) );

}

state Judge
{

	function Tick( float DeltaTime )
	{
		local	int		Startn, Endn;
		local	vector	TargetPoint;
		local	vector	d;
		local	vector	PrevPoint;
		local	int		iNumberPoints;

		if (!bStartedDrawing)
		{
			bCountedUp = true;
			disable('Tick');
			return;
		}

		// Let's trace the path of the draw

		iNumberPoints = iLastPoint - iFirstPoint;

//		Startn = (iNumberPoints * TotalDrawnTime / (DrawTime / 2)) + iFirstPoint;
//		Endn = (iNumberPoints * (TotalDrawnTime + DeltaTime) / (DrawTime / 2)) + iFirstPoint;
		Startn = 500 * TotalDrawnTime / (DrawTime / 2);
		Endn = 500 * (TotalDrawnTime + DeltaTime) / (DrawTime / 2);
		PrevPoint = vec(-99, -99 ,0);
		if( Startn <  500)
		{
			while (Startn < 500 && Startn < Endn)
			{
				if (DrawnPoints[Startn].z != -1)
				{
					WandX = DrawnPoints[Startn].x - 0.5;
					WandY = 0.5 - DrawnPoints[Startn].y;

					fDist = SpellGesture.CompareGesturePoint(DrawnPoints[Startn], fAccuracy);
//					log("Startn " $iPoint $" " $DrawnPoints[Startn].x $" " $DrawnPoints[Startn].y $" is out by " $fDist);

					if (fDist > fAccuracy)
					{
						if (ReDrawFX.ParentBlend != 0)
						{
							ReDrawFX.ParentBlend = 0;
							DrawFX.ParentBlend = 1;

							// AE:
							Wand.PlaySound(sound'HPSounds.magic_sfx.spell_learn_error_02', SLOT_Interact,,,,0.7);
						}

//						BadPointFX = Cam.Spawn( class'BadDrawPoint', [SpawnLocation] (Cam.Location + (vec(1, (DrawnPoints[Startn].x - 0.5) * FOVRatio, (0.5 - DrawnPoints[Startn].y) * FOVRatio) * WandDist >> Rotation)) );

//						log("Bad point!");
					}
					else
					{
						if (ReDrawFX.ParentBlend != 1)
						{
							ReDrawFX.ParentBlend = 1;
							DrawFX.ParentBlend = 0;

							// AE:
							Wand.PlaySound(sound'HPSounds.magic_sfx.spell_learn_trace_08', SLOT_Interact,,,,1.0);
						}
					}
				}
				Startn ++;
			}
//			log("wand pos " $WandX $" " $WandY);
		}

		d = vec(1, WandX*FOVRatio, WandY*FOVRatio) * WandDist;
		TargetPoint = Cam.Location + (d >> Rotation);
//		TargetPoint = Cam.Location + (vec(WandDist,WandX * WandDist, WandY * WandDist) >> Cam.Rotation);

		Wand.SetLocation(TargetPoint);
//		Wand.MoveSmooth(TargetPoint - Wand.Location);
		WandFX.SetLocation( Wand.Location );
		ReDrawFX.SetLocation( Wand.Location );
		DrawFX.SetLocation( Wand.Location );

		if (TotalDrawnTime >= TimeDrawn)
		{
			bCountedUp = true;
			disable('Tick');
		}

		TotalDrawnTime += DeltaTime;
	}

begin:

//	player.PlaySound(CastSound, SLOT_None);


		basehud(player.myhud).StopCountdown();

		// AE:
		PlaySound( sound'HPSounds.magic_sfx.spell_learn_end_03' );
		Wand.PlaySound(sound'HPSounds.magic_sfx.spell_learn_trace_08', SLOT_Interact, 0);

		TotalDrawnTime = 0;
		TimeDrawn = TimeDrawn / 2;

		Success = SpellGesture.CompareGesture( DrawnPoints, fAccuracy );
		Player.clientMessage("You are " $Success$ " good! " $PassMark[LessonLevel]);

		player.LessonScore = Success;

		if (bStartedDrawing)
		{
		// Find the first and last valid point
			iFirstPoint = 0;
			while(DrawnPoints[iFirstPoint].z == -1 && iFirstPoint < 500)
			{
				iFirstPoint ++;
			}

			iLastPoint = 499;
			while(DrawnPoints[iLastPoint].z == -1)
			{
				iLastPoint --;
			}
			iLastPoint ++;
		}
		WandX = SpellGesture.Points[0].x - 0.5;
		WandY = 0.5 - SpellGesture.Points[0].y;
		Wand.SetLocation( Cam.Location + (vec(WandDist,WandX * FOVRatio * WandDist, WandY * FOVRatio * WandDist) >> Cam.Rotation));
		DrawFX.Destroy();
		ReDrawFX = Cam.Spawn( class'BadDrawPoint', [SpawnLocation] Wand.Location );
		DrawFX = Cam.Spawn( class'TemplateSparkle01', [SpawnLocation] Wand.Location );
		
		baseHud(player.myhud).SetScoreCountTime(TimeDrawn);
		baseHud(player.myhud).bScoreCountUp = true;

		bCountedUp = false;
CountLoop:
		if (!bCountedUp)
		{
			sleep(1.0);
			goto 'CountLoop';
		}

		sleep(1.0);
		DestroyWand();

		if (Success >= PassMark[LessonLevel])
		{
			// Display the win effect.
			
//			if (Spell.default.SpellIncantation != "")
//			{
				if (Player.theNarrator.FindDialog(Spell.default.SpellIncantation, outSound, outText))
				{
					Player.PlaySound(outSound, SLOT_Talk);
				}
//			}

			Wand.PlaySound(sound'spell_trace_correct', SLOT_Interact, 2.0);
			DrawWinFX();

			if (teacher != none)
			{
				teacher.loopanim('talk_pos',,1);
			}
			sleep(3.0);
			teacher.loopanim('breathe',,1);

			baseHUD(player.myHUD).DestroyPopup();
			baseHud(player.myhud).bCutSceneMode=true;

			if (Success >= 1.0)
			{
				player.theNarrator.FindDialog(LessonFullMarks, outSound, outText);

				if (outSound != None)
				{
					PlaySound(outSound, SLOT_Talk);
					fSoundDuration = GetSoundDuration(outSound) + 1;
				}
				else
				{
					fSoundDuration = 3.0;
				}
				player.ReceiveIconMessage(None, outtext, fSoundDuration);
			}
			else if (Success > fVGoodThreshold)
			{
				fSoundDuration = SayJudgeVGood();
			}
			else
			{
				fSoundDuration = SayJudgeSuccess();
			}

			sleep(fSoundDuration);

			LessonLevel ++;

			if (LessonLevel > 3)
			{
				DestroyWand();
				DestroyTemplate();
				baseHUD(player.myHUD).DestroyPopup();

				player.iLevelReached = LessonLevel;
				player.AddHousePoints(iNumHousePoints[LessonLevel - 1]);
				TotalHousePointScore += iNumHousePoints[LessonLevel - 1];
				baseHud(player.myhud).bCutSceneMode=true;
				sleep(SayPoints(LessonLevel - 1));
				baseHud(player.myhud).bCutSceneMode=false;

				player.iLessonPoints = TotalHousePointScore;
				baseHUD(player.myHUD).ShowPopup(class'SpellLessonFinalScore');
				sleep(5);

				baseHUD(player.myHUD).DestroyPopup();

				Destroy();
			}
			else
			{
				teacher.loopanim('breathe',,1);
				baseHud(player.myhud).bCutSceneMode=false;
				Cam.DirectionActor = TempActor;

				DestroyWand();
				DestroyTemplate();

				player.AddHousePoints(iNumHousePoints[LessonLevel - 1]);
				TotalHousePointScore += iNumHousePoints[LessonLevel - 1];
				baseHud(player.myhud).bCutSceneMode=true;
				sleep(SayPoints(LessonLevel - 1));
				baseHud(player.myhud).bCutSceneMode=false;
				GotoState('Template');
			}
		}
		else
		{

			Wand.PlaySound(sound'spell_trace_incorrect', SLOT_Interact, 2.0);

			DrawLoseFX();

			if (teacher != none)
			{
				teacher.loopanim('talk_neg',,1);
			}

			sleep(3.0);

			baseHUD(player.myHUD).DestroyPopup();
			baseHud(player.myhud).bCutSceneMode=true;

			if (Success > fVBadThreshold)
			{
				fSoundDuration = SayJudgeFailure();
			}
			else
			{
				fSoundDuration = SayJudgeVBad();
			}

			sleep(fSoundDuration);

			teacher.loopanim('breathe',,1);
			baseHud(player.myhud).bCutSceneMode=false;
			Cam.DirectionActor = TempActor;

			if( LessonLevel == 0 )
			{
				DestroyWand();
				DestroyTemplate();
				GotoState('Template');
			}
			else
			{
				DestroyWand();
				DestroyTemplate();
				baseHUD(player.myHUD).DestroyPopup();

				player.iLevelReached = LessonLevel;
//				player.AddHousePoints(iNumHousePoints[LessonLevel - 1]);
				player.iLessonPoints = TotalHousePointScore;

				baseHUD(player.myHUD).ShowPopup(class'SpellLessonFinalScore');

				sleep(5);
				baseHUD(player.myHUD).DestroyPopup();

				Destroy();
			}
		}
//	}
}
/*
	PassMark(0)=0.25
	PassMark(1)=0.50
	PassMark(2)=0.60
	PassMark(3)=0.70
	PassMark(4)=0.75
	PassMark(5)=0.80
	PassMark(6)=0.85
	PassMark(7)=0.90
	PassMark(8)=0.95
	PassMark(9)=1.00

	iNumHousePoints(0)=1
	iNumHousePoints(1)=2
	iNumHousePoints(2)=3
	iNumHousePoints(3)=4
	iNumHousePoints(4)=5
	iNumHousePoints(5)=6
	iNumHousePoints(6)=8
	iNumHousePoints(7)=10
	iNumHousePoints(8)=15
	iNumHousePoints(9)=20
*/

defaultproperties
{
     WandClass=Class'HPBase.SpellWand'
     WandFXClass(0)=Class'HPParticle.Levitate_wand'
     WandFXClass(1)=Class'HPParticle.Levitate_wand'
     WandFXClass(2)=Class'HPParticle.Levitate_wand'
     DrawFXClass(0)=Class'HPParticle.TemplateSparkle01'
     DrawFXClass(1)=Class'HPParticle.TemplateSparkle01'
     DrawFXClass(2)=Class'HPParticle.TemplateSparkle01'
     WinFXClass(0)=Class'HPParticle.RewardBronze'
     WinFXClass(1)=Class'HPParticle.RewardSilver'
     WinFXClass(2)=Class'HPParticle.Reward01'
     CastSound=Sound'HPSounds.magic_sfx.Spells.s_spell_throw1'
     TemplateDist=105
     WandDist=100
     DrawTime=6
     FOVRatio=0.8
     fAccuracy=0.03
     fDecayTime=6
     LessonPoints(0)="Quirrell_lesson_30"
     LessonPoints(1)="Quirrell_lesson_31"
     LessonPoints(2)="Quirrell_lesson_32"
     LessonPoints(3)="Quirrell_lesson_34"
     fVGoodThreshold=0.8
     fVBadThreshold=0.6
     iNumHousePoints(0)=5
     iNumHousePoints(1)=10
     iNumHousePoints(2)=15
     iNumHousePoints(3)=20
     iNumHousePoints(4)=5
     iNumHousePoints(5)=6
     iNumHousePoints(6)=8
     iNumHousePoints(7)=10
     iNumHousePoints(8)=15
     iNumHousePoints(9)=20
     PassMark(0)=0.5
     PassMark(1)=0.65
     PassMark(2)=0.8
     PassMark(3)=0.95
     PassMark(4)=0.75
     PassMark(5)=0.8
     PassMark(6)=0.85
     PassMark(7)=0.9
     PassMark(8)=0.95
     PassMark(9)=1
     bTriggerOnceOnly=True
}
