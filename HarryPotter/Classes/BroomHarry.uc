//=============================================================================
// BroomHarry  -- hero character, on a broom
//=============================================================================
class BroomHarry extends Harry;

var float	fPitchControl;		// Range +1.0 to -1.0 (up/down)
var float	fYawControl;		// Range +1.0 to -1.0 (right/left)
var float	fRotationRateYaw;	// Yaw uses this because Roll is tied to RotationRate.Yaw for some reason

var(Movement) int	AirSpeedNormal;	// How fast Harry flies when neither boosted nor braked
var(Movement) int	AirSpeedBoost;	// How fast Harry flies when boosted

var(Movement) int	PitchLimitUp;	// How high can Harry pitch broom up; degrees
var(Movement) int	PitchLimitDown;	// How low can Harry pitch broom down; degrees

var(Movement) int	WallDamage;		// How much damage Harry takes when he hits walls

var bool	bAuxBoost;			// Non-interactive Boost command that can come from game script
var	int		Deceleration;

var bool	bHasEverBoosted;	// Has the boost button ever been pressed
var bool	bHasEverBraked;		// Has the brake button ever been pressed

var bool	bActioned;			// Harry was pressed the action key this tick
var bool	bWasActioning;		// Harry was pressing the action key last tick

var float	fMousePitch;		// Cumulative Pitch from mouse axis motion
var float	fMouseYaw;			// Cumulative Yaw from mouse axis motion
var float	fBroomSensitivity;	// Scalar on Broom axis inputs (mouse)

var bool	bYawUnderMouse;		// Yaw is being controlled by mouse rather than keyboard
var bool	bPitchUnderMouse;	// Pitch is being controlled by mouse rather than keyboard

var bool	bLastYawNeg;		// Last change in yaw was in negative direction (for statistics)
var bool	bLastPitchNeg;		// Last change in pitch was in negative direction (for statistics)

var bool	bHitWall;			// Reacting to initial collision with wall
var bool	bHittingWall;		// In contact with wall this tick
var int		WallAvoidanceYaw;	// How far Harry should turn to avoid wall (while hitting it)
var float	fWallAvoidanceRate;	// How fast Harry should turn to avoid wall (while hitting it)
var float	fLastTimeAvoidedWall;	// When wall avoidance was last applied
var bool	bLastAvoidanceRight;// Whether last avoidance rotation was toward the right
const		fMaxTimeSameAvoidDir = 1.0f;	// How long Harry can go between wall hits before clearing current avoidance direction trend


var GameReferee	Referee;		// Object in charge of the rules of the current mini-game that Harry's playing

var name	PrimaryAnim;		// What underlying broom animation is Harry looping right now
var name	SecondaryAnim;		// What overlay animation is Harry looping right now

var Sound	BroomSound;			// The sound of broom in flight
var Sound	MainBroomSound;			// The sound of broom in flight

const		NUM_HIT_SOUNDS = 3;
var Sound	HitSounds[3];		// All the different sounds of Harry hitting an obstacle

var InterpolationManager		IM;
var DynamicInterpolationPoint	TransPath[2];	// Transitional path to follow to get to main path
var int							iTransPoint;	// Position Id of point on main path that player is transitioning to

var ParticleFX	Trail;

var Actor	LookForTarget;		// Thing Harry should appear to look for when that thing isn't visible
var bool	bLookingForTarget;	// Whether Harry is currently looking around for target

var Actor	TargetToCatch;		// Thing Harry is in process of catching and putting in hand
var name	PathAfterCatch;		// What path Harry should go fly on after catching target

const		MAX_REVERSAL_STATS = 20;
var float	fTimesOfLastReversals[20];	// Statistics for how often pitch and yaw reversals are happening
var int		iNextReversalStat;			// Which slot in above array is next to fill
const		fReversalsStatPeriod = 2.5;	// The time window (seconds) for which to compute current reversal rate

//-------------------------------------------------------------------------------------------
// PreBeginPlay(), PostBeginPlay(), and common events
//-------------------------------------------------------------------------------------------

function PreBeginPlay()
{
	// Initialize
	Super.PreBeginPlay();

	// Find mini-game referee
	foreach AllActors( class'GameReferee', Referee )
		break;
}

function PostBeginPlay()
{
	local int	iStat;

	// Initialize Harry
	Super.PostBeginPlay();
	SetPhysics(PHYS_Flying);

	// Setup animation layering
	PrimaryAnim = 'Hover';
	SecondaryAnim = '';
	LoopAnim( PrimaryAnim );
	LookForTarget = None;
	bLookingForTarget = false;

	// Load Sounds
	BroomSound = Sound'HPSounds.Quidditch_sfx.Flying_Broom_Loop';
	MainBroomSound = Sound'HPSounds.Quidditch_sfx.broomlp_nl3';

	HitSounds[0] = Sound'HPSounds.Quidditch_sfx.Q_Collision1';
	HitSounds[1] = Sound'HPSounds.Quidditch_sfx.Q_Collision2';
	HitSounds[2] = Sound'HPSounds.Quidditch_sfx.Q_Collision3';

	// Force rotation rates (ignore settings in editor)
	fRotationRateYaw = 20000;	// Yaw uses this override because roll is tied to RotationRate.Yaw
	RotationRate.Yaw = 50000;
	RotationRate.Roll = 6000;
	RotationRate.Pitch = 24000;

	fBroomSensitivity = 1.0/20000.0;

	fMouseYaw = 0.0;
	fMousePitch = 0.0;
	bYawUnderMouse = false;
	bPitchUnderMouse = false;
	bLastYawNeg = false;
	bLastPitchNeg = false;

	bAuxBoost = false;
	Deceleration = 0;
	bHasEverBoosted = false;
	bHasEverBraked = false;
	bActioned = false;
	bWasActioning = false;

	bHitWall = false;
	bHittingWall = false;
	fLastTimeAvoidedWall = -1.0f;

	// Initialize control stats
	for ( iStat = 0; iStat < MAX_REVERSAL_STATS; ++iStat )
		fTimesOfLastReversals[ iStat ] = -9999.9;	// A time well before the game started
	iNextReversalStat = 0;

	// Add a broom effect.
	Trail = spawn(class'BroomTrail_02', [SpawnOwner] self);
	Trail.AttachToOwner('BroomTail');

//	lifePotions = 5;	// *** Test for dying ***
}

