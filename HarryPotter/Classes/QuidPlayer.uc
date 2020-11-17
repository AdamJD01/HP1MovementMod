//=============================================================================
// QuidPlayer  -- Another player in Quidditch
//=============================================================================
class QuidPlayer extends baseChar;

var InterpolationManager		IM;
var(Quidditch) name				Path;			// Interpolation path to follow
var(Quidditch) name				Path_Intro;		// Interpolation path to follow during game intro
var name						PathToFly;		// Which interpolation path to follow right now

var DynamicInterpolationPoint	ReturnPath[2];	// Path to follow to get back on main path
var int							iReturnPoint;	// Position Id of point on main path that player is returning to

var Actor			LookForTarget;	// Thing player should appear to look for when that thing isn't visible

var(Quidditch) int	Damage;			// How much damage player imparts on impact

const				NUM_HIT_SOUNDS = 3;
var Sound			HitSounds[3];	// All the different sounds of player hitting something
var bool			bHit;			// Player is currently reacting to a hit


//-------------------------------------------------------------------------------------------
// PreBeginPlay(), PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PreBeginPlay()
{
	Super.PreBeginPlay();

	LookForTarget = None;
	iReturnPoint = 0;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( Path_Intro != '' )
	{
		SplicePaths( Path_Intro, Path );
		PathToFly = Path_Intro;
	}
	else
		PathToFly = Path;

	SetPhysics(PHYS_Flying);

	// Load the player hit sounds
	HitSounds[0] = Sound'HPSounds.Quidditch_sfx.Q_Collision1';
	HitSounds[1] = Sound'HPSounds.Quidditch_sfx.Q_Collision2';
	HitSounds[2] = Sound'HPSounds.Quidditch_sfx.Q_Collision3';

	bHit = false;
}


//-------------------------------------------------------------------------------------------
// Operational methods
//-------------------------------------------------------------------------------------------

