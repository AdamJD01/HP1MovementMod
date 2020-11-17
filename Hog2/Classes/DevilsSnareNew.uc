class DevilsSnareNew expands baseChar;

var()  float  fOverAllSnareSpeed;     //Scalar for the other parameters.  2 makes game twice as hard
var()  float  fSlowGrowSpeed;
var()  float  fFastGrowSpeed;
var()  float  fRecedeSpeed;
var()  float  fDamageHarryAmount;
var    bool   bGrowingFast;
var    float  NoDamageTimer;
var    int    OriginalYaw;
var()  int    DegreeRotateRange;
var    int    RotateRange;
var    name   BoneNames[4];

var    bool   bIgnoredFirstFastGrow;
var    bool   bActive;
var    bool   bFreezeWhenDoneReceding;

var    DevilsSnareHead  _DevilsSnareHead;

var()  bool   bUseHeadTarget;

//var()  float  fGrowSpeedMultiplier;
//var()  float  fRecedeSpeedMultiplier;
//var()  float  fWiltedTime;

//var()  bool   bTargetOnlyWhenFullyGrown;

//var    float  fWiltedTimer;

//var    bool   bDidFirstGrow;

var      int  iCurrentHitSfx;

var      float fAmbientSoundTimer;

//***********************************************************************************
function PreBeginPlay()
{
	//_iTimeSpentWiltedSound = _TimeSpentWiltedSound;
		//case 0: 	_TimeSpentWiltedSound = TIME_SHORT;     break;
	super.PreBeginPlay();

	SetTimer( RandRange(0.19, 0.21), true );

	BoneNames[0] = 'TENT_Bone17';
	BoneNames[1] = 'TENT_Bone21';
	BoneNames[2] = 'TENT_Bone25';
	BoneNames[3] = 'TENT_Bone27';

	RotateRange = DegreeRotateRange * 65536 / 360;

	OriginalYaw = Rotation.yaw;

	if( bUseHeadTarget )
		_DevilsSnareHead = spawn(class'DevilsSnareHead', self);

	fAmbientSoundTimer = RandRange( 1, 8 );
}

//***********************************************************************************
function Timer()
{
	local int           i;
	local vector        v;
	//local BroomTrail_02 a;

	if(   (   IsInState('stateGrowing')  && AnimFrame >     0.4
	       || IsInState('stateReceding') && AnimFrame < 1.0-0.4
	      )
	   && NoDamageTimer == 0
	  )
	{
		for( i = 0; i < 4; i++ )
		{
			v = BonePos( BoneNames[i] );

			//a =spawn(class'BroomTrail_02', [SpawnLocation]v);
			//a.LifeSpan = 1;
			//Log("******** 2dDist to bone "$BoneNames[i]$":"$VSize2d( v - playerHarry.Location ));

			if(   abs( v.z - playerHarry.Location.z ) < 200
			   && VSize2d( v - playerHarry.Location ) < playerHarry.CollisionRadius + 20
			  )
			{
				playerHarry.TakeDamage( fDamageHarryAmount, none, v, Vect(0,0,0), '');
				
				NoDamageTimer = 1.75;

				PlayHitHarrySfx();

				if( !IsInState('stateReceding') )
					GotoState('stateReceding');
				return;
			}
		}
	}

}