event Possess()
{
	// Called when the PlayerPawn Harry is possessed (attached) to a viewport (Player).
	Super.Possess();

	// Make sure the right physics is selected (workaround for bug with
	// LoadGame where physics isn't set correctly)
	Log( "BroomHarry in State "$GetStateName()$"." );

	if ( IsInState( 'BroomDying' ) )
		SetPhysics( PHYS_Falling );
	else
		SetPhysics( PHYS_Flying );

	// Let referee know possession has occurred happened
	Referee.OnPlayerPossessed();
}

event PlayerInput( float DeltaTime )
{
	Super.PlayerInput( DeltaTime );

	// Check the action button
	bActioned = false;
	if ( bBroomAction != 0 )
	{
		if ( !bWasActioning )
		{
			bActioned = true;
			Referee.OnActionKeyPressed();
		}
		bWasActioning = true;
	}
	else
		bWasActioning = false;

	// Check the boost and brake buttons
	if ( bBroomBoost != 0 )
		bHasEverBoosted = true;
	if ( bBroomBrake != 0 )
		bHasEverBraked = true;
}


//-------------------------------------------------------------------------------------------
// Operational methods
//-------------------------------------------------------------------------------------------

function SetPrimaryAnimation( name NewPrimaryAnim, optional float Rate, optional float TweenTime,
							  optional float MinRate, optional EAnimType Type, optional name RootBone )
{
	// Sets-up the primary animation to transition to the new animation and
	// makes sure the secondary animation still plays on top of it

	if ( NewPrimaryAnim != PrimaryAnim )
	{
		PrimaryAnim = NewPrimaryAnim;
		if ( PrimaryAnim != '' )
			LoopAnim( PrimaryAnim, /*Rate*/, TweenTime, MinRate /*, Type, RootBone*/ );
		if ( SecondaryAnim != '' )
			LoopAnim( SecondaryAnim, , TweenTime );
	}
}

function SetSecondaryAnimation( name NewSecondaryAnim, optional float Rate, optional float TweenTime,
								optional float MinRate, optional EAnimType Type, optional name RootBone )
{
	// Sets-up the secondary animation to transition to the new animation and
	// makes sure the primary animation still plays under it

	if ( NewSecondaryAnim != SecondaryAnim )
	{
		SecondaryAnim = NewSecondaryAnim;
		if ( PrimaryAnim != '' )
			LoopAnim( PrimaryAnim, , TweenTime );
		if ( SecondaryAnim != '' )
			LoopAnim( SecondaryAnim, /*Rate*/, TweenTime, MinRate /*, Type, RootBone*/ );
	}
}

function DeterminePrimaryAnim()
{
	// Determine which animation is appropriate for current motion
	local float		Speed;

	Speed = VSize(Velocity);

	if ( !bHitWall )
	{
		if ( Rotation.roll > 1000 && Rotation.roll < 0x8000 )
			SetPrimaryAnimation( 'Turn_Right', , 1.0 );
		else if ( Rotation.roll < (0x00010000 - 1000) && Rotation.roll > 0x8000 )
			SetPrimaryAnimation( 'Turn_Left', , 1.0 );
		else if ( Rotation.pitch > 1000 && Rotation.pitch < 0x8000 )
			SetPrimaryAnimation( 'Pull_Up', , 1.0 );
		else if ( Rotation.pitch < (0x00010000 - 1000) && Rotation.pitch > 0x8000 )
			SetPrimaryAnimation( 'Dive', , 1.0 );
		else if ( bBroomBrake != 0 && Deceleration < AirSpeedNormal * 0.48 )
			SetPrimaryAnimation( 'Brake', , 1.0 );
		else if ( (bBroomBoost != 0 || bAuxBoost) && bBroomBrake == 0 )
			SetPrimaryAnimation( 'Boost', , 1.0 );
		else if ( Speed < 50 )
			SetPrimaryAnimation( 'Hover', , 0.4 );
		else
			SetPrimaryAnimation( 'Fly_Forward', , 1.0 );
	}

	Trail.ParentBlend = Min(Speed/200, 1);
}

function SetLookForTarget( Actor NewLookForTarget )
{
	// Notes what actor Harry should appear to "look for" when that actor isn't
	// visible.  If None, Harry won't look for anything.

	LookForTarget = NewLookForTarget;
}

function CatchTarget( Actor Target, optional name PathToFlyAfterCatch )
{
	// Causes Harry to animate a catch and hold sequence, and then put the
	// target in his hand.  The optional PathToFlyAfterCatch is what path
	// Harry should go fly on after catching the target; if None, harry will
	// continue as he's flying.

	TargetToCatch = Target;
	PathAfterCatch = PathToFlyAfterCatch;
	GotoState( 'Catching' );
}

//AE:
function PlayFastWhooshSound()
{
	switch( Rand(3) )
	{
		case 0:	PlaySound(sound'HPSounds.Quidditch_sfx.fast_whoosh_1');	break;
		case 1:	PlaySound(sound'HPSounds.Quidditch_sfx.fast_whoosh_2');	break;
		case 2:	PlaySound(sound'HPSounds.Quidditch_sfx.fast_whoosh_4');	break;
	}
}

