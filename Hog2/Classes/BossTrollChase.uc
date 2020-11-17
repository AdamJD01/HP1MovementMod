class BossTrollChase expands baseBoss;

var() float    MinGroundSpeed;  //the slowest the boss can run
var() float    AnimRateWhenRunning100UPS;

var(Boss_Jump) float  fJumpHorizSpeed;
var(Boss_Jump) float  fJumpVertSpeed;
//var(Boss_Jump) float  fJumpGravityBoost;
var(Boss_Jump) float  fJumpAnimMultiplier;

var()          float  fSwingClubAnimRate;
var            bool   bSwingingClub;
var            bool   bPlayedSwingSound;
var            float  fSwingClubTime;
var            bool   bSwingCheckedForHarry;
var            bool   bIgnoreHarry;

//var            bool   bHarryAlive;

var            vector vTempVector;

var            float  fJumpZ;
var            float  JumpAnimSpeed;
var            bool   bLandingJump;
var            bool   bJumpLeftFoot;

var            float  AmbientSoundTimer;
var            float  AmbientTrollSoundTimer;

//*******************************************************************************
function PostBeginPlay()
{
	SetAmbientSoundTime();
}

//*******************************************************************************
function Tick(float dtime)
{
	local float    d;
	local float    as;

	//playerHarry.ClientMessage("TrollLoc:"$Location);

	if( IsInState('patrol') )
	{
		if( bIgnoreHarry )  //if ignoring harry, just run at the MinGroundSpeed rate
		{
			GroundSpeed = MinGroundSpeed;
		}
		else //tracking harry
		{
			//First off, if Velocity dot DirToHarry < 0, Harry dies
			if( (vect(1,0,0)/*vector(Rotation)*/ dot (playerHarry.Location - Location)) < 0 )
			{
				if( !playerHarry.IsInState('stateDead') )
					GotoState('stateMoveToHarryAndClubHim');
				else
					GotoState('stateStompOnHarry');  //already hit with club, or dead, just stomp on him
			}

			//Set ground speed based on how far away from harry
			d = VSize(Location - playerHarry.Location);

			if( d < 200 )
				GroundSpeed = MinGroundSpeed;
			else
				GroundSpeed = FMin(800, MinGroundSpeed + (d-200) / 1.0); //The smaller the denom, the quicker he cathes up

			//Now then, if d goes to n or less, swing the club
			if( d < 180  &&  !bSwingingClub )
				SwingClub();

		}

		//Form ground speed, set anim rate
		as = GetRunningAnimRate();

		if( !bSwingingClub )
			loopAnim('run', as, 0.5);

		AmbientSoundTimer -= dtime;
		if( AmbientSoundTimer <= 0 )
		{
			SetAmbientSoundTime();
			switch( Rand(2) )
			{
				case 0:    PlaySound( Sound'HPSounds.hub1_sfx.wood_door_close1', SLOT_None, [Volume]RandRange(0.2, 0.4), [Radius]100000, [Pitch]RandRange(0.8, 1.2));   break;
				case 1:    PlaySound( Sound'HPSounds.hub1_sfx.wood_door_open1', SLOT_None, [Volume]RandRange(0.2, 0.4), [Radius]100000, [Pitch]RandRange(0.8, 1.2));   break;
			}
		}

		AmbientTrollSoundTimer -= dtime;
		if( AmbientTrollSoundTimer <= 0 )
		{
			AmbientTrollSoundTimer = RandRange(4, 12);
			switch( Rand(3) )
			{
				case 0:    PlaySound( Sound'HPSounds.critters_sfx.troll_attack1', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.8, 1.1));   break;
				case 1:    PlaySound( Sound'HPSounds.critters_sfx.troll_attack2', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.8, 1.1));   break;
				case 2:    PlaySound( Sound'HPSounds.critters_sfx.troll_attack3', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.8, 1.1));   break;
			}
		}
	}

	//The idea here is, you can be in state stateStompOnHarry, and still be swinging your club.

	//Update our swinging club
	if( bSwingingClub )
	{
		fSwingClubTime += dtime;

		if( !bPlayedSwingSound && fSwingClubTime > 1.5/fSwingClubAnimRate )
		{
			bPlayedSwingSound = true;
			PlaySound( Sound'HPSounds.magic_sfx.s_spell_oops', [Radius]100000, [Pitch]RandRange(0.6, 0.65));
		}

		//Check and see if we should check for harry
		if( !bIgnoreHarry  &&  !bSwingCheckedForHarry  &&  fSwingClubTime > 2.45/fSwingClubAnimRate )//3.8 2.0 2.9
		{
			bSwingCheckedForHarry = true;

			if( VSize2d(Location - playerHarry.Location) < 165 )
			{
				if( !playerHarry.IsInState('stateDead') )
				{
					playerHarry.KillHarryWithClub( true, self );

					//PlaySound( sound'HPSounds.quidditch_sfx.Q_collision3', [Radius]100000 );
					PlaySound( sound'HPSounds.Hub3_sfx.troll_club_hit', [Radius]100000 );
				}

				GotoState('stateStompOnHarry');  //already hit with club, just stomp on him
			}
		}

		//Check and see if we're done swinging the club.  This should really check and see
		// how long the anim is.
		if( fSwingClubTime > 4.0/fSwingClubAnimRate )
			bSwingingClub = false;
	}
}

