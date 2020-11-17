class BossQuirrel expands BaseBossQuirrel;

//*************************************************************************************************************************

//look for type mirror, and one NavigationPoint with tag BossRadiusTag that is where
// the boss will stand when one of the columns hits him

var() int    NumColumns;
var   int    YawToFirstColumn;
var   float  RunRadius;
var   vector MirrorLoc;
var() int    NumPointsBetweenColumns;
var   int    NumYawDestinations;

var   int    NumColumnsLeft;        //Counts down as the columns get destroyed
var   bool   bBattlePhaseOne;
var   bool   bLastShotWasTracking;  //for phase two, toggle back and forth between shots.

var   int    CurrentYaw;     //This is where you are around the mirror, not which way you are pointing
var   int    DestinationYaw;
var   bool   bClockWiseMove;

var   float  PauseTime;
var   int    VolleyCount;
var   int    NumShots;
var   int    NumRemainingShots;
var   float  PauseBetweenFiring;
var   float  PauseBetweenFiringTimer;
var   bool   bWasJustShooting;

var   float  GSToAngSpeed;

var() name   BossRadiusNavPointTag;

var() name   EventToSendAtMidGameTag;

var() float  fWalkAnimMultiplier;

var   float  fBossOriginalZ;

var   float  TimeOfLastSpeech;
var   float  TimeOfLastHarryHurt;
var   bool   bDidFirstTalk;
var   int    iCastASpellSpeech;
var   int    iCastingASpellEmote;
var   int    iGetsHurtSfx;
var   int    iGetsHurtSpeech;
var   int    iHurtHarryEmote;

var   float  TempSoundLen;
var   sound  TempSound;

//var   int    TempCount;

//*************************************************************************************************************************
function PostBeginPlay()
{
	local mirror           m;
	local NavigationPoint  n;
	local rotator          r;
	local vector           v;
	local baseWand         weap;

	weap=spawn(class'baseWand');
	weap.BecomeItem();
	AddInventory(weap);
	weap.WeaponSet(self);
	weap.GiveAmmo(self);
	weap.SelectSpell(Class'spellVoldemortStraight');
	weap.FireOffset = vect(0,0,-50);

	foreach AllActors(class'mirror', m)
		break;

	foreach AllActors(class'NavigationPoint', n, BossRadiusNavPointTag)
		break;

	if( m==none || n==none )
		Log("******Error: m:" @ m @ " n:" @ n);

	MirrorLoc = m.Location;

	v = n.Location - MirrorLoc;
	v.z = 0;
	r = rotator( v );
	YawToFirstColumn = r.yaw;
	RunRadius = VSize( v );

	GSToAngSpeed = 65536.0 / (2.0 * Pi * RunRadius);

	NumYawDestinations = (NumPointsBetweenColumns+1)*NumColumns;

	
	NumColumnsLeft = NumColumns;

	//Move squirrel out to the correct radius
	v = Location - MirrorLoc;
	v.z = 0;
	v = Normal( v );
	v *= RunRadius;
	v = MirrorLoc + v;
	v.z = Location.z;
	SetLocation( v );

	//Get quirrels current yaw from the mirror
	CurrentYaw = rotator(Location - MirrorLoc).yaw;

	fBossOriginalZ = Location.z;
}

//*******************************************************************************
event Tick(float dtime)
{
	local vector v;

	if( !IsInState( 'stateDead' ) )
	{
		v = playerHarry.Location - Location;
		v.z = 0;

		DesiredRotation = rotator(v);
	}
}

//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	if(   IsInState('stateIdle')
	   || (   !IsInState('stateRunToDestinationYaw')
	       && !IsInState('statePause')
	       && !IsInState('stateAttack')
	       && !IsInState('stateHitByColumn')
	      )
	  )
	{
		GoActive();
	}
	else
	{
		GotoState('stateIdle');
	}
}

//*************************************************************************************************************************
function TriggerSpecial(actor Other, int Info)
{
	//When info is 0, a column got destroyed
	if( Info == 0 )
	{
		NumColumnsLeft--;

		if( NumColumnsLeft <= 0  &&  bBattlePhaseOne )
			StartBattlePhaseTwo();
	}
}