//AE:
function PlaySlowWhooshSound()
{
	switch( Rand(3) )
	{
		case 0:	PlaySound(sound'HPSounds.Quidditch_sfx.slow_whoosh_1');	break;
		case 1:	PlaySound(sound'HPSounds.Quidditch_sfx.slow_whoosh_2');	break;
		case 2:	PlaySound(sound'HPSounds.Quidditch_sfx.slow_whoosh_3');	break;
	}
}

function UpdateBroomSound()
{
	// Sets the broom sound pitch and volume to correspond with Harry's motion
	local float		fSpeed;
	local float		fSpeedFactor;
	local float		fTurnFactor;
	local float		fVolume;
	local float		fPitch;

	// Compute the volume and pitch for the broom sound based on speed
	fSpeed = VSize( Velocity );
	if ( fSpeed < 50 )
	{
		fVolume = 0.0;
		fPitch  = 1.5;
	}
	else if ( fSpeed <= AirSpeedNormal )
	{
		PlaySound(sound'HPSounds.Quidditch_sfx.broom_accel');

		fSpeedFactor = (fSpeed - 50) / (AirSpeedNormal - 50);
		fVolume = 0.6 * fSpeedFactor;
		fPitch  = 0.2 * fSpeedFactor + 1.5;
	}
	else
	{
		fSpeedFactor = (fSpeed - AirSpeedNormal) / (AirSpeedBoost - AirSpeedNormal);
		fVolume = 0.4 * fSpeedFactor + 0.6;
		fPitch  = 0.15 * fSpeedFactor + 1.7;
	}

	// Modify volume and pitch to account for roll and pitch
	if ( Rotation.roll <= 0x8000 )
		fTurnFactor = Rotation.roll / 4096.0;
	else if ( Rotation.roll > 0x8000 )
		fTurnFactor = (0x00010000-Rotation.roll) / 4096.0;

	if ( Rotation.pitch <= 0x8000 )
		fTurnFactor += Rotation.pitch / 8192.0;
	else if ( Rotation.pitch > 0x8000 )
		fTurnFactor += (0x00010000-Rotation.pitch) / 8192.0;

	fTurnFactor *= 0.5;
	if ( fTurnFactor > 1.0 )
		fTurnFactor = 1.0;

	fVolume *= 1.0 + 2.0 * fTurnFactor;
	fPitch  *= 1.0 + 1.0 * fTurnFactor;

	//AE:
	if( fTurnFactor > 0.f && fTurnFactor < 0.1f )
	{
		if( fSpeedFactor > 0.7f )
			PlayFastWhooshSound();
		else
			PlaySlowWhooshSound();
	}

	//AE: Quiet background, dynamic hiss.
	if ( !ModifySound( SOUND_Volume, fTurnFactor, MainBroomSound, SLOT_Interact ) )
		PlaySound( MainBroomSound, SLOT_Interact, fTurnFactor, true, , 1.0 );

	// Change the broom sound parameters
	if ( !ModifySound( SOUND_Volume, fVolume, BroomSound, SLOT_Misc ) )
		PlaySound( BroomSound, SLOT_Misc, fVolume, true, , fPitch );	// Wasn't already playing; start it now
	else
		ModifySound( SOUND_Pitch, fPitch, BroomSound, SLOT_Misc );
}

function FlyOnPath( name CutScenePath, optional int StartPoint )
{
	local InterpolationPoint	i;

	if ( CutScenePath != '' )
	{
		// Put Harry at start point on its path
		foreach AllActors( class'InterpolationPoint', i, CutScenePath )
		{
			if ( i.Position == StartPoint )
			{
				SetLocation( i.Location );
				SetRotation( i.Rotation );
				SetCollision( true, false, false );
				bCollideWorld = false;
				bInterpolating = true;
				SetPhysics( PHYS_None );

				IM = Spawn( class'InterpolationManager', self );
				IM.Init( i.Next, 1.0, false );

				break;
			}
		}

		if ( IM == None )
		{
			Log( "Harry couldn't find path "$CutScenePath );
		}
		else
		{
			GotoState( 'FlyingOnPath' );
		}
	}
}

function StopFlyingOnPath()
{
	local InterpolationManager	IM_ToStop;

	if ( IM != None )
	{
		IM_ToStop = IM;
		IM = None;		// Tells FinishInterpolation event that path ended early
		IM_ToStop.FinishedInterpolation( None );
	}
	bCollideWorld = true;
	SetCollision( true, true, true );

	if ( IsInState( 'FlyingOnPath' ) )
		GotoState( 'PlayerWalking' );
}