//*************************************************************************************************************************
function vector GetCameraOffset()
{
	return vect(200,0,0);
}

//*******************************************************************************
function SetAmbientSoundTime()
{
	AmbientSoundTimer = RandRange(1.5, 3);
}

//*******************************************************************************
function playfootstep()
{
	//PlaySound( Sound'HPSounds.hub1_sfx.chest_landing', [Volume]RandRange(0.25, 0.5), [Radius]100000, [Pitch]RandRange(0.7, 1.2) );
	if( Rand(2) == 0 )
		PlaySound( Sound'HPSounds.FootSteps.TRO_foot1', SLOT_None, [Volume]RandRange(0.7, 1.0), [Radius]100000, [Pitch]RandRange(0.7, 1.2) );
	else
		PlaySound( Sound'HPSounds.FootSteps.TRO_foot2', SLOT_None, [Volume]RandRange(0.7, 1.0), [Radius]100000, [Pitch]RandRange(0.7, 1.2) );
}

//*******************************************************************************
function float GetRunningAnimRate()
{
	local float  as;
	as = AnimRateWhenRunning100UPS * GroundSpeed/100 / DrawScale;
	as = FMin( 3.0, as );
	as = FMax( 0.45, as );
	return as;
}

//*******************************************************************************
function SwingClub()
{
	bSwingingClub = true;
	bSwingCheckedForHarry = false;
	bPlayedSwingSound = false;
	fSwingClubTime = 0;
	PlayAnim('swing', fSwingClubAnimRate, 0.1, AT_Replace, 'mtroll spine1');//, EAnimType Type, optional name RootBone );
	//LoopAnim(walkAnimName, , , , AT_Combine);
}

//*******************************************************************************
//event HitWall( vector HitNormal, actor HitWall )
//{
//	playerHarry.clientmessage("Troll HitWall");
//}

//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	if( !IsInState('stateJump') && !IsInState('stateMoveToHarryAndClubHim') && !IsInState('stateStompOnHarry') )
	{
		//cam.CameraOffset = vect(200,0,0);   done in StartBossEncounter
		GotoState('stateDoRoar');
	}
}

//*******************************************************************************
function StopBossEncounter()
{
	super.StopBossEncounter();

	bIgnoreHarry = true;
}

