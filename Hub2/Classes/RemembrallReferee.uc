//=============================================================================
// RemembrallReferee -- Keeper of the rules of the mini-game; main game logic
//=============================================================================
class RemembrallReferee extends GameReferee;

var BroomHarry		Harry;
var BroomDraco		Draco;

var bool			bWrongWay;			// Whether Harry is heading wrong way on path
var bool			bWasWrongWay;		// Whether Harry was heading wrong way on path last tick

var float			fTimeToCheckHarry;	// When next to check harry's proximity and direction

struct RandomSeed
{
	var float SeedA;
	var float SeedB;
	var float SeedC;
	var float SeedD;
};

var RandomSeed		RandSeed;			// Keep game from playing the same way twice

//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	// Initialize
	Super.PostBeginPlay();

	// Find actors that are subjects to this game
	foreach AllActors( class'BroomHarry', Harry )
		break;
	foreach AllActors( class'BroomDraco', Draco )
		break;

	bWrongWay = false;
	bWasWrongWay = false;

	// Setup HUD
	Harry.HUDType = class'HPMenu.QuidHud';

	// Start the mini-game with intro CutScene
	InitialState = 'GameIntro';
}

//-------------------------------------------------------------------------------------------
// Operational methods
//-------------------------------------------------------------------------------------------

function InterpolationPoint NearestPathPoint( Vector Location )
{
	// Finds the interpolation point on Draco's path that is nearest to the
	// given location.

	local InterpolationPoint	FirstIP;
	local InterpolationPoint	IP;
	local InterpolationPoint	ClosestIP;

	local float					fDist;
	local float					fClosestDist;

	ClosestIP = None;
	fClosestDist = 999999.0;

	FirstIP = Draco.IM.Dest;
	IP = FirstIP;
	do
	{
		fDist = VSize( Location - IP.Location );
		if ( fDist < fClosestDist )
		{
			ClosestIP = IP;
			fClosestDist = fDist;
		}

		IP = IP.Next;
	} 
	until ( IP == FirstIP );

	return ClosestIP;
}

function bool IsHarryGoingWrongWay()
{
	// Determines whether Harry is going wrong way on path.  Finds where
	// Harry is with respect to Draco's path, and compares direction of travel.
	local InterpolationPoint	IP;
	local Vector				S1Dir, S2Dir;
	local Vector				HarryHeading;
	local bool					bWrongWay;

	// Find point on path nearest to Harry
	IP = NearestPathPoint( Harry.Location );

	// Compute adjacent path segment vectors
	S1Dir = Normal( IP.Location - IP.Prev.Location );
	S2Dir = Normal( IP.Next.Location - IP.Location );

	// Determine if Harry is generally facing backwards with respect to both
	// segments
	HarryHeading = Vector( Harry.Rotation );
	bWrongWay = ( (( HarryHeading dot S1Dir ) + ( HarryHeading dot S2Dir ))/2.0 < -0.2 );

/*
	Log( "----------------" );
	Log( "IP.Pos = "$IP.Position$", IP.Loc = "$IP.Location$"," );
	Log( "S1Dir = "$S1Dir$", S2Dir = "$S2Dir$"," );
	Log( "S1Dot = "$( HarryHeading dot S1Dir )$", S2Dot = "$( HarryHeading dot S1Dir )$"," );
	Log( "WrongWay = "$bWrongWay$"." );
	Log( "----------------" );
*/

	return bWrongWay;
}


//-------------------------------------------------------------------------------------------
// States
//
// GameIntro	- Playing intro cut-scene
// GameIntro2	- Playing part 2 of intro cut-scene (Draco flying)
// GamePlay		- Interactive; flying Harry to bump Draco and get Remembrall back
// GameBump		- Interactive; press action button for final bump on Draco
// GameWon		- Harry got Remembrall back
// GameLost		- Harry lost all stamina
//-------------------------------------------------------------------------------------------

state GameIntro
{
	function BeginState()
	{
		PlayerHarry.ClientMessage( "Entered GameIntro State" );
		Log( "Entered GameIntro State" );
		TriggerEvent( 'Intro', self, None );	// Triggered as soon as possible
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// Intro CutScene wants Draco to start flying
		Draco.FlyOnPath( Draco.PathToFly );
		Draco.GotoState( 'Fly' );
		GotoState( 'GameIntro2' );
	}
}

state GameIntro2
{
	function OnCutSceneEvent( Name CutSceneTag )
	{
		// Intro CutScene ended; start chasing Draco
		Harry.AirSpeed = 10;
		Harry.Deceleration = Harry.AirSpeedNormal - Harry.AirSpeed;
		Harry.SetLookForTarget( Draco );

		GotoState( 'GamePlay' );
	}

	function EndState()
	{
		PlayerHarry.ClientMessage( "Exited GameIntro2 State" );
		Log( "Exited GameIntro2 State" );
	}
}