//***********************************************************************************
function Tick( float dtime )
{
	local rotator r;
	local int     YawDiff;
	local vector  v;
	local sound   snd;

	NoDamageTimer -= dtime;
	if( NoDamageTimer < 0 )
		NoDamageTimer = 0;


	if( _DevilsSnareHead != none )
	{
		v = BonePos( 'TENT_Bone25' );
		_DevilsSnareHead.SetLocation( v );
	}


	if( IsInState('stateGrowing') )//|| IsInState('stateReceding') )
	{
		if( AnimFrame < 0.25 )
		{
			bProjTarget = false;
			SetCollision(true, false, false);

			if( bUseHeadTarget )
			{
				_DevilsSnareHead.bProjTarget = false;
				_DevilsSnareHead.SetCollision(true, false, false);
			}
		}
		else
		{
			if( bUseHeadTarget )
			{
				_DevilsSnareHead.bProjTarget = true;
				_DevilsSnareHead.SetCollision(true, true, false);
			}
			else
			{
				bProjTarget = true;
				SetCollision(true, true, false);
			}
		}

		r = rotator( playerHarry.Location - Location );
		//r.yaw -= 65536/4;  //for bad devils snares
		r.pitch = 0;
		r.roll = 0;

		YawDiff = (r.yaw - OriginalYaw) & 0xFFFF;

		if( YawDiff < 32768 )
		{
			if( YawDiff > RotateRange )
				r.yaw = OriginalYaw + RotateRange;
		}
		else
		{
			if( YawDiff < 0xFFFF - RotateRange )
				r.yaw = OriginalYaw - RotateRange;
		}

		DesiredRotation = r;

		//playerHarry.Clientmessage("dr="$r$"  yaw="$Rotation.yaw);
	}

	fAmbientSoundTimer -= dtime;
	if( fAmbientSoundTimer <= 0 )
	{
		fAmbientSoundTimer = RandRange( 4, 12 );

		switch( Rand(2) )
		{
			case 0:    snd = sound'DS_grows1';      break;
			case 1:    snd = sound'DS_grows2';      break;
		}

		PlaySound( snd, SLOT_none, RandRange(0.3, 0.5), [Pitch]RandRange(0.75, 1.0) );
	}
	
}

//***********************************************************************************
function Trigger( actor Other, pawn EventInstigator )
{
	if( !bActive )
	{
		bActive = true;
		GotoState( 'stateGrowing' );
	}
	else
	{
		bActive = false;
		bFreezeWhenDoneReceding = true;
		GotoState( 'stateReceding' );
	}
		
}

//***********************************************************************************
auto state stateIdle
{
  Begin:
	PlayAnim('grow');
	AnimRate = 0;
}