//*******************************************************************************************************
function PostPawnAtPatrolPoint(PatrolPoint CurrentP, PatrolPoint NextP)
{
	local float       d;
	local float       s;
	local float       TimeInAirScalar;
	local vector      v;

	if( CurrentP.PatrolAnim == 'jump' )
	{
		GotoState('stateJump');

		Velocity = normal( (navP.Location - LastNavP.Location) * vect(1,1,0) ) * GroundSpeed;
		d = GroundSpeed;//VSize( Velocity );

		//Look for values set in the actual PatrolPoint object
		if( CurrentP.fJumpHorizSpeed > 0 )
			s = CurrentP.fJumpHorizSpeed;
		else
			s = fJumpHorizSpeed;

		Velocity = s * Velocity/d;

		if( CurrentP.fJumpVertSpeed > 0 )
			s = CurrentP.fJumpVertSpeed;
		else
			s = fJumpVertSpeed;

		Velocity.z = s;

		TimeInAirScalar = s / default.fJumpVertSpeed;

		if( CurrentP.fJumpAnimMultiplier > 0 )
			s = CurrentP.fJumpAnimMultiplier;
		else
			s = fJumpAnimMultiplier;

		JumpAnimSpeed = 0.25/TimeInAirScalar * s;

		//Assume we're running, and see where we are in our run cycle
		if( AnimFrame < 13.0/45.0 || AnimFrame > 35.0/45.0 )
		{
			bJumpLeftFoot = false;
			//PlayAnim('JumpRight', 0.25/TimeInAirScalar * s, 0.3);
			PlayAnim('JumpRightStart', 2.0, 0.1);
		}
		else
		{
			bJumpLeftFoot = true;
			//PlayAnim('JumpLeft',  0.25/TimeInAirScalar * s, 0.3);
			PlayAnim('JumpLeftStart', 2.0, 0.1);
		}

		Acceleration = vec(0, 0, 0);//-fJumpGravityBoost);

		SetPhysics( PHYS_Falling );

		fJumpZ = Location.z;
		bLandingJump = false;

		PlaySound( Sound'HPSounds.critters_sfx.troll_jump', SLOT_None, [Volume]RandRange(0.6, 0.9), [Radius]100000 );//, [Pitch]RandRange(0.6, 0.65));

		//Tick will now check for when we land...
	}

	//CurrentP.Destroy();    Dont need to do this any more.
}

//*******************************************************************************************************
//Overridden from baseChar
function patrolPlayWalkAnim()
{
	//Anim already playing in stateJump::Tick before you land the jump
	//loopAnim(walkAnimName, , 0.3);
}