//*******************************************************************************
function HarryWasHurt( bool bHarryWasKilled )
{
	//37, 35, 36
	if( bHarryWasKilled )
	{
		GotoState('stateHarryDead');
	}
	else
	if( Level.TimeSeconds - TimeOfLastHarryHurt > 2 )
	{
		if( FRand() < 0.5 )
			PlayHurtHarryEmote();
	}
}

//*******************************************************************************
function bool TakeSpellEffect(baseSpell spell)
{
	local bool  bReturn;

	if(spell.Instigator != self  &&  spellVoldemortStraight(spell) != None)
	{
		if( !IsInState('stateHitByColumn') )
		{
			//Health -= 10;  stateHitByColumn takes the health off

			//if( Health > 0 )
				GotoState('stateHitByColumn');
			//else
			//	CheckForDead();
		}

		bReturn = true;
	}

	return bReturn;
}

//*******************************************************************************
function GoActive()
{
	GotoState('statePause');
}

//*************************************************************************************************************************
function float GetHealth()
{
	return Health/80.0;
}

//*************************************************************************************************************************
//After the columns have been destroyed, or you go to half health
function StartBattlePhaseTwo()
{
	local Hub5Column  column;

	bBattlePhaseOne = false;

	//Turn into quirrell
	if( EventToSendAtMidGameTag != '' )
		TriggerEvent(EventToSendAtMidGameTag, none, self);

	//Blow up the columns.  This'll need to change
	ForEach AllActors(class'Hub5Column', column)
		column.Disintegrate( column.Location, rotator( vect(0,0,1) ) );

	//baseWand(weapon).SelectSpell(Class'spellVoldemortTracking');
}

//*************************************************************************************************************************
function HandleHitByColumn()
{
	GotoState('stateHitByColumn');
}

//*************************************************************************************************************************
function DecideNextAction()
{
	//local int yawIndex;
	local int bLessThanHarrysYaw;

	if( bWasJustShooting )
	{
		bWasJustShooting = false;

		//Find a new DestinationYaw to run to.
		DestinationYaw = FindYawToHarry();// bLessThanHarrysYaw );

		if( !bDidFirstTalk )
			PlayFirstTalkSpeech();
		else
		if( FRand() < 0.2 )
			PlayCastASpellSpeech();

		bDidFirstTalk = true;

		GotoState('stateRunToDestinationYaw');
	}
	else
	{
		bWasJustShooting = true;

		//We weren't just shooting, so I guess it's time shoot
		GotoState('stateAttack');
	}
}