function bool GetOnPath( name Path, optional int StartPoint )
{
	// Create and fly on a temporary path that connects with the named path.
	// If StartPoint is omitted (or 0), the temporary path connects to
	// the second closest point on the destination path; otherwise, the
	// connection is made at the specified StartPoint on the destination path.
	local float					fDistance;
	local InterpolationPoint	i;
	local vector				X,Y,Z;

	local float					fClosestDistance;
	local InterpolationPoint	ClosestPoint;
	local int					iClosestPoint;

	local float					fTransDistance;
	local InterpolationPoint	TransPoint;


	if ( Path == '' )
		return false;

	if ( StartPoint != 0 )
	{
		// Find the specified point on path
		foreach AllActors( class'InterpolationPoint', i, Path )
		{
			if ( i.Position == StartPoint )
			{
				TransPoint = i;
				fTransDistance = fDistance;
				iTransPoint = i.Position;
				break;
			}
		}
	}
	else
	{
		// Find second closest point on path (we use the second closest
		// point to build a return path to, because if we used the closest
		// point it could be so close that the return path would be too
		// abrupt and tight)
		ClosestPoint = None;
		fClosestDistance = 999999.0;
		iClosestPoint = 0;

		TransPoint = None;
		fTransDistance = 999999.0;
		foreach AllActors( class'InterpolationPoint', i, Path )
		{
			fDistance = VSize( Location - i.Location );
			if ( fDistance < fClosestDistance )
			{
				fTransDistance = fClosestDistance;
				TransPoint  = ClosestPoint;
				iTransPoint = iClosestPoint;

				ClosestPoint = i;
				fClosestDistance = fDistance;
				iClosestPoint = i.Position;
			}
			else if ( fDistance < fTransDistance )
			{
				TransPoint = i;
				fTransDistance = fDistance;
				iTransPoint = i.Position;
			}
		}

		if ( TransPoint == None )
		{
			fTransDistance = fClosestDistance;
			TransPoint  = ClosestPoint;
			iTransPoint = iClosestPoint;
		}
	}

	if ( TransPoint == None )
	{
		Log( "BroomHarry could not find an interpolation point on path to go to" );
		return false;
	}

	// Create a transition path to desired path...
	// Set-up interpolation point at end of return path
	if ( TransPath[1] == None )
	{
		TransPath[1] = Spawn( class'DynamicInterpolationPoint' );
		TransPath[1].Tag = TransPath[1].Name;
		TransPath[1].Position = 1;
		TransPath[1].bEndOfPath = true;
	}
	TransPath[1].SetLocation( TransPoint.Location );
	TransPath[1].SetRotation( TransPoint.Rotation );
//	TransPath[1].DesiredSpeed = TransPoint.DesiredSpeed;
	TransPath[1].DesiredSpeed = 900;
	TransPath[1].StartControlPoint = TransPoint.StartControlPoint;
	TransPath[1].EndControlPoint = TransPoint.EndControlPoint;

	// Set-up interpolation point at beginning of return path
	if ( TransPath[0] == None )
	{
		TransPath[0] = Spawn( class'DynamicInterpolationPoint', , TransPath[1].Tag );
		TransPath[0].Position = 0;
		TransPath[0].bEndOfPath = false;
		TransPath[0].Next = TransPath[1];
		TransPath[0].Prev = TransPath[1];
		TransPath[1].Next = TransPath[0];
		TransPath[1].Prev = TransPath[0];
	}

	TransPath[0].SetLocation( Location );
	TransPath[0].SetRotation( Rotation );
	TransPath[0].DesiredSpeed = VSize( Velocity );

	GetAxes( Rotation, X, Y, Z );
	TransPath[0].StartControlPoint =  1000.0 * X;
	TransPath[0].EndControlPoint   = -1000.0 * X;

	// Start flying on transition path;
	SetCollision( true, false, false );
	bCollideWorld = false;
	bInterpolating = true;
	SetPhysics( PHYS_None );

	IM = Spawn( class'InterpolationManager', self );
	IM.Init( TransPath[1], 1.0, false );

	return true;
}

function TakeDamage( int Damage, Pawn InstigatedBy, Vector HitLocation, 
					 Vector Momentum, name DamageType )
{
	// Harry got hit by something bad
	if ( IsInState( 'PlayerWalking' ) )
	{
		Super.TakeDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
	}
}

function KillHarry( bool bImmediateDeath )
{
	ClientMessage( "I can't go on!!!!" );
	GotoState( 'BroomDying' );
}

function PlayinAir()
{
	// Override to keep walking harry logic from playing fall animation
}

function PlayWaiting()
{
	// Override to keep walking harry logic from playing idle animations
}

function NoteAnotherReversal()
{
	// Updates stats on number of pitch and yaw reversals that have happened
	// recently.  Time of current reversal is noted and only the most recent
	// reversals are remembered.

	// Note current time for this reversal
	fTimesOfLastReversals[ iNextReversalStat ] = Level.TimeSeconds;

	// Move to next slot in stats array
	++iNextReversalStat;
	if ( iNextReversalStat >= MAX_REVERSAL_STATS )
		iNextReversalStat = 0;
}

function float GetReversalsPerSecond()
{
	// Computes and returns the current rate of control reversals (changes in
	// pitch or yaw directions) in number of reversals per second.  The rate is
	// the average over the period defined by the fReversalsStatPeriod constant.

	local int	iStat;
	local int	iReversals;
	local float	fReversalRate;

	// Count back a number of reversals until the delta time exceeds the stats
	// sample period
	iReversals = 0;
	iStat = iNextReversalStat;
	do
	{
		if ( iStat == 0 )
			iStat = MAX_REVERSAL_STATS;
		--iStat;

		if ( Level.TimeSeconds - fTimesOfLastReversals[ iStat ] > fReversalsStatPeriod )
			break;

		++iReversals;
	} until ( iReversals >= MAX_REVERSAL_STATS );

	// Compute average per second
	fReversalRate = iReversals / fReversalsStatPeriod;

	return fReversalRate;
}

//-------------------------------------------------------------------------------------------
// States
//
// PlayerWalking	- Main state of motion
// CutIdleing		- Captured by a cut-scene script
// FlyingOnPath		- Flying and following a interpolation path; non-interactive
// Pursue			- Chasing target while free-flying
// Hit				- Reacting to a damaging hit
// BroomDying		- Doing his death-spiral after falling off broom
// Catching			- Reaching out and catching an object
//-------------------------------------------------------------------------------------------

