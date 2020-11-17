class DevilsSnare expands baseChar;

enum enumTimeSpentWiltedSound
{
	TIME_NO_SOUND,
	TIME_SHORT,
	TIME_MEDIUM,
	TIME_LONG,
};

//Dont forget, if you add new vars, to add the appropriate code to DevilsSnareEncounter.

var() enumTimeSpentWiltedSound     _TimeSpentWiltedSound;
var   int                         _iTimeSpentWiltedSound;
var()  float  fOverAllSnareSpeed;     //Scalar for the other parameters.  2 makes game twice as hard
var()  float  fGrowSpeedMultiplier;
var()  float  fRecedeSpeedMultiplier;
var()  float  fWiltedTime;

var()  bool   bTargetOnlyWhenFullyGrown;

var    float  fWiltedTimer;

var    bool   bDidFirstGrow;

//***********************************************************************************
function PreBeginPlay()
{
	_iTimeSpentWiltedSound = _TimeSpentWiltedSound;
		//case 0: 	_TimeSpentWiltedSound = TIME_SHORT;     break;
}

//***********************************************************************************
auto state stateGrowing
{
	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function HandleIncendioSpell()
	{
		GotoState('stateReceding');
	}

  Begin:
	PlayAnim('extend', fGrowSpeedMultiplier*fOverAllSnareSpeed, 0.1);

	if( !bDidFirstGrow )
	{
		AnimFrame = 0.1 + FRand() * 0.8;
		bDidFirstGrow = true;
	}

	FinishAnim();

	bProjTarget = true;

	LoopAnim('idle', 1.0, 0.1);

  loop:
	Sleep(5);
	goto 'loop';
}

//***********************************************************************************
state stateReceding
{
	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function HandleIncendioSpell()
	{
		//PlayRecedeSfx();
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function PlayRecedingAnim()
	{
		local  float  t;

		t = AnimFrame;
		PlayAnim('retract', fRecedeSpeedMultiplier*fOverAllSnareSpeed, 1.0);  //the tween time might not work...
		AnimFrame = 1-t;
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function CheckForGameWin()
	{
		local   DevilsSnare           a;
		local   bool                  bAllDSWilted;
		local   DevilsSnareEncounter  dse;

		bAllDSWilted = true;

		foreach allactors(class'DevilsSnare', a)
		{
			if( !a.IsInState('stateWilted') && a != self )
			{
				bAllDSWilted = false;
				break;
			}
		}

		if( bAllDSWilted )
		{
			//Release harry and what not...
			playerHarry.ClientMessage("!!!!!!! All wilted");

			playerHarry.StopBossEncounter();

			foreach allactors(class'DevilsSnare', a)
				a.GotoState('stateWiltedForGood');
			
			//Tell the DevilsSnareEncounter that we're done
			foreach allactors(class'DevilsSnareEncounter', dse)
			{
				dse.SendDefeatedTrigger();
			}
		}
	}


  Begin:

	//PlayRecedeSfx();

	//Play appropriate wilt sound
/*	switch( _iTimeSpentWiltedSound )
	{
	//	case 0:    PlaySound( sound'HPSounds.critters_sfx.doxy_attack1',   [Pitch]0.2 );     break;
	//	case 1:    PlaySound( sound'HPSounds.critters_sfx.doxy_ouch1',     [Pitch]0.2 );     break;
	//	case 2:    PlaySound( sound'HPSounds.critters_sfx.doxy_defeated',  [Pitch]0.2 );     break;
	}
*/
	if( bTargetOnlyWhenFullyGrown )
		bProjTarget = false;

// AE: Kick off slimey loop.
// playsound(sound'HPSounds.critters_sfx.DS_loop');

// AE: Trigger the response to being hit.
	switch( Rand(7) )
	{
		case 0: playsound(sound'HPSounds.critters_sfx.DS_Hit_01');
			break;

		case 1: playsound(sound'HPSounds.critters_sfx.DS_Hit_02');
			break;

		case 2: playsound(sound'HPSounds.critters_sfx.DS_Hit_03');
			break;

		case 3: playsound(sound'HPSounds.critters_sfx.DS_Hit_04');
			break;

		case 4:
			playsound(sound'HPSounds.critters_sfx.DS_Hit_05_Long');
			break;

		case 5:
			playsound(sound'HPSounds.critters_sfx.DS_Hit_06');
			break;

		case 6:
			playsound(sound'HPSounds.critters_sfx.DS_Hit_07');
			break;
	}

	PlayRecedingAnim();
	FinishAnim();
	LoopAnim('hold', 1.0, 0.1);

// AE: Stop slimey loop once wilt anim is complete.
// stopsound(sound'HPSounds.critters_sfx.DS_loop');

	//Check and see if all the plants are wilted
	CheckForGameWin();

	GotoState('stateWilted');
}

//***********************************************************************************
state stateWilted
{
	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function HandleIncendioSpell()
	{
		fWiltedTimer = 0;
	}

  Begin:
	fWiltedTimer = 0;

  Loop:
	Sleep( 0.1 );
	fWiltedTimer += 0.1;

	if( fWiltedTimer >= fWiltedTime/fOverAllSnareSpeed )
		GotoState('stateGrowing');

	goto 'loop';
}

//***********************************************************************************
state stateWiltedForGood
{

}

//***********************************************************************************
//function PlayHitSfx()
//{
//	local int    i;
//	local sound  snd;
//
//	do
//	{
//		i = Rand(4);
//	}until( i != iCurrentHitSfx );
//
//	iCurrentHitSfx = i;
//
//	switch( iCurrentHitSfx )
//	{
//		case 0:   snd = sound'DS_Hit_01';   break;
//		case 1:   snd = sound'DS_Hit_02';   break;
//		case 2:   snd = sound'DS_Hit_03';   break;
//		case 3:   snd = sound'DS_Hit_04';   break;
//	}
//
//	PlaySound( snd, SLOT_none, RandRange(0.7, 1.0), [Pitch]RandRange(0.75, 1.1) );
//
//}
//
////***********************************************************************************
//function PlayRecedeSfx()
//{
//	local sound snd;
//
//	//play a really muffled recede sound
//	switch( Rand(2) )
//	{
//		case 0:   snd = sound'DS_grows1';    break;
//		case 1:   snd = sound'DS_grows2';    break;
//	}
//
//	PlaySound( snd, SLOT_none, RandRange(0.4, 0.5), [Pitch]RandRange(0.6, 0.7) );
//}


//***********************************************************************************

defaultproperties
{
     _TimeSpentWiltedSound=TIME_SHORT
     fOverAllSnareSpeed=0.75
     fGrowSpeedMultiplier=0.2
     fRecedeSpeedMultiplier=0.4
     fWiltedTime=15
     ShadowClass=None
     eVulnerableToSpell=SPELL_Incendio
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdevilplantMesh'
     bProjTarget=True
}