//*************************************************************************************************************************
function int FindYawToHarry()//out int HarryYawIndex, out int bHarryBehindColumn, out int bLessThanHarrysYaw)
{
	//local float YawToHarryFromMirror;
	local int   i;
	local int   i1;  //pie slice harry is in
	local int   i2;  //pie slice vold is in
	local bool  bHarryLeftSide; //which side of pie harry is in
	local int   FinalYaw;
	//local int   tmpi;

	i  = ((rotator(playerHarry.Location - MirrorLoc).yaw - YawToFirstColumn) & 65535);  //take off YawToFirstColumn so the pie slice is relative to that first column
	i1 = i + 65536.0/NumYawDestinations / 2.0; //add a half step for our number of yaw destinations;
	i /= 65536.0/NumYawDestinations;
	i1 /= 65536.0/NumYawDestinations;
	if( i == i1 )
		bHarryLeftSide = true;
	i1 = i1 % NumYawDestinations;

	i2 = ((rotator(Location - MirrorLoc).yaw - YawToFirstColumn) & 65535)   +   65536.0/NumYawDestinations / 2.0; //add a half step for our number of yaw destinations;
	i2 /= 65536.0/NumYawDestinations;
	i2 = i2 % NumYawDestinations;

	//Set i to where we'd like vold to move to

	//bHarryLeftSide means which way to harry, clockwise of ccw
	bHarryLeftSide = (i1-i2+NumYawDestinations) % NumYawDestinations < NumYawDestinations/2;

	//If volds behind a column, move to closest spot to harry that's not behind a column
	if( i2 % (NumPointsBetweenColumns+1) == 0 )
	{
		//if harry's behind a column
		if( i1 % (NumPointsBetweenColumns+1) == 0 )
		{
			if( bHarryLeftSide )
				i = (i1 - 1 + NumYawDestinations) % NumYawDestinations;
			else
				i = (i1 + 1                     ) % NumYawDestinations;
		}
		else //just move to harry's pos
		{
			i = i1;
		}
	}
	else //vold not behind a column, move to a column pos
	{
		//if harry's behind a column
		if( i1 % (NumPointsBetweenColumns+1) == 0 )
		{
			i = i1;
		}
		else
		{
			if( bHarryLeftSide )
				i = (i1 - 1 + NumYawDestinations) % NumYawDestinations;
			else
				i = (i1 + 1                     ) % NumYawDestinations;
		}
	}

//	//If harry's behind a column, move to the adjacent slot
//	//if( i1 % (NumPointsBetweenColumns+1) == 0 )
//	if( HarryBehindAColumn() )
//	{
//		if( bHarryLeftSide )
//			i = (i1 + 1) % NumYawDestinations;
//		else
//			i = (i1 - 1) % NumYawDestinations;
//
//		//If vold is already there, go to the other one
//		if( i == i2 )
//		{
//			if( bHarryLeftSide )
//				i = (i1 - 1) % NumYawDestinations;
//			else
//				i = (i1 + 1) % NumYawDestinations;
//		}
//	}
//	else //harry not behind column
//	{
//		//if where harry is, go behind column next to harry
//		if( i2 == i1 )
//		{
//			if( bHarryLeftSide )
//				i = (i1 + 1) % NumYawDestinations;
//			else
//				i = (i1 - 1) % NumYawDestinations;
//		}
//		else //Go to where harry is
//		{
//			i = i1;
//		}
//	}

	FinalYaw = (i * 65536.0/NumYawDestinations) + YawToFirstColumn;


	//Pie slice is relative to first column, so add back in YawToFirstColumn to get the real yaw value we're after
	return FinalYaw;

}

//*************************************************************************************************************************
function bool HarryBehindAColumn()
{
	local Hub5Column a;
	local vector     v;
	local float      c;

	c = cos( 20.0 * 2.0*pi/360.0 );
	v = normal( playerHarry.Location - Location );
	//playerHarry.ClientMessage( c );
	foreach allactors( class'Hub5Column', a )
	{
		if( (v dot normal( a.Location - Location )) > c )
			return true;
	}

	return false;
}

//*************************************************************************************************************************
auto state stateIdle
{
  Begin:
	LoopAnim('Breathe', , 0.2);
	Sleep(600);
	Goto 'Begin';
}

//*************************************************************************************************************************
state stateRunToDestinationYaw
{
	event tick(float dtime)
	{
		local float   WalkYawAmount;
		local vector  v, vMirror;
		local rotator r;

		Global.Tick(dtime);

		//Actually, if we're within 100 units of harry, blast him right now
		if( VSize2d( playerHarry.Location - Location ) < 120 )
		{
			//If in debug mode, just kill vold
			//if( baseConsole(playerHarry.player.console).bDebugMode )
			//{
			//	Health = 0;
			//	GotoState( 'stateHitByColumn' );
			//	return;
			//}

			PauseTime = 0;
			GotoState('statePause');
			return;
		}

		WalkYawAmount = GroundSpeed * GSToAngSpeed * dtime;

		if( bClockWiseMove )
			CurrentYaw += WalkYawAmount;
		else
			CurrentYaw -= WalkYawAmount;

		//See if we've passed our target yaw
		if( (((DestinationYaw - CurrentYaw) & 65535) < 32768) != bClockWiseMove )
		{
			CurrentYaw = DestinationYaw;
			
			LoopAnim('Breathe');

			//Do a pause
			PauseTime = 0.5  +  0.5 * Rand(3);
			GotoState('statePause');
		}

		vMirror = MirrorLoc;
		vMirror.z = fBossOriginalZ;

		r.yaw = CurrentYaw;
		v = MirrorLoc + vector( r ) * RunRadius;
		v.z = Location.z;

		MoveSmooth( v - Location );
	}

  Begin:
	//Which way will we be running?
	bClockWiseMove = ((DestinationYaw - CurrentYaw) & 65535) < 32768;

  Loop:
	UpdateWalkAnim();
	sleep(0.5);
	goto 'Loop';
}