state PlayerWalking	// Well, flying actually; but as his normal mode of getting around
{
	ignores AltFire, Mount;

	function BeginState()
	{
		super.BeginState();
		SetPhysics(PHYS_Flying);
	}

	// Overrides regular Harry's tick behavior to focus on flying movement
	event PlayerTick( float DeltaTime )
	{
		PlayerMove(DeltaTime);
	}

	// Overrides regular Harry's movement behavior to remap controls for
	// flying (using forward controls to control pitch)
	function PlayerMove( float DeltaTime )
	{
		local vector	X,Y,Z, NewAccel;
		local float		DecelRate, HiDecelRate;

		HiDecelRate = 0.2;
		DecelRate = 2.5;

		// Figure out which inputs are controlling pitch
		if ( abs( bBroomPitchUp ) > 0.0005 || abs( bBroomPitchDown ) > 0.0005 )
		{
			if ( bPitchUnderMouse )
			{
				// Changing pitch control from mouse to keyboard
				fMousePitch = 0.0;
				bPitchUnderMouse = false;
			}
		}
		else if ( bAllowBroomMouse && abs( aBroomPitch ) > 0.0005 )
		{
			if ( !bPitchUnderMouse )
			{
				// Changing pitch control from keyboard to mouse
				bPitchUnderMouse = true;
			}
		}

		// Figure out which inputs are controlling yaw
		if ( abs( bBroomYawLeft ) > 0.0005 || abs( bBroomYawRight ) > 0.0005 )
		{
			if ( bYawUnderMouse )
			{
				// Changing yaw control from mouse to keyboard
				fMouseYaw = 0.0;
				bYawUnderMouse = false;
			}
		}
		else if ( bAllowBroomMouse && abs( aBroomYaw ) > 0.0005 )
		{
			if ( !bYawUnderMouse )
			{
				// Changing yaw control from keyboard to mouse
				bYawUnderMouse = true;
			}
		}

		// Interpret pitch controls for flying
		if ( bPitchUnderMouse )
		{
			if ( bInvertBroomPitch )
				fMousePitch += aBroomPitch * fBroomSensitivity;
			else
				fMousePitch -= aBroomPitch * fBroomSensitivity;

			// Limit to keep logical mouse center point from drifting to far
			// from pad physical center
			if ( fMousePitch > 1.5 )
				fMousePitch = 1.5;
			else if ( fMousePitch < -1.5 )
				fMousePitch = -1.5;
		}
		else
		{
			fPitchControl = 1.0*bBroomPitchUp - 1.0*bBroomPitchDown;
			if ( bInvertBroomPitch )
				fPitchControl = -fPitchControl;
		}

		// Interpret yaw controls for flying
		if ( bYawUnderMouse )
		{
			fMouseYaw += aBroomYaw * fBroomSensitivity;

			if ( abs( aBroomYaw ) > 0.0005 )
			{
//				ClientMessage( "Yaw "$aBroomYaw$" Sum "$fMouseYaw );
//				Log( "Yaw "$aBroomYaw$" Sum "$fMouseYaw );
			}


			// Limit to keep logical mouse center point from drifting to far
			// from pad physical center
			if ( fMouseYaw > 1.5 )
				fMouseYaw = 1.5;
			else if ( fMouseYaw < -1.5 )
				fMouseYaw = -1.5;

			// Adjust for deadband
			if ( fMouseYaw > 0.5 )
				fYawControl = fMouseYaw - 0.3;
			else if ( fMouseYaw < -0.5 )
				fYawControl = fMouseYaw + 0.3;
			else
				fYawControl = 0.0;
		}
		else
		{
			fYawControl = 1.0*bBroomYawRight - 1.0*bBroomYawLeft;
		}

		// Update rotation.
		UpdateRotation(DeltaTime, 1);
		GetAxes(Rotation,X,Y,Z);

		// Update acceleration.
		Acceleration = 200000.0 * X;

		// Determine airspeed according to brake setting
		if ( (bBroomBoost != 0 || bAuxBoost) && bBroomBrake == 0 )
		{
			AirSpeed = AirSpeedBoost;
		}
		else
		{
			if ( abs( fYawControl ) > 0.2 || bBroomBrake != 0 )
			{
				if (Deceleration < AirSpeedNormal / 2)
				{
					Deceleration += ((AirSpeedNormal / 2) / DecelRate) * deltatime;
				}
			}
			else
			{
				if (Deceleration > 0)
				{
					if ( Deceleration > (0.4 * AirSpeedNormal) )
						Deceleration -= ((AirSpeedNormal / 2) / HiDecelRate) * deltatime;
					else
						Deceleration -= ((AirSpeedNormal / 2) / DecelRate) * deltatime;

					if (Deceleration < 0)
					{
						Deceleration = 0;
					}
				}
			}
			AirSpeed = AirSpeedNormal - Deceleration;
		}

		// Compute a point passed where Harry will be if he doesn't get blocked
		// (used in HitWall event filter)
		Destination = (AirSpeed * DeltaTime + 0.1) * X + Location;

		// Determine which animation is appropriate for current motion
		DeterminePrimaryAnim();

		// Layer-on a Look animation if Harry should be looking for something
		// (and that something isn't currently visible)
		if ( LookForTarget != None && (LookForTarget.bHidden || !CanSee( LookForTarget )) )
		{
			if ( !bLookingForTarget )
			{
				bLookingForTarget = true;
				SetTimer( frand() * 3.0 + 1.0, false );
			}
		}
		else
		{
			// Target is in view; stop looking for it
			if ( bLookingForTarget )
			{
				bLookingForTarget = false;
				SetTimer( 0.0, false );
			}
		}

		// Update the broom sound effects
		UpdateBroomSound();
	}

	// Overrides regular Harry's rotation behavior to remap controls for
	// flying (using forward controls to control pitch)
	function UpdateRotation( float DeltaTime, float maxPitch )
	{
		local rotator	NewRotation;
		local float		YawVal;
		local float		DeltaYaw;
		local int		nDeltaYaw;
		local float		DeltaPitch;
		local float		fPitchLimitHi;
		local float		fPitchLimitLo;
		local float		fEffectiveMousePitch;

		NewRotation = Rotation;
		fPitchLimitHi = PitchLimitUp * (0x4000/90.0);
		fPitchLimitLo = 0x00010000 - (PitchLimitDown * (0x4000/90.0));

		// Modify pitch using current input source
		if ( bPitchUnderMouse )
		{
			// Adjust for deadband
			if ( fMousePitch > 0.15 )
			{
				fEffectiveMousePitch = fMousePitch - 0.15;
				if ( fEffectiveMousePitch > 1.0 )
					fEffectiveMousePitch = 1.0;
			}
			else if ( fMousePitch < -0.15 )
			{
				fEffectiveMousePitch = fMousePitch + 0.15;
				if ( fEffectiveMousePitch < -1.0 )
					fEffectiveMousePitch = -1.0;
			}
			else
				fEffectiveMousePitch = 0.0;

			// See if pitch has reversed
			if ( fEffectiveMousePitch < 0.0 && !bLastPitchNeg )
			{
				NoteAnotherReversal();
				bLastPitchNeg = true;
			}
			else if ( fEffectiveMousePitch > 0.0 && bLastPitchNeg )
			{
				NoteAnotherReversal();
				bLastPitchNeg = false;
			}

			// Update pitch
			NewRotation.Pitch = fEffectiveMousePitch * fPitchLimitHi;
			NewRotation.Pitch = NewRotation.Pitch & 0x0000ffff;
		}
		else
		{
			// See if pitch control has reversed
			if ( fPitchControl < 0.0 && !bLastPitchNeg )
			{
				NoteAnotherReversal();
				bLastPitchNeg = true;
			}
			else if ( fPitchControl > 0.0 && bLastPitchNeg )
			{
				NoteAnotherReversal();
				bLastPitchNeg = false;
			}

			// Make pitch self-centering when no pitch adjust is being commanded
			if ( abs( fPitchControl ) < 0.0005 )
			{
				if ( Rotation.Pitch >= 0x8000 )
					DeltaPitch = 0x00010000 - Rotation.Pitch;
				else
					DeltaPitch = Rotation.Pitch;

				fPitchControl = DeltaPitch / (RotationRate.Pitch * DeltaTime);

				if ( fPitchControl > 1.0 )	// Return to horz no faster than commanded rate
					fPitchControl = 1.0;
				if ( Rotation.Pitch < 0x8000 )
					fPitchControl = -fPitchControl;
			}

			// Apply pitch control
			NewRotation.Pitch += RotationRate.Pitch * DeltaTime * fPitchControl;
			NewRotation.Pitch = NewRotation.Pitch & 0x0000ffff;

			// Limit pitch
			If ( (NewRotation.Pitch > fPitchLimitHi) && (NewRotation.Pitch < fPitchLimitLo) )
			{
				If (fPitchControl > 0) 
					NewRotation.Pitch = fPitchLimitHi;
				else
					NewRotation.Pitch = fPitchLimitLo;
			}
		}

		// See if yaw control has reversed
		if ( fYawControl < 0.0 && !bLastYawNeg )
		{
			NoteAnotherReversal();
			bLastYawNeg = true;
		}
		else if ( fYawControl > 0.0 && bLastYawNeg )
		{
			NoteAnotherReversal();
			bLastYawNeg = false;
		}

		// If hitting wall and not commanding Harry's yaw, turn him out of wall automatically
		if ( abs( fYawControl ) < 0.0005 )
		{
			if ( bHittingWall )
			{
				fYawControl = WallAvoidanceYaw * fWallAvoidanceRate / ( fRotationRateYaw * DeltaTime );
				fLastTimeAvoidedWall = Level.TimeSeconds;
			}
		}
		else
			fLastTimeAvoidedWall = -1.0f;	// Forget Harry was ever trying to avoid wall; player overrode

		bHittingWall = false;

		// Apply yaw control
		if ( fYawControl > 1.0 )
			 fYawControl = 1.0;
		else if ( fYawControl < -1.0 )
			 fYawControl = -1.0;
		YawVal = fRotationRateYaw * DeltaTime * fYawControl;
		if(Acceleration == vect(0,0,0))
			YawVal = 4.0/3.0 * YawVal;

		ViewRotation.Yaw += yawVal;

//		Log( "YawControl, YawVal: "$fYawControl$", "$YawVal );

		ViewShake(deltaTime);
			
		NewRotation.Yaw = ViewRotation.Yaw;

		// Commit new rotation
		setRotation(NewRotation);
		DesiredRotation = Rotation; //Make physicsRotation leave rotation alone
//		ClientMessage("Rotation="$Rotation);
	}

	function HitWall( vector HitNormal, actor Wall )
	{
		local Vector	WallFaceDir;
		local Rotator	WallFaceRot;
		local Vector	Up;
		local Vector	FlightDir;
		local float		fSpeed;
		local int		EffectiveDamage;
		local float		fVolume;
		local bool		bTurnToRight;

		// Ignore hits with flat ceilings (usually an invisible BlockAll on a sky)
		if ( HitNormal.Z < -0.9999 )
			return;

		// If initial hit with wall...
		if ( !bHitWall )
		{
//			ClientMessage("Hit Wall "$Wall.Name$" "$HitNormal);
			bHitWall = true;

			// Play sound of collision, speed dependant
			fSpeed = VSize( Velocity );
			fVolume = fSpeed / AirSpeedNormal;
			PlaySound( HitSounds[ Rand( NUM_HIT_SOUNDS ) ], SLOT_Interact, fVolume );

			// Take damage, but don't let Harry go into Hit state (thus the skipping over parent class)
			if ( WallDamage > 0 )
			{
				EffectiveDamage = WallDamage * fSpeed / AirSpeedNormal;
				if ( EffectiveDamage > 0 )
					Super(BaseHarry).TakeDamage( EffectiveDamage, Self, Location, 100*Normal(Velocity), 'Collided' );
			}

			// Play bump animation
			PlayAnim( 'Bump' );

			// Tell the game referee when Harry hits things
			Referee.OnHitEvent( Self );
		}

		// Compute how fast Harry should try to turn out of wall
		// (but don't try to correct direction at all if surface
		// is more like a floor than a wall)
		if ( abs(HitNormal.Z) >= 0.985 )	// cos(+/- 10 degrees)
			return;
		else
			fWallAvoidanceRate = 1.0 - (abs(HitNormal.Z) / 0.985);	// Scaled by how plumb wall is

		// Compute vector and rotator for face of wall
		Up.x = 0.0f;
		Up.y = 0.0f;
		Up.z = 1.0f;
		WallFaceDir = HitNormal Cross Up;
		WallFaceRot = Rotator(WallFaceDir);

		// Compute change in rotation needed to travel along and away from wall
		FlightDir = Vector(Rotation);

		if (    fLastTimeAvoidedWall != -1.0f
			 && Level.TimeSeconds - fLastTimeAvoidedWall < fMaxTimeSameAvoidDir )
		{
			bTurnToRight = bLastAvoidanceRight;	// Keep turning same direction to avoid sticking in corners
		}
		else
		{
			bTurnToRight = (FlightDir Dot WallFaceDir) >= 0.0;
			bLastAvoidanceRight = bTurnToRight;
		}

		if ( bTurnToRight )
		{
			WallAvoidanceYaw = (WallFaceRot.Yaw + 1000 - Rotation.Yaw) & 0x0000ffff;	// Turn to right plus 10 degrees off wall
			if ( WallAvoidanceYaw > 0x00006000 )
				WallAvoidanceYaw = 0x00006000;		// Limit turn to less than 135 degrees (to avoid turning wrong way)
		}
		else
		{
			WallAvoidanceYaw = (WallFaceRot.Yaw + 0x00008000 - 1000 - Rotation.Yaw) & 0x0000ffff;	// Turn to left plus 10 degrees off wall
			if ( WallAvoidanceYaw < 0x0000A000 )
				WallAvoidanceYaw = 0x0000A000;		// Limit turn to less than 135 degrees (to avoid turning wrong way)
			WallAvoidanceYaw -= 0x00010000;			// Make negative; it'll be used as a delta
		}

//		Log( "-------------" );
//		Log( "Time, fLastTimeAvoidedWall: "$Level.TimeSeconds$", "$fLastTimeAvoidedWall );
//		Log( "Normal: "$HitNormal );
//		Log( "bTurnToRight: "$bTurnToRight );
//		Log( "FlightDir, Rotation, WallFaceRot: "$FlightDir$", "$Rotation.Yaw$", "$WallFaceRot );
//		Log( "DeltaYaw: "$WallAvoidanceYaw );

		bHittingWall = true;	// Note that Harry's still in contact with wall
	}

	event Timer()
	{
		// Time to do another look-around for target
		PlayAnim( 'Look', , 1.0 );
		SetTimer( frand() * 4.0 + 1.5, false );		// Play it again a little later
	}

	function AnimEnd()
	{
		// Restarts the layered primary and secondary animations in case any part
		// of them were overridden by the non-looping animation that just finished.

		if ( PrimaryAnim != '' )
			LoopAnim( PrimaryAnim, , 1.0 );
		if ( SecondaryAnim != '' )
			LoopAnim( SecondaryAnim, , 1.0 );

		bHitWall = false;	// Note that Harry is done reacting to wall hit
	}

	event Touch( Actor Other )
	{
		// Tell the game referee when Harry touches things
//		ClientMessage("Harry Touched "$Other.Name);
		Referee.OnTouchEvent( Self, Other );
	}
}