//*******************************************************************************
state stateJump
{
	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	event Tick(float dtime)
	{
		//When we stop moving, go back to patrol
		if( !bLandingJump  &&  Velocity.z < 0  &&  Location.z < fJumpZ+15 )
		{
			bLandingJump = true;
			loopAnim('run', AnimRateWhenRunning100UPS, 0.15);
		}

		if( Velocity == vect(0,0,0) )
		{
			//PlaySound( Sound'HPSounds.hub1_sfx.wood_door_raise', [Radius]2000 );
			//PlaySound( Sound'HPSounds.hub2_sfx.tree_crash', [Volume]0.6, [Radius]100000 );
			PlaySound( Sound'HPSounds.critters_sfx.troll_landing', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000 );//, [Pitch]RandRange(0.6, 0.65));

			Acceleration = vect(0,0,0);
			GotoState('patrol');
		}
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	function AnimEnd()
	{
		if( !bJumpLeftFoot )
			PlayAnim('JumpRight', JumpAnimSpeed, 0.1);
		else
			PlayAnim('JumpLeft',  JumpAnimSpeed, 0.1);

		disable('AnimEnd');
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	function EndState()
	{
		//enable('AnimEnd');
	}
}

//*******************************************************************************
auto state stateIdle
{
  Begin:
	loopanim('breath', 0.5);
	sleep(5);
	goto 'Begin';
}

//*******************************************************************************
//This is more of a startup state
state stateDoRoar
{
  Begin:
	//playerHarry.GotoState('CutIdleing');
	sleep( 1 );//0.75);

/*
	PlayAnim('roar', 2.0);

	switch( Rand(3) )
	{
		case 0: PlaySound( Sound'HPSounds.critters_sfx.troll_roar1', SLOT_None); break;
		case 1: PlaySound( Sound'HPSounds.critters_sfx.troll_roar2', SLOT_None); break;
		case 2: PlaySound( Sound'HPSounds.critters_sfx.troll_roar3', SLOT_None); break;
	}

	FinishAnim();

	//Ooof, when did I do this?
	//playerHarry.GotoState('PlayerWalking');
*/
	GotoState('patrol');
}

//*******************************************************************************
state stateMoveToHarryAndClubHim
{
  Begin:
	//playerHarry.ClientMessage("stateMoveToHarryAndClubHim***********");
	//Stop harry from moving
	if( !playerHarry.IsInState('stateDead') )
		playerHarry.gotostate('CutIdleing');

	GroundSpeed = MinGroundSpeed * 2;
    RotationRate.Yaw = 50000;

	//If further away than 100, MoveTo about 100 units away from harry.
	if( VSize2d( Location - playerHarry.Location ) > 100 )
	{
		vTempVector = Location - playerHarry.Location;
		vTempVector.z = 0;
		vTempVector = FindBestLocToMoveTo( playerHarry.Location + normal(vTempVector)*100 );
		MoveTo( vTempVector );
	}

	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);

	PlayAnim('breathe', 1, 0.25, AT_Combine);//, EAnimType Type, optional name RootBone );

	//You may already be swinging a club, wait for it to finish
	while( bSwingingClub )
		Sleep( 0.05 );

	//If Harry's still alive, do another club swing.  Gotta get his brains up on the wall...
	if( !playerHarry.IsInState('stateDead') )
	{
		SwingClub();

		while( bSwingingClub )
			Sleep( 0.1 );
	}

	//If he's still alive, kill him
	if( !playerHarry.IsInState('stateDead') )
		playerHarry.KillHarryWithClub(true, self);

	GotoState('stateStompOnHarry');
}

//*******************************************************************************
//if harry is down a pit, vDest.z will be considerably lower than the troll
// Keep moving forward 20 units and down 20 units, until you actually do move down 20 units.
function vector FindBestLocToMoveTo( vector vDest )
{
	local float d;
	local vector n;
	local vector v, vLast, vSave;

	vSave = Location;

	n = vDest - Location;
	d = VSize2d( n );
	n.z = 0;
	n = normal( n );

	v = Location;

	do
	{
		vLast = v;
		v += n*20;
		MoveSmooth( n*20 );

		if( Location != v )
		{
			v = vLast;
			break;
		}

		//See if we can go down
		MoveSmooth( vect(0,0,-20) );

		if( v.z - Location.z > 19 )
		{
			v = vLast;
			break;
		}

		SetLocation( v );

		d -= 20;

	}until( d <= 0 );

	if( d <= 0 )
		v = vDest;

	SetLocation( vSave );

	return v;
}

//*******************************************************************************
state stateStompOnHarry
{
  Begin:
	//Stop harry from moving
	//playerHarry.gotostate('CutIdleing');

	if( VSize2d( playerHarry.Location - Location ) > 170 )
	{
		GroundSpeed = MinGroundSpeed * 2;
		RotationRate.Yaw = 50000;

		LoopAnim('walk', GetRunningAnimRate(), 0.1);

		vTempVector = Location - playerHarry.Location;
		vTempVector.z = 0;
		vTempVector = FindBestLocToMoveTo( playerHarry.Location + normal(vTempVector)*50 );

		MoveTo( vTempVector );
	}

	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);

	PlayAnim('breathe', 1, 0.25, AT_Combine);//, EAnimType Type, optional name RootBone );
	//FinishAnim();

	//Now, harry can die.  Actually, I just kill him right away now.
	playerHarry.bAllowHarryToDie = true;

  loop:
	Sleep(1);
	goto 'loop';
}

//*******************************************************************************

defaultproperties
{
     MinGroundSpeed=150
     AnimRateWhenRunning100UPS=0.6
     fJumpHorizSpeed=300
     fJumpVertSpeed=400
     fJumpAnimMultiplier=3
     fSwingClubAnimRate=1
     CamStateName=PatrolState
     bUseFrayMoveTo=True
     GroundSpeed=150
     DrawScale=1.3
     RotationRate=(Yaw=10000)
}