//*************************************************************************************************************************
function UpdateWalkAnim()
{
	local float dp;
	local vector vVel, vFace;

	vVel = Location - OldLocation;//Velocity;
	vVel.z = 0;
	vVel = normal(vVel);

	vFace = vector(rotation);
	vFace.z = 0;
	vFace = normal(vFace);

	dp = vVel dot vFace;

	if( dp > 0.707 )
	{
		LoopAnim('walk', fWalkAnimMultiplier, 0.5);
	}
	else
	if( dp < -0.707 )
	{
		LoopAnim(/*backup*/'walk_b', fWalkAnimMultiplier, 0.5);
	}
	else //sideways
	{
		dp = (vVel cross vFace).z;

		if( dp > 0 )
		{
			LoopAnim(/*strafe right*/'strafe_r', fWalkAnimMultiplier, 0.5);
		}
		else
		{
			LoopAnim(/*strafe left*/'strafe_l', fWalkAnimMultiplier, 0.5);
		}
	}
}

//*************************************************************************************************************************
state statePause
{
  Begin:
	LoopAnim('Breathe', , 0.2);
  loop:
	Sleep(0.1);
	PauseTime -= 0.1;

	if( PauseTime <= 0 )
	{
		DecideNextAction();
	}

	goto 'loop';
}

//*************************************************************************************************************************
state stateAttack
{
  Begin:
	LoopAnim('Breathe', , 0.2);

	if( FRand() < 0.2 )
		PlayCastASpellSpeech();

	if(    bBattlePhaseOne
	   || !bBattlePhaseOne && bLastShotWasTracking
	  )
	{
		if( bLastShotWasTracking )
			bLastShotWasTracking = false;

		if( bBattlePhaseOne )
			VolleyCount = 1;
		else
			VolleyCount = 2;

		while( VolleyCount > 0 )
		{
			if( bBattlePhaseOne )
			{
				NumShots = 3.0 + Rand(2) + (1.0-GetHealth())*3.0;// 3, 4, or 5 based on health   //1 + Rand(3);
			}
			else
			{
				NumShots = 3.0 + 1       + (1.0-GetHealth())*3.0;// 3, 4, or 5 based on health   //1 + Rand(3);

				// do a roar right here!
				if( VolleyCount == 1 )
				{
					PlayAnim('cast2', , 0.2 );
					Sleep( 0.5 );
					playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ));
					spawn( class'VoldEffectCircling' );
					FinishAnim();
				}
				else
				{
					sleep(1.0);
				}
			}

			PauseBetweenFiring = 1.1;

			for( NumRemainingShots = 0; NumRemainingShots < NumShots; NumRemainingShots++ )
			{
				PauseBetweenFiringTimer = PauseBetweenFiring;

				//Sleep(0.005);
				if( !playerHarry.HarryIsDead() )
					PlayAnim('cast', 2.0, 0.2);

				if( NumRemainingShots > 0  &&  FRand() < 0.25 )
					PlayCastingASpellEmote();

				if( PauseBetweenFiringTimer < 0.8 )
				{
					Sleep( PauseBetweenFiringTimer - 0.4 );
					PauseBetweenFiringTimer -= PauseBetweenFiringTimer - 0.4;
				}
				else
				{
					Sleep( 0.4 );
					PauseBetweenFiringTimer -= 0.4;
				}

				if( !playerHarry.HarryIsDead() )
					ShootStraightSpellAtHarry( false );

				//FinishAnim();
				Sleep( PauseBetweenFiringTimer );

				PauseBetweenFiring *= 0.875;

				if( PauseBetweenFiring < 0.4 )
					PauseBetweenFiring = 0.4;

				//GotoState('stateDead');  //debugging
			}

			VolleyCount--;
		}

		if( bBattlePhaseOne )
			PauseTime = 2.0;
		else
			PauseTime = 0.5;
	}
	else
	{
		bLastShotWasTracking = true;

		Sleep( 0.5 );

		for( NumRemainingShots = 1; NumRemainingShots > 0; NumRemainingShots-- )
		{
			Sleep(0.005);
			PlayAnim('cast', , 0.1);
			Sleep( 0.4 );
			CastTrackingSpell();
			//FinishAnim();   dont even wait
		}

		PauseTime = 2.0;
	}	

	GotoState('statePause');
}