state CutIdleing
{
	ignores AltFire, Mount;

	// Overrides regular Harry's tick behavior to react to path movement
	event PlayerTick( float DeltaTime )
	{
		Super.PlayerTick( DeltaTime );
		DeterminePrimaryAnim();
		UpdateBroomSound();
	}

	function AnimEnd()
	{
		// Restarts the layered primary and secondary animations in case any part
		// of them were overridden by the non-looping animation that just finished.

		if ( PrimaryAnim != '' )
			LoopAnim( PrimaryAnim, , 1.0 );
		if ( SecondaryAnim != '' )
			LoopAnim( SecondaryAnim, , 1.0 );
	}
}

state FlyingOnPath
{
	ignores AltFire, Mount;

	// Overrides regular Harry's tick behavior to react to path movement
	event PlayerTick( float DeltaTime )
	{
		Super.PlayerTick( DeltaTime );
		ViewRotation = Rotation;
		DeterminePrimaryAnim();
		UpdateBroomSound();
	}

	function AnimEnd()
	{
		// Restarts the layered primary and secondary animations in case any part
		// of them were overridden by the non-looping animation that just finished.

		if ( PrimaryAnim != '' )
			LoopAnim( PrimaryAnim, , 1.0 );
		if ( SecondaryAnim != '' )
			LoopAnim( SecondaryAnim, , 1.0 );
	}
}

