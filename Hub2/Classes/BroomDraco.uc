//=============================================================================
// BroomDraco  -- Guy who Harry chases to get Rememberall back
//=============================================================================
class BroomDraco extends QuidPlayer;

//Edited by- AdamJD (edited code will have AdamJD by it)

var GameReferee		Referee;				// Object in charge of the rules of the current mini-game
var BroomHarry		Harry;

var(Draco) float	fBumpProximity;			// How close does Harry need to be to bump draco
var(Draco)	int		BumpsToWin;				// How many times must Harry bump Draco to get Remembrall back
var int				Bumps;					// How many times has Harry bumped Draco so far

var bool			bHarryAhead;			// Whether or not Harry is farther ahead than Draco
var float			Dist;					// How far away is Harry

var bool			bTimeToLaunchABludger;	// It is time from Draco to launch another bludger
var Bludger			LaunchedBludger;		// Current bludger just throwned by draco
var Vector			BludgerVel;				// Direction and speed of bludger

var(Draco) float	fNearSpeed;				// Speed Draco flys when Harry is close to him
var(Draco) float	fFarSpeed;				// Speed Draco flys when Harry is trailing but not close

enum DracoOffenseType
{
	OT_BludgerProjectile,	// Throw bludgers at Harry
	OT_BludgerMine,			// Lay bludgers on path where Harry can hit them
};

var(Draco) DracoOffenseType	OffenseType;			// What method Draco uses to attack Harry

var(Draco) float	fBludgerLaunchOuterProximity;	// How close does Harry need to be before draco will consider launching a bludger
var(Draco) float	fBludgerLaunchInnerProximity;	// How much closer does Harry need to be before draco will stop launching bludgers
var(Draco) float	fBludgerLaunchTimeMin;			// Minumum seconds until next bludger launch
var(Draco) float	fBludgerLaunchTimeMax;			// Maximum seconds until next bludger launch
var(Draco) float	fBludgerLaunchSpeed;			// How fast should bludger launch at Harry
var(Draco) float	fBludgerVelocityCompensation;	// What percent of Harry's velocity should bludger match?

var Sound			OffenseDlgSound;				// What Draco says when he launches an offensive

const				NUM_BUMP_EMOTES = 3;
var Sound			BumpEmoteSounds[3];				// All the different things Draco says when bumped
var Sound			FinalBumpEmoteSound;			// The thing Draco says on final bump

//-------------------------------------------------------------------------------------------
// PreBeginPlay(), PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PreBeginPlay()
{
	// Initialize
	Super.PreBeginPlay();

	// Find mini-game referee and Harry
	foreach AllActors( class'GameReferee', Referee )
		break;
	foreach AllActors( class'BroomHarry', Harry )
		break;

	Bumps = 0;
}

function PostBeginPlay()
{
	// More initialization
	local String	DlgText;

	Super.PostBeginPlay();

	// Collect dialog and emote sounds
	Harry.TheNarrator.FindDialog( "125DracoMalfoy_Intro7", OffenseDlgSound, DlgText );
	Harry.TheNarrator.FindDialog( "EmotiveDracoMalfoy12", BumpEmoteSounds[0], DlgText );
	Harry.TheNarrator.FindDialog( "EmotiveDracoMalfoy13", BumpEmoteSounds[1], DlgText );
	Harry.TheNarrator.FindDialog( "EmotiveDracoMalfoy14", BumpEmoteSounds[2], DlgText );
	Harry.TheNarrator.FindDialog( "EmotiveDracoMalfoy11", FinalBumpEmoteSound, DlgText );
}

function Touch( Actor Other)
{
	// Just stumble (don't damage, like what a QuidPlayer would do) and count bumps

	if ( !bHit && Other == Harry && Bumps < BumpsToWin/*-1*/ ) //makes sure Dracos health goes to 0 -AdamJD
	{
		bHit = true;
		PlayAnim( 'Bumped' );
		PlaySound( HitSounds[ Rand( NUM_HIT_SOUNDS ) ], SLOT_Interact, 0.7 );
		PlaySound( BumpEmoteSounds[ Rand( NUM_BUMP_EMOTES ) ], SLOT_Talk, , , 2000.0 );	// Radius makes sure he can be heard

		++Bumps;
		if ( Bumps >= BumpsToWin/*-1*/ ) //makes sure Dracos health goes to 0 -AdamJD
			Referee.Trigger( Self, None );	// Tell referee that Draco almost gives up

		Velocity = vect(0,0,1);
	}
}

function OnBroomBump( Actor Other )
{
	// React to an intentional bump from Harry: spin out

	if ( !bHit && Other == Harry )
	{
		bHit = true;
		PlayAnim( 'Bumped' );
		PlaySound( HitSounds[ Rand( NUM_HIT_SOUNDS ) ], SLOT_Interact, 1.0 );
		PlaySound( FinalBumpEmoteSound, SLOT_Talk, , , 2000.0 );	// Radius makes sure he can be heard

		GotoState( 'SpinOut' );

		Velocity = vect(0,0,1);
	}
}

function float GetHealth()
{
	// Returns the health of draco in range 0.0 to 1.0, which is an
	// indication of how many more bumps he can stand before he gives up.

	return 1.0 - float(Bumps)/BumpsToWin;
}