//*************************************************************************************************************************
function CastTrackingSpell()
{
	local rotator r, rsave;

	baseWand(weapon).SelectSpell(Class'spellVoldemortTracking');

	rsave = Rotation;

	r = Rotation;
	r.yaw += -65536/12 + Rand(65536/6);
	SetRotation( r );
	baseWand(weapon).CastSpell( none /*playerHarry*/ );
	SetRotation( rsave );
}

//*************************************************************************************************************************
state stateTakeDamage
{
  Begin:
	
}

//*************************************************************************************************************************
state stateHitByColumn
{
  Begin:
	Health -= 10;

	if( Health <= 0 )
	{
		PlayDieSpeech();
		GotoState('stateDead');
	}
	else
	{
		PlayAnim('hit');
		PlayGetsHurtSfx();
		sleep(1.75);

		if( FRand() < 0.5 )
			PlayGetsHurtSpeech();

		finishAnim();
		sleep(1);

		if( bBattlePhaseOne  &&  Health <= 40 )
			StartBattlePhaseTwo();

		DecideNextAction();
		sleep(0.005);
	}
}

//*************************************************************************************************************************
state stateHarryDead
{
  Begin:
	PlayAnim('mad', , 0.2);

  Loop:
	FindEmote("EmotiveVoldermort37", TempSound);
	TempSoundLen = GetSoundDuration( TempSound );
	if( TempSoundLen == 0 )
		TempSoundLen = 1.0;
	PlaySound( TempSound );
	//Sleep( TempSoundLen );
	Sleep(1.5);


	PlayAnim('cast2', , 0.2);
	//Sleep(0.5);

	FindEmote("EmotiveVoldermort35", TempSound);
	TempSoundLen = GetSoundDuration( TempSound );
	if( TempSoundLen == 0 )
		TempSoundLen = 1.0;
	PlaySound( TempSound, SLOT_None );

	//Sleep( 0.333 );
	//TempSoundLen -= 0.333;
	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Volume]1.0, [Radius]20000, [Pitch]RandRange( 0.9, 1.1 ));
	spawn( class'VoldEffectCircling' );

	Sleep( 0.25 );
	TempSoundLen -= 0.25;

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Volume]0.7, [Radius]20000, [Pitch]RandRange( 0.8, 1.0 ));
	spawn( class'VoldEffectCircling' );

	Sleep( 0.25 );
	TempSoundLen -= 0.25;

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Volume]0.4, [Radius]20000, [Pitch]RandRange( 0.7, 0.9 ));
	spawn( class'VoldEffectCircling' );

	Sleep( 0.25 );
	TempSoundLen -= 0.25;

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Volume]0.4, [Radius]20000, [Pitch]RandRange( 0.6, 0.8 ));
	spawn( class'VoldEffectCircling' );

	Sleep( FMax( 0, TempSoundLen ) );


	FindEmote("EmotiveVoldermort36", TempSound);
	TempSoundLen = GetSoundDuration( TempSound );
	if( TempSoundLen == 0 )
		TempSoundLen = 1.0;
	PlaySound( TempSound );
	Sleep( TempSoundLen + 0.25 );

	Goto 'Loop';
}