state Pursue
{
	ignores AltFire, Mount;

	function BeginState()
	{
		ClientMessage( "BroomHarry: Begin Pursue" );
		Log( "BroomHarry: Begin Pursue" );
	}

	event PlayerTick( float DeltaTime )
	{
		local vector	TargetDir;
		local vector	X,Y,Z;

		Super.PlayerTick( DeltaTime );

		if ( LookForTarget == None || LookForTarget.bHidden )
			GotoState( 'PlayerWalking' );

		// Update Rotation to point at target
		TargetDir = LookForTarget.Location - Location;
		DesiredRotation = Rotator( TargetDir );

		// Update acceleration and speed
		GetAxes( Rotation, X, Y, Z );
		Acceleration = 200000.0 * X;
		if ( VSize( TargetDir ) < 150.0 )
			AirSpeed = VSize( LookForTarget.Velocity ) * 1.0;
		else if ( VSize( TargetDir ) < 300.0 )
			AirSpeed = VSize( LookForTarget.Velocity ) * 1.25;
		else
			AirSpeed = VSize( LookForTarget.Velocity ) * 1.9;
		DesiredSpeed = AirSpeed;

		// Update animation and sound
		ViewRotation = Rotation;
		DeterminePrimaryAnim();
		UpdateBroomSound();
	}

	function EndState()
	{
		ClientMessage( "BroomHarry: End Pursue" );
		Log( "BroomHarry: End Pursue" );
	}
}