function SetTimeForNextBludger()
{
	// Picks a time for when to launch next bludger, and set a timer for it

	local float	fTimeForNextBludger;

	fTimeForNextBludger = frand() * (fBludgerLaunchTimeMax - fBludgerLaunchTimeMin) + fBludgerLaunchTimeMin;
	SetTimer( fTimeForNextBludger, false );
}

function DetermineWhereHarryIs()
{
	// Figure out if Harry is ahead or behind
	local Vector	DracoHeading;
	local Vector	HarryFromDraco;

	DracoHeading = Vector( Rotation );
	HarryFromDraco = Harry.Location - Self.Location;
	Dist = VSize( HarryFromDraco );
	bHarryAhead = (Dist > 50.0) && ((HarryFromDraco dot DracoHeading) > 0.0);
}


//-------------------------------------------------------------------------------------------
// States
//
// Idle		- Do nothing but play idle animation
// Fly		- Fly on path, occasionally throwing bludgers
// Taunt	- Hover and gesture at Harry
// SpinOut	- Loose control of broom after being bumped enough
// Cruise	- Do nothing but current animation and physics
//-------------------------------------------------------------------------------------------

state() Idle
{
	function BeginState()
	{
		LoopAnim( 'Hover_Idle' );
	}
}

state() Fly
{
	function BeginState()
	{
		LoopAnim( 'Fly_Forward' );
		PlayerHarry.ClientMessage( Name$' Begin Draco Fly' );
		Log( Name$' Begin Draco Fly' );

		bTimeToLaunchABludger = false;
		SetTimeForNextBludger();
	}

	function EndState()
	{
		PlayerHarry.ClientMessage( Name$' End Draco Fly' );
		Log( Name$' End Draco Fly' );

		SetTimer( 0.0f, false );	// Cancel next bludger
		bTimeToLaunchABludger = false;
	}

	function Timer()
	{
		bTimeToLaunchABludger = true;
		SetTimeForNextBludger();
	}

begin:
loop:
	FinishAnim();

	DetermineWhereHarryIs();

	if ( bHarryAhead )
	{
		LoopAnim( 'Fly_Forward', , 0.5 );
		IPSpeed = max( fNearSpeed, (VSize( Harry.Velocity ) + 50) );
	}
	else
	{
		if ( frand() < 0.7 )
			LoopAnim( 'Fly_Forward', , 0.5 );
		else
			LoopAnim( 'Look_Back', , 0.5 );

		if ( Dist > 2000 )
			GotoState( 'Taunt' );
		else if ( bTimeToLaunchABludger )
		{
			// Launch a bludger if Harry is within the right range
			if (     Dist <= fBludgerLaunchOuterProximity
				  && Dist >  fBludgerLaunchInnerProximity
				  && Bumps < BumpsToWin-1 )
			{
				// Do Throw animation, say dialog, and launch or deploy a bludger
				LoopAnim( 'Throw_Back', , 0.1 );
				FinishAnim();

				if ( OffenseDlgSound != None )
					PlaySound( OffenseDlgSound, SLOT_Talk, , , 2000.0 );	// Radius makes sure he can be heard

				LaunchedBludger = Spawn( class'Bludger', , , Location, rot( 0, 0, 0 ) );
				LaunchedBludger.bRecycle = false;
				switch ( OffenseType )
				{
					case OT_BludgerProjectile:
						Log( "Draco: Launching Bludger as a Projectile" );
						LaunchedBludger.SetLaunchParameters( fBludgerLaunchSpeed, fBludgerVelocityCompensation );
						LaunchedBludger.LaunchAtTarget( Harry, Self );
						break;

					case OT_BludgerMine:
						Log( "Draco: Deploying Bludger as a Mine" );
						LaunchedBludger.DeployAsMine( Harry, Self, 20.0 );
						break;
				}
			}

			bTimeToLaunchABludger = false;
		}

		if ( Dist > 500 )
			IPSpeed = fFarSpeed;
		else
			IPSpeed = fNearSpeed;
	}

	goto 'loop';
}


state() Taunt
{
begin:
	// Play teasing animation here
	LoopAnim( 'Taunt' );
	IPSpeed = 10;

loop:
	Dist = vsize( Location - Harry.Location );
	if ( dist < 675 )
	{
		IPSpeed = 400;
		GotoState( 'Fly' );
	}
	Sleep( 0.01 );

	goto 'loop';
}


state() SpinOut
{
begin:
	// Make Draco spin out
	Harry.Cam.GotoState( 'BossState' );
	LoopAnim( 'Spin_Out' );
	Sleep( 1.8 );
	StopFlyingOnPath();
	Referee.Trigger( Self, None );	// Tell referee that Draco gives up now
	GotoState( 'Idle' );
}


state() Cruise
{
begin:
loop:
	Sleep( 0.01 );

	goto 'loop';
}

defaultproperties
{
     fBumpProximity=150
     BumpsToWin=5
     fNearSpeed=730
     fFarSpeed=600
     OffenseType=OT_BludgerMine
     fBludgerLaunchOuterProximity=1000
     fBludgerLaunchInnerProximity=200
     fBludgerLaunchTimeMin=5
     fBludgerLaunchTimeMax=9
     fBludgerLaunchSpeed=400
     fBludgerVelocityCompensation=0.3
     InitialState=Idle
     Mesh=SkeletalMesh'HarryPotter.skremdracoMesh'
     CollisionHeight=40
     RotationRate=(Pitch=60000,Yaw=5000)
}