//***********************************************************************************
state stateGrowing
{
	// AE:
	function PlayHitSound()
	{
		switch( Rand(6) )
		{
			case 0: playsound(sound'HPSounds.critters_sfx.DS_Hit_01');		break;
			case 1: playsound(sound'HPSounds.critters_sfx.DS_Hit_02');		break;
			case 2: playsound(sound'HPSounds.critters_sfx.DS_Hit_03');		break;	
			case 3: playsound(sound'HPSounds.critters_sfx.DS_Hit_04');		break;
			case 4: playsound(sound'HPSounds.critters_sfx.DS_Hit_06');		break;
			case 5:	playsound(sound'HPSounds.critters_sfx.DS_Hit_07');		break;
		}
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function HandleIncendioSpell()
	{
		// AE:
		PlayHitSound();
	//	PlayHitSfx();
		GotoState('stateReceding');
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

  Begin:
	//Decide New GrowSpeed
	bGrowingFast = GrowFast();

	if( bGrowingFast )
		PlayAnim('grow', fFastGrowSpeed * RandRange(0.8, 1.2) * fOverAllSnareSpeed, 0.1);
	else
		PlayAnim('grow', fSlowGrowSpeed * RandRange(0.8, 1.2) * fOverAllSnareSpeed, 0.1);

	FinishAnim();

	//bProjTarget = true;
	//LoopAnim('idle', 1.0, 0.1);

	GotoState( 'stateReceding' );
}

//***********************************************************************************
function bool GrowFast()
{
	local DevilsSnareNew  a;

	if( !bIgnoredFirstFastGrow )
	{
		bIgnoredFirstFastGrow = true;
		return false;
	}

	ForEach AllActors(class'DevilsSnareNew', a, tag)
	{
		if( a.bGrowingFast )
		{
			//Everynow and then, let two grow fast
			if( FRand() < 0.1 )
				return true;
			else
				return false;
		}
	}

	return true;
}

//***********************************************************************************
state stateReceding
{
	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function HandleIncendioSpell()
	{
		PlayHitSfx();
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	function PlayRecedingAnim()
	{
		local  float  t;

		t = AnimFrame;
		PlayAnim('retract', fRecedeSpeed * RandRange(0.8, 1.2) * fOverAllSnareSpeed, 0.2);  //the tween time might not work...
		AnimFrame = 1.0-t;
	}

	/*
	// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
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
	*/

  Begin:

	PlayRecedeSfx();

	bGrowingFast = false;
	bProjTarget = false;
	SetCollision(true, false, false);
	if( bUseHeadTarget )
	{
		_DevilsSnareHead.bProjTarget = false;
		_DevilsSnareHead.SetCollision(true, false, false);
	}

	//if( bTargetOnlyWhenFullyGrown )
	//	bProjTarget = false;

	PlayRecedingAnim();
	FinishAnim();
	//LoopAnim('hold', 1.0, 0.1);

	if( bFreezeWhenDoneReceding )
		GotoState('stateIdle');
	else
		GotoState('stateGrowing');
}

//***********************************************************************************
function PlayHitSfx()
{
	local int    i;
	local sound  snd;

	do
	{
		i = Rand(4);
	}until( i != iCurrentHitSfx );

	iCurrentHitSfx = i;

	switch( iCurrentHitSfx )
	{
		case 0:   snd = sound'DS_Hit_01';   break;
		case 1:   snd = sound'DS_Hit_02';   break;
		case 2:   snd = sound'DS_Hit_03';   break;
		case 3:   snd = sound'DS_Hit_04';   break;
	}

	PlaySound( snd, SLOT_none, RandRange(0.7, 1.0), [Pitch]RandRange(0.75, 1.1) );

}

//***********************************************************************************
function PlayRecedeSfx()
{
	local sound snd;

	//play a really muffled recede sound
	switch( Rand(2) )
	{
		case 0:   snd = sound'DS_grows1';    break;
		case 1:   snd = sound'DS_grows2';    break;
	}

	PlaySound( snd, SLOT_none, RandRange(0.4, 0.5), [Pitch]RandRange(0.6, 0.7) );
}

//***********************************************************************************
function PlayHitHarrySfx()
{
	local sound  snd;

	switch( Rand(2) )
	{
		case 0:   snd = sound'DS_Hit_06';    break;
		case 1:   snd = sound'DS_Hit_07';    break;
	}

	PlaySound( snd, SLOT_none, RandRange(0.8, 1.0), [Pitch]RandRange(0.9, 1.1) );

	snd = sound'DS_Hit_05_Long';
	PlaySound( snd, SLOT_none, RandRange(0.4, 0.5), [Pitch]RandRange(0.8, 1.0) );

}

//***********************************************************************************
//state stateWilted
//{
//	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
//	function HandleIncendioSpell()
//	{
//		fWiltedTimer = 0;
//	}
//
//  Begin:
//	fWiltedTimer = 0;
//
//  Loop:
//	Sleep( 0.1 );
//	fWiltedTimer += 0.1;
//
//	if( fWiltedTimer >= fWiltedTime/fOverAllSnareSpeed )
//		GotoState('stateGrowing');
//
//	goto 'loop';
//}

//***********************************************************************************

defaultproperties
{
     fOverAllSnareSpeed=1
     fSlowGrowSpeed=0.5
     fFastGrowSpeed=1.4
     fRecedeSpeed=0.6
     fDamageHarryAmount=5
     DegreeRotateRange=30
     bUseHeadTarget=True
     ShadowClass=None
     Physics=PHYS_Rotating
     eVulnerableToSpell=SPELL_Incendio
     CentreOffset=(Z=-90)
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdevilplant2Mesh'
     DrawScale=0.5
     CollisionRadius=80
     CollisionHeight=20
     bProjTarget=True
     RotationRate=(Yaw=3000)
}