state Hit
{
	ignores AltFire, Mount;

	event PlayerTick( float DeltaTime )
	{
		Super.PlayerTick( DeltaTime );
		UpdateBroomSound();
	}

Begin:
	PlayAnim( 'Bump' );
	FinishAnim();
	bHitWall = false;	// Note that Harry is done reacting to wall hit, if that's what he hit
	GotoState( 'PlayerWalking' );
}

state BroomDying
{
	ignores AltFire, Mount;

	function BeginState()
	{
		ClientMessage( "BroomHarry: Begin BroomDying" );
		Log( "BroomHarry: Begin BroomDying" );
	}

	event PlayerTick( float DeltaTime )
	{
		Super.PlayerTick( DeltaTime );
		UpdateBroomSound();
	}

	function Landed( vector HitNormal )
	{
		// Fell to ground, now dead

		PlaySound( Sound'HPSounds.Quidditch_sfx.Q_Harry_Crash', SLOT_Interact );
		Referee.OnPlayersDeath();
		SetTimer( 0.0, false );
	}

	function Timer()
	{
		// Never reached ground, dead anyway

		Referee.OnPlayersDeath();
	}

	function AnimEnd()
	{
		// Ignore
	}

Begin:
	PlayAnim( 'Fall' );
	FinishAnim();
	Referee.OnPlayerDying();
	LoopAnim( 'Hang' );
	Cam.GotoState( 'TopDownState' );
	SetPhysics( PHYS_Falling );
	SetTimer( 10.0, false );		// Watchdog timer in case Harry never reaches ground

Loop:
	Sleep( 0.1 );

	goto 'Loop';
}

state Catching
{
	ignores AltFire, Mount;

	event PlayerTick( float DeltaTime )
	{
		Super.PlayerTick( DeltaTime );
		ViewRotation = Rotation;
		UpdateBroomSound();

//		Log( "Location Z: "$Location.z );
	}

	function EndState()
	{
		ClientMessage( "BroomHarry: End GetOnPath" );
		Log( "BroomHarry: End GetOnPath" );
//		StopFlyingOnPath();
	}

	event FinishedInterpolation( InterpolationPoint Other )
	{
		// This event happens when Harry reaches the end-point on
		// the transition path.  Start flying on intended path.
		if ( IM != None )
		{
			IM = None;
			IPSpeed = 900;
			FlyOnPath( PathAfterCatch, iTransPoint );
		}
	}

Begin:
	// Start catch animation
	if ( TargetToCatch == LookForTarget )
		SetLookForTarget( None );
	PlayAnim( 'Catch', , 0.1 );

	Sleep( 0.4 );			// Dead reckon when Catch animation has Harry's hand closing in around target

	// Attach target to Harry's hand
	TargetToCatch.SetPhysics( PHYS_Trailer );
	TargetToCatch.SetOwner( Self );
	TargetToCatch.AttachToOwner( 'RightHand' );
	TargetToCatch.bTrailerPrePivot = true;
	TargetToCatch.PrePivot = vect( 0, 0, 11 );	// Offset trailer to correct for lag

	// Wait for catch animation to end, then hold with target in hand
	FinishAnim();
	SetSecondaryAnimation( 'Hold', , 0.1 );

	// Reverse camera
	Cam.GotoState( 'ReverseState' );
	StandardTarget.TargetOffset = vect(-100, 10 ,50);

	// WIll still be in lockaroundharrymode
//		Cam.TargetRot = rot(5000, 0, 0);

	// Transition Harry to desired path now
	if ( PathAfterCatch != '' )
	{
		if ( !GetOnPath( PathAfterCatch ) )
			Log( "BroomHarry failed to get on path "$PathAfterCatch$" after catch" );
	}

Loop:
	Sleep( 0.1 );

	goto 'Loop';
}

defaultproperties
{
     AirSpeedNormal=400
     AirSpeedBoost=800
     PitchLimitUp=60
     PitchLimitDown=60
     WallDamage=1
     ShadowClass=Class'HarryPotter.BroomShadow'
     MaxMountHeight=0
     Mesh=SkeletalMesh'HarryPotter.skremharryMesh'
     bAlignBottom=False
     RotationRate=(Pitch=24000,Roll=6000)
}