//*************************************************************************************************************************
state stateDead
{
  Begin:
	//Uh oh, is this a hack?  dunno.  Seems ok.  If Vold has been killed, add 60 points to harrys house points.
	playerHarry.Add60HousePointsToGryffindor();

	PlayAnim('die',0.25);

	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	//playSound(sound'HPSounds.hub2_sfx.fireplace_flare', [Pitch]RandRange( 0.8, 1.2 ) );

	//playSound(sound'HPSounds.hub5_sfx.rock_breaking');
	playSound(sound'HPSounds.hub5_sfx.troll_smasher', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	//playSound(sound'HPSounds.hub5_sfx.troll-thump');  //quiet
	//playSound(sound'HPSounds.hub5_sfx.voldemart-fire');
	//playSound(sound'HPSounds.hub5_sfx.voldemart-fire2');
	//playSound(sound'HPSounds.hub5_sfx.voldemorts-pillars-explode');
	//playSound(sound'HPSounds.hub5_sfx.whoosh2');  //quiet

	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub2_sfx.fireplace_flare', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	SendDefeatedTrigger();

	SpawnVoldFireBalls( 1, false );

	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	SpawnVoldFireBalls( 2, false );

	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub5_sfx.troll_smasher', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	SpawnVoldFireBalls( 3, false );

	spawn( class'VoldEffectCircling' );
	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ));
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	SpawnVoldFireBalls( 3, false );

	playSound(sound'HPSounds.hub5_sfx.troll_smasher', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectCircling' );
	spawn( class'VoldEffectCircling' );

	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	SpawnVoldFireBalls( 4, false );

	spawn( class'VoldEffectCircling' );
	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub5_sfx.rock_breaking', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.5);

	SpawnVoldFireBalls( 4, false );

	spawn( class'VoldEffectCircling' );
	spawn( class'VoldEffectCircling' );
	spawn( class'VoldEffectCircling' );

	playSound(sound'HPSounds.hub3_sfx.wind_violent_burst1', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ));
	spawn( class'VoldEffectLob' );
	Sleep(0.5);
	spawn( class'VoldEffectLob' );
	Sleep(0.2);
	spawn( class'VoldEffectLob' );
	Sleep(0.2);

	playSound(sound'HPSounds.hub5_sfx.troll_smasher', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	SpawnVoldFireBalls( 3, false );
	Sleep(1);
	SpawnVoldFireBalls( 1, false );
	playSound(sound'HPSounds.hub5_sfx.rock_breaking', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );
	playSound(sound'HPSounds.hub5_sfx.voldemart_fire2', SLOT_None, [Radius]20000, [Pitch]RandRange( 0.8, 1.2 ) );
	SpawnVoldFireBalls( 10, false );
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );
	Sleep(0.10);
	spawn( class'VoldEffectLob' );

	sleep( 2 );

  Loop:
	Sleep(1);
	Goto 'Loop';
}

//*************************************************************************************************************************
function SpawnVoldFireBalls( int NumFireBalls, bool bShootOneAtHarry )
{
	local int             i;
	local int             count;
	local rotator         r;
	local vector          v;
	local VoldBigFireBall a;

	count = NumFireBalls; //Rand(

	for( i = 0; i < count; i++ )
	{
		v = playerHarry.Location - Location;
		r = rotator( v );
		r.yaw += FRand()*20000 - 10000;
		r.pitch = FRand()*4000;
		v = vector( r );
		a = spawn( class'VoldBigFireBall' );
		a.Velocity = v * a.fFireBallSpeed;
	}
}

/*
EmotiveVoldermort1 n
EmotiveVoldermort3 n
EmotiveVoldermort4 n
EmotiveVoldermort5 n
EmotiveVoldermort7 n
EmotiveVoldermort9 n

EmotiveVoldermort2 -
EmotiveVoldermort6 -
EmotiveVoldermort8 -
EmotiveVoldermort11 -
EmotiveVoldermort12 -
EmotiveVoldermort13 -
EmotiveVoldermort14 -
EmotiveVoldermort15 -
EmotiveVoldermort16 -
EmotiveVoldermort17 -
EmotiveVoldermort18 -

EmotiveVoldermort10 +
EmotiveVoldermort19 +
EmotiveVoldermort20 +
EmotiveVoldermort21 +
EmotiveVoldermort22 +

EmotiveVoldermort35 l
EmotiveVoldermort36 l
EmotiveVoldermort37 l
EmotiveVoldermort38 l
*/

//*************************************************************************************************************************
function PlayFirstTalkSpeech()
{
	local sound  snd;
	local string str;

	TimeOfLastSpeech = Level.TimeSeconds;

	FindDialog("147Voldermort22", snd, str);
	PlaySound( snd, [Radius]100000 );
}