function FlyOnPath( name Path, optional int StartPoint )
{
	local InterpolationPoint	i;

	if ( Path != '' )
	{
		// Put character at selected point on its path
		foreach AllActors( class'InterpolationPoint', i, Path )
		{
			if ( i.Position == StartPoint )
			{
				SetLocation( i.Location );
//				SetRotation( i.Rotation );
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
			Log( Name$" couldn't find path "$Path );
		}
	}
}

function StopFlyingOnPath()
{
	local InterpolationManager	IM_ToStop;

	if ( IM != None )
	{
		IM_ToStop = IM;
		IM = None;		// Tells QuidditchPlayer.FinishInterpolation event that path ended early
		IM_ToStop.FinishedInterpolation( None );
	}
	bCollideWorld = true;
}


function SplicePaths( name Path1, name Path2, optional int iPath2SplicePointPos )
{
	// Moves the end point of path1 so that it matches up seamlessly with the
	// indicated point of path 2 (or point 0, if not specifed)
	local InterpolationPoint	IP;
	local InterpolationPoint	EndPoint;
	local InterpolationPoint	SplicePoint;

	// Find end point of path1
	foreach AllActors( class'InterpolationPoint', IP, Path1 )
	{
		if ( IP.bEndOfPath )
		{
			EndPoint = IP;
			break;
		}
	}

	if ( EndPoint == None )
		Log( "Could't find end point of path "$Path1 );

	// Find splice point of path2
	foreach AllActors( class'InterpolationPoint', IP, Path2 )
	{
		if ( IP.Position == iPath2SplicePointPos )
		{
			SplicePoint = IP;
			break;
		}
	}

	if ( SplicePoint == None )
		Log( "Could't find splice point of path "$Path2 );

	// Make end point match up with splice point
	EndPoint.SetLocation( SplicePoint.Location );
	EndPoint.SetRotation( SplicePoint.Rotation );
	EndPoint.DesiredSpeed = SplicePoint.DesiredSpeed;
	EndPoint.StartControlPoint = SplicePoint.StartControlPoint;
	EndPoint.EndControlPoint = SplicePoint.EndControlPoint;
}

function SetLookForTarget( Actor NewLookForTarget )
{
	// Notes what actor player should appear to "look for" when that actor isn't
	// visible.  If None, player will appear to look for something periodically.

	LookForTarget = NewLookForTarget;
}

function Touch( Actor Other )
{
	// Quid player hit something, it stumbles, and imparts damage to other
	// actor, but only if it's a pawn.
	local Pawn	Target;

	Target = Pawn( Other );
	if ( !bHit && Other != LookForTarget && Target != None && !Target.bHidden )
	{
		if ( frand() < 0.8 )
			PlayAnim( 'Hit_Small' );
		else
			PlayAnim( 'Hit_Big' );

		PlaySound( HitSounds[ Rand( NUM_HIT_SOUNDS ) ], SLOT_Interact, 0.7, , 1000.0 );	// Radius makes sure player can be heard near by

		Target.TakeDamage( Damage, Self, Location, 100*Normal(Velocity), 'Collided' );

		Velocity = vect(0,0,1);
		bHit = true;
	}
}

function HitWall( vector HitNormal, Actor Wall )
{
	// Quid player hit wall; stumble.
	if ( !bHit )
	{
		if ( frand() < 0.8 )
			PlayAnim( 'Hit_Small' );
		else
			PlayAnim( 'Hit_Big' );
		bHit = true;
	}
}

function Trigger( Actor Other, Pawn EventInstigator )
{
	// When triggered, this object's reaction is to stop the current path, and start flying on it's intro path

	StopFlyingOnPath();
	if ( Path_Intro != '' )
		PathToFly = Path_Intro;
	else
		PathToFly = Path;
	FlyOnPath( PathToFly );
}

event FinishedInterpolation( InterpolationPoint Other )
{
	// This event happens when the quid player reaches the end-point on
	// its intro path.  Start regular path.
	PathToFly = Path;
	if ( IM != None )
	{
		IM = None;
		FlyOnPath( PathToFly );
	}
}

event AnimEnd()
{
	bHit = false;
}


//-------------------------------------------------------------------------------------------
// States
//
// Fly					- No particular role; just flying on a path
// Goalie				- Flying on path while performing Goalie-like animations
// Beater				- Flying on path while performing Beater-like animations
// Chaser				- Flying on path while performing Chaser-like animations
// Seeker				- Flying on path, waiting for target to show up
// Seeker_Pursue		- Chasing target while free-flying
// Seeker_GetBackOnPath	- Flying on transitional path to get make on main path
//-------------------------------------------------------------------------------------------

state() Fly
{
	function BeginState()
	{
		LoopAnim( 'Fly' );
		FlyOnPath( PathToFly );
		PlayerHarry.ClientMessage( Name$' Begin Flying' );
		Log( Name$' Begin Flying' );
	}

	function EndState()
	{
		StopFlyingOnPath();
		LoopAnim( 'Hover', , 0.5 );
		PlayerHarry.ClientMessage( Name$' End Flying' );
		Log( Name$' End Flying' );
	}

begin:
loop:
	FinishAnim();
	if ( frand() < 0.4 )
		LoopAnim( 'Fly', , 0.5 );
	else if ( frand() < 0.8 )
		LoopAnim( 'Look', , 0.5 );
	else
		LoopAnim( 'Hover', , 0.5 );

	goto 'loop';
}


state() Goalie extends Fly
{
begin:
loop:
	FinishAnim();
	if ( frand() < 0.3 )
		LoopAnim( 'Fly', , 0.5 );
	else if ( frand() < 0.6 )
		LoopAnim( 'Look', , 0.5 );
	else
		LoopAnim( 'Starfish', , 0.5 );

	goto 'loop';
}


state() Beater extends Fly
{
begin:
loop:
	sleep(5.0);
	goto 'loop';
}


state() Chaser extends Fly
{
begin:
loop:
	FinishAnim();
	if ( frand() < 0.9 )
		LoopAnim( 'Fly', , 0.5 );
	else if ( frand() < 0.92 )
	{
		LoopAnim( 'Catch_right', , 0.5 );
		goto 'catch';
	}
	else
		LoopAnim( 'Look', , 0.5 );

	goto 'loop';

catch:
	FinishAnim();
	LoopAnim( 'Hold_right', , 0.5 );
	FinishAnim();
	Sleep( 3.0 );
	LoopAnim( 'throw_right', , 0.5 );
	goto 'loop';
}


state() Seeker
{
	function BeginState()
	{
		PlayerHarry.ClientMessage( Name$' Begin Seeking' );
		Log( Name$' Begin Seeking' );

		LoopAnim( 'Fly' );
		FlyOnPath( PathToFly, iReturnPoint );
	}

	function EndState()
	{
		PlayerHarry.ClientMessage( Name$' End Seeking' );
		Log( Name$' End Seeking' );

		StopFlyingOnPath();
	}

begin:
loop:
	FinishAnim();
	if ( LookForTarget != None && !LookForTarget.bHidden && PathToFly != Path_Intro )
	{
		Log( Name$" Sees Target, will pursue" );
		GotoState( 'Seeker_Pursue' );
	}

	if ( frand() < 0.3 )
		LoopAnim( 'Fly', , 0.5 );
	else if ( frand() < 0.6 )
		LoopAnim( 'Look', , 0.5 );

	goto 'loop';
}


state Seeker_Pursue
{
	function BeginState()
	{
		PlayerHarry.ClientMessage( Name$' Begin Pursue' );
		Log( Name$' Begin Pursue' );
		LoopAnim( 'Fly', , 0.5 );
		SetPhysics( PHYS_Flying );
	}

	event Tick( float DeltaTime )
	{
		local vector	TargetDir;
		local vector	X,Y,Z;

		Super.Tick( DeltaTime );

		if ( LookForTarget == None || LookForTarget.bHidden )
			GotoState( 'Seeker_GetBackOnPath' );

		// Update Rotation to point at target
		TargetDir = LookForTarget.Location - Location;
		DesiredRotation = Rotator( TargetDir );

		// Update acceleration and speed
		GetAxes( Rotation, X, Y, Z );
		Acceleration = 200000.0 * X;
		if ( VSize( TargetDir ) < 200.0 )
			AirSpeed = 250.0;
		else if ( VSize( TargetDir ) < 300.0 )
			AirSpeed = 350.0;
		else
			AirSpeed = 700.0;
		DesiredSpeed = AirSpeed;
	}

begin:
loop:
	Sleep( 0.5 );
	goto 'loop';
}


state Seeker_GetBackOnPath extends Seeker
{
	function BeginState()
	{
		local float					fDistance;
		local InterpolationPoint	i;
		local vector				X,Y,Z;

		local float					fClosestDistance;
		local InterpolationPoint	ClosestPoint;
		local int					iClosestPoint;

		local float					fSecondClosestDistance;
		local InterpolationPoint	SecondClosestPoint;
		local int					iSecondClosestPoint;


		PlayerHarry.ClientMessage( Name$' Begin GetBackOnPath' );
		Log( Name$' Begin GetBackOnPath' );

		if ( PathToFly == '' )
			GotoState( 'Seeker' );
		else
		{
			// Find second closest point on path (we use the second closest
			// point to build a return path to, because if we used the closest
			// point it could be so close that the return path would be too
			// abrupt and tight)
			ClosestPoint = None;
			fClosestDistance = 999999.0;
			iClosestPoint = 0;

			SecondClosestPoint = None;
			fSecondClosestDistance = 999999.0;
			foreach AllActors( class'InterpolationPoint', i, PathToFly )
			{
				fDistance = VSize( Location - i.Location );
				if ( fDistance < fClosestDistance )
				{
					fSecondClosestDistance = fClosestDistance;
					SecondClosestPoint  = ClosestPoint;
					iSecondClosestPoint = iClosestPoint;

					ClosestPoint = i;
					fClosestDistance = fDistance;
					iClosestPoint = i.Position;
				}
				else if ( fDistance < fSecondClosestDistance )
				{
					SecondClosestPoint = i;
					fSecondClosestDistance = fDistance;
					iSecondClosestPoint = i.Position;
				}
			}

			if ( SecondClosestPoint == None )
			{
				fSecondClosestDistance = fClosestDistance;
				SecondClosestPoint  = ClosestPoint;
				iSecondClosestPoint = iClosestPoint;
			}
			iReturnPoint = iSecondClosestPoint;

			if ( SecondClosestPoint == None )
			{
				Log( Name$' Could not find an interpolation point to get back to' );
				GotoState( 'Seeker' );
			}
			else
			{
				// Create a path back to main path...
				// Set-up interpolation point at end of return path
				if ( ReturnPath[1] == None )
				{
					ReturnPath[1] = Spawn( class'DynamicInterpolationPoint' );
					ReturnPath[1].Tag = ReturnPath[1].Name;
					ReturnPath[1].Position = 1;
					ReturnPath[1].bEndOfPath = true;
				}
				ReturnPath[1].SetLocation( SecondClosestPoint.Location );
				ReturnPath[1].SetRotation( SecondClosestPoint.Rotation );
				ReturnPath[1].DesiredSpeed = SecondClosestPoint.DesiredSpeed;
				ReturnPath[1].StartControlPoint = SecondClosestPoint.StartControlPoint;
				ReturnPath[1].EndControlPoint = SecondClosestPoint.EndControlPoint;

				// Set-up interpolation point at beginning of return path
				if ( ReturnPath[0] == None )
				{
					ReturnPath[0] = Spawn( class'DynamicInterpolationPoint', , ReturnPath[1].Tag );
					ReturnPath[0].Position = 0;
					ReturnPath[0].bEndOfPath = false;
					ReturnPath[0].Next = ReturnPath[1];
					ReturnPath[0].Prev = ReturnPath[1];
					ReturnPath[1].Next = ReturnPath[0];
					ReturnPath[1].Prev = ReturnPath[0];
				}

				ReturnPath[0].SetLocation( Location );
				ReturnPath[0].SetRotation( Rotation );
				ReturnPath[0].DesiredSpeed = VSize( Velocity );

				GetAxes( Rotation, X, Y, Z );
				ReturnPath[0].StartControlPoint =  1000.0 * X;
				ReturnPath[0].EndControlPoint   = -1000.0 * X;

				// Start flying on return path;
				SetCollision( true, false, false );
				bCollideWorld = false;
				bInterpolating = true;
				SetPhysics( PHYS_None );

				IM = Spawn( class'InterpolationManager', self );
				IM.Init( ReturnPath[1], 1.0, false );
			}
		}
	}

	function EndState()
	{
		PlayerHarry.ClientMessage( Name$' End GetBackOnPath' );
		Log( Name$' End GetBackOnPath' );
		StopFlyingOnPath();
	}

	event FinishedInterpolation( InterpolationPoint Other )
	{
		// This event happens when the quid player reaches the end-point on
		// the return path.  Start regular seeking again.
		if ( IM != None )
		{
			IM = None;
			GotoState( 'Seeker' );
		}
	}
}

defaultproperties
{
     Damage=2
     ShadowClass=Class'HarryPotter.BroomShadow'
     InitialState=Fly
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skquidplayerf1Mesh'
     bAlignBottom=False
     RotationRate=(Pitch=18000,Yaw=25000,Roll=5000)
}