state GamePlay
{
	function BeginState()
	{
		// Start chasing Draco
		PlayerHarry.ClientMessage( "Entered GamePlay State" );
		Log( "Entered GamePlay State" );

		fTimeToCheckHarry = Level.TimeSeconds + 1.0;
	}

	event Tick( float DeltaTime )
	{
		Super.Tick( DeltaTime );

		// Check on harry if its time to do so
		if ( Level.TimeSeconds >= fTimeToCheckHarry )
		{
			// Detect if Harry is going wrong way
			bWrongWay = IsHarryGoingWrongWay();
			if ( bWrongWay && !bWasWrongWay )
			{
				// Just started to go wrong way; turn on Wrong Way prompt

				QuidHUD(playerHarry.myHUD).ShowPopup(class'basewarning');
				basewarning(baseHUD(playerHarry.myHUD).curPopup).DisplayText = Localize( "all", "ingame_help_28","Pickup" );
				QuidHUD(playerHarry.myHUD).curPopup.lifespan = 0;

				PlayerHarry.ClientMessage( "WRONG WAY!" );
			}
			else if ( !bWrongWay && bWasWrongWay )
			{
				// Just stopped going wrong way; turn off Wrong Way prompt
				baseHUD(playerHarry.myHUD).DestroyPopup();
				PlayerHarry.ClientMessage( "Right way" );
			}
			bWasWrongWay = bWrongWay;

			fTimeToCheckHarry = Level.TimeSeconds + 1.0;
		}
	}

	function OnTouchEvent( Pawn Subject, Actor Object )
	{
		// Something touched something, and the event affects the flow of the
		// mini-game.  Update game state accordingly.

		// If Harry touched something...
		if ( Subject == Harry )
		{
			if ( Object == Draco  )
			{
				// Harry touched Draco; Draco takes care of counting bumps
			}
			else
			{
				// Harry touched something else
				PlayerHarry.ClientMessage( "Touched "$Object.Tag );
			}
		}
		else
		{
			// Unexpected touch event
			Super.OnTouchEvent( Subject, Object );
		}
	}

	function OnTriggerEvent( Actor Other, Pawn EventInstigator )
	{
		// Something triggered a 'GameReferee' event.

		// If Other is Draco, then he's telling the referee that he's one
		// bump away from giving up
		if ( Other == Draco )
		{
			GotoState( 'GameBump' );
		}
		else
		{
			// Unexpected trigger event
			Super.Trigger( Other, EventInstigator );
		}
	}

	function OnPlayersDeath()
	{
		// Called when player dies.
		PlayerHarry.ClientMessage( "Player died; restarting game" );
		GotoState( 'GameLost' );
	}

	function EndState()
	{
		PlayerHarry.ClientMessage( "Exited GamePlay State" );
		Log( "Exited GamePlay State" );
	}

begin:
	Harry.BossTarget = Draco;

}

state GameBump
{
	function BeginState()
	{
		// Start chasing Draco
		PlayerHarry.ClientMessage( "Entered GameBump State" );
		Log( "Entered GameBump State" );

		// Set watchdog timer in case Harry never bumps Draco
		SetTimer( 10.0, false );

		// Make Harry trail the snitch
		Harry.GotoState( 'Pursue' );

		// Switch to bump-Draco hud elements and camera
		PlayerHarry.ClientMessage( "BUMP DRACO!" );

		QuidHUD(playerHarry.myHUD).ShowPopup(class'basewarning');
		basewarning(baseHUD(playerHarry.myHUD).curPopup).DisplayText = Localize( "all", "hit_malfoy_text","Pickup" );
		QuidHUD(playerHarry.myHUD).curPopup.lifespan = 10;
//		Harry.cam.gotostate('StandardState');
		Harry.cam.CameraDistance = 50.000;
		Harry.cam.CameraHeight = 100;
		Harry.StandardTarget.TargetOffset = vect(100, 10 ,50);
		Harry.BossTarget = none;
//		Harry.cam.TargetRot = rot(0x1000, 0x1000, 0);
	}

	function OnActionKeyPressed()
	{
		// Called when the player's "Action" key/button is pressed.

		Super.OnActionKeyPressed();

		// Bump Draco into a spinout
		Draco.OnBroomBump( Harry );
		QuidHUD(playerHarry.myHUD).DestroyPopup();
	}

	function OnTriggerEvent( Actor Other, Pawn EventInstigator )
	{
		// Something triggered a 'GameReferee' event.

		// If Other is Draco, then he's telling the referee that he gives up
		// now (had enough bumps and finished spin-out)
		if ( Other == Draco )
		{
			// Turn off hud bump element and reset camera

			// Make Draco throw Remembrall to Harry
			Harry.SetLookForTarget( None );
			GotoState( 'GameWon' );
		}
		else
		{
			// Unexpected trigger event
			Super.Trigger( Other, EventInstigator );
		}
	}

	function Timer()
	{
		// Never actioned on Draco; go back to regular gameplay

		// Turn off hud bump element and reset camera
		Harry.cam.gotostate('QuidditchState');
		Harry.StandardTarget.TargetOffset = vect(100, 0 ,50);
	    Harry.cam.CameraHeight	= 60.000000;
		Harry.cam.CameraDistance	= 150.000;

		Harry.GotoState( 'PlayerWalking' );
		GotoState( 'GamePlay' );
	}

	function EndState()
	{
		PlayerHarry.ClientMessage( "Exited GameBump State" );
		Log( "Exited GameBump State" );

		SetTimer( 0.0, false );
		Harry.StopFlyingOnPath();
		--Draco.Bumps;
	}
}

state GameWon
{
Begin:
	// Go to Win cutscene
	Harry.BossTarget = none;
	TriggerEvent( 'Win', self, None );

loop:
	Sleep( 0.01 );

	goto 'loop';
}

state GameLost
{
Begin:
	// Start mini-game over
	Sleep( 0.5 );
	Level.Game.RestartGame();
}

defaultproperties
{
     RandSeed=(SeedA=1.14224e+033,SeedB=1.49916e+010,SeedC=4.569593e+033,SeedD=1.718108e+019)
}