//*************************************************************************************************************************
function PlayCastASpellSpeech()
{
	local sound  snd;
	local string str;
	local float  pitch;

	if( Level.TimeSeconds - TimeOfLastSpeech < 4 )
		return;

	TimeOfLastSpeech = Level.TimeSeconds;

	pitch = 0.9;

	switch( iCastASpellSpeech )
	{
		//case 0:		FindDialog("147QuirrelEnd1", snd, str);      break;
		case 0:		FindDialog("147QuirrelMisc2", snd, str);  pitch = 0.6;   break;
		case 1:		FindDialog("BlankVoldermort1", snd, str);                break;
		case 2:		FindDialog("147Voldermort22", snd, str);                 break;
		case 3:		FindDialog("BlankVoldermort2", snd, str);                break;
		case 4:		FindDialog("147Voldermort23", snd, str);                 break;
		case 5:		FindDialog("BlankVoldermort3", snd, str);                break;
		case 6:		FindDialog("147Voldermort21", snd, str);                 break;
		case 7:		FindDialog("BlankVoldermort4", snd, str);                break;
		case 8:		FindDialog("147Voldermort16", snd, str);                 break;

	}

	PlaySound( snd, [Radius]100000, [Pitch]pitch );

	if( ++iCastASpellSpeech > 8 )
		iCastASpellSpeech = 0;
}

//*************************************************************************************************************************
function PlayCastingASpellEmote()
{
	local sound  snd;
	local string str;

	//if( Level.TimeSeconds - TimeOfLastSpeech < 4 )
	//	return;


	switch( iCastingASpellEmote )
	{
		case 0:		FindEmote("EmotiveVoldermort1", snd);     break;
		case 1:		FindEmote("EmotiveVoldermort3", snd);     break;
		case 2:		FindEmote("EmotiveVoldermort4", snd);     break;
		case 3:		FindEmote("EmotiveVoldermort5", snd);     break;
		case 4:		FindEmote("EmotiveVoldermort7", snd);     break;
		case 5:		FindEmote("EmotiveVoldermort9", snd);     break;
	}

	PlaySound( snd, SLOT_Misc, [Radius]100000 );

	if( ++iCastingASpellEmote > 5 )
		iCastingASpellEmote = 0;
}

//*************************************************************************************************************************
function PlayHurtHarryEmote()
{
	local sound  snd;
	local string str;

	//if( Level.TimeSeconds - TimeOfLastSpeech < 2 )
	//	return;

	TimeOfLastSpeech = Level.TimeSeconds;
	TimeOfLastHarryHurt = Level.TimeSeconds;

	switch( iHurtHarryEmote )
	{
		case 0:		FindEmote("EmotiveVoldermort10", snd); playerHarry.ClientMessage("EmotiveVoldermort10:"$snd);    break;
		case 1:		FindEmote("EmotiveVoldermort35", snd); playerHarry.ClientMessage("EmotiveVoldermort35:"$snd);    break;
		case 2:		FindEmote("EmotiveVoldermort19", snd); playerHarry.ClientMessage("EmotiveVoldermort19:"$snd);    break;
		case 3:		FindEmote("EmotiveVoldermort36", snd); playerHarry.ClientMessage("EmotiveVoldermort36:"$snd);    break;
		case 4:		FindEmote("EmotiveVoldermort20", snd); playerHarry.ClientMessage("EmotiveVoldermort20:"$snd);    break;
		case 5:		FindEmote("EmotiveVoldermort21", snd); playerHarry.ClientMessage("EmotiveVoldermort21:"$snd);    break;
		case 6:		FindEmote("EmotiveVoldermort37", snd); playerHarry.ClientMessage("EmotiveVoldermort37:"$snd);    break;
		case 7:		FindEmote("EmotiveVoldermort22", snd); playerHarry.ClientMessage("EmotiveVoldermort22:"$snd);    break;
		case 8:		FindEmote("EmotiveVoldermort38", snd); playerHarry.ClientMessage("EmotiveVoldermort38:"$snd);    break;
	}

	PlaySound( snd/*, SLOT_Misc*/, [Radius]100000 );

	if( ++iHurtHarryEmote > 8 )
		iHurtHarryEmote = 0;
}

//*************************************************************************************************************************
function PlayGetsHurtSfx()
{
	local sound  snd;
	local string str;
	local float  PlaySpeed;

	//if( Level.TimeSeconds - TimeOfLastSpeech < 4 )
	//	return;

	PlaySpeed = 1.0;

	switch( iGetsHurtSfx )
	{
//		case 0:		snd = Sound'HPSounds.critters_sfx.troll_roar3';    PlaySpeed=1.75;    break;
		case 1:		FindEmote("EmotiveVoldermort2", snd);                                 break;
//		case 2:		snd = Sound'HPSounds.critters_sfx.troll_ouch1';    PlaySpeed=1.75;    break;
		case 3:		FindEmote("EmotiveVoldermort6", snd);                                 break;
//		case 4:		snd = Sound'HPSounds.critters_sfx.troll_roar1';    PlaySpeed=1.75;    break;
		case 5:		FindEmote("EmotiveVoldermort8", snd);                                 break;
//		case 6:		snd = Sound'HPSounds.critters_sfx.troll_ouch3';    PlaySpeed=1.75;    break;
		case 7:		FindEmote("EmotiveVoldermort11", snd);                                break;
//		case 8:		snd = Sound'HPSounds.critters_sfx.troll_roar2';    PlaySpeed=1.75;    break;
		case 9:		FindEmote("EmotiveVoldermort12", snd);                                break;
		case 10:	FindEmote("EmotiveVoldermort13", snd);                                break;
		case 11:	FindEmote("EmotiveVoldermort14", snd);                                break;
		case 12:	FindEmote("EmotiveVoldermort15", snd);                                break;
		case 13:	FindEmote("EmotiveVoldermort16", snd);                                break;
		case 14:	FindEmote("EmotiveVoldermort17", snd);                                break;
		case 15:	FindEmote("EmotiveVoldermort18", snd);                                break;
	}

	PlaySound( snd, SLOT_Misc, [Radius]100000, [Pitch]PlaySpeed );

	if( ++iGetsHurtSfx > 15 )
		iGetsHurtSfx = 0;
}

//*************************************************************************************************************************
function PlayGetsHurtSpeech()
{
	local sound  snd;
	local string str;

	if( Level.TimeSeconds - TimeOfLastSpeech < 4 )
		return;

	TimeOfLastSpeech = Level.TimeSeconds;

	switch( iGetsHurtSpeech )
	{
		//case 0:		FindDialog("147QuirrelMisc1", snd, str);     break;
		//case 1:		FindDialog("147QuirrelMisc2", snd, str);     break;
		//case 2:		FindDialog("147QuirrelMisc3", snd, str);     break;
		//case 3:		FindDialog("147QuirrelMisc4", snd, str);     break;
		case 0:		FindDialog("147Voldemort5", snd, str);       break;
		case 1:		FindDialog("147Voldermort16", snd, str);     break;
		case 2:		FindDialog("147Voldermort21", snd, str);     break;
	}

	PlaySound( snd, [Radius]100000 );

	if( ++iGetsHurtSpeech > 2 )
		iGetsHurtSpeech = 0;
}

//*************************************************************************************************************************
function PlayDieSpeech()
{
	local sound  snd;
	local string str;

	FindDialog("147Voldermort31", snd, str);
	PlaySound( snd, [Radius]100000 );
}

//*************************************************************************************************************************

defaultproperties
{
     NumColumns=4
     NumPointsBetweenColumns=2
     bBattlePhaseOne=True
     bWasJustShooting=True
     BossRadiusNavPointTag=BossRadiusTag
     fWalkAnimMultiplier=1.6
     GroundSpeed=150
     BaseEyeHeight=45
     EyeHeight=45
     Health=80
     MenuName="BossSquirrel"
     Physics=PHYS_Walking
     Mesh=SkeletalMesh'HPModels.skvoldemortMesh'
     DrawScale=1
     CollisionHeight=70
}
