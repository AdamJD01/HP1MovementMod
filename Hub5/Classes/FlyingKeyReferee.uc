//=============================================================================
// FlyingKeyReferee -- Keeper of the rules of the mini-game; main game logic
//=============================================================================
class FlyingKeyReferee extends QuidditchReferee;


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	local FlyingKey	Key;

	// Initialize
	Super.PostBeginPlay();

	// Find actors that are subjects to this game
	foreach AllActors( class'FlyingKey', Key )
		break;
	Snitch = Key;

	// Setup HUD
	Harry.HUDType = class'HPMenu.QuidHud';

	// Start single-part intro cutscene (quidditch has 3 parts)
	InitialState = 'GameIntro3';			// Skipping part 1 and 2
}


//-------------------------------------------------------------------------------------------
// States
//
// GameIntro3	- Playing intro cut-scene
// GamePlay		- Interactive; flying Harry to catch key
// GameWon		- Harry caught key
// GameLost		- Harry lost all stamina
//-------------------------------------------------------------------------------------------

state GameIntro3
{
	function BeginState()
	{
		Super.BeginState();
		TriggerEvent( 'Intro', self, None );	// Triggered as soon as possible
	}
}

state GamePlay
{
	function BeginState()
	{
		Super.BeginState();
		QuidHud( Harry.MyHud ).SetHoopBarType(BT_FlyingKeys);
	}
}

state GameWon
{
Begin:
	// Go to Win cutscene
	Sleep( 3.0 );
	TriggerEvent( 'Win', self, None );

loop:
	Sleep( 0.1 );

	goto 'loop';
}

state GameLost
{
	function OnCutSceneEvent( Name CutSceneTag )
	{
		// 'Fail' CutScene ended; restart mini-game
		Level.Game.RestartGame();
	}

Begin:
	// Go to Fail cutscene
	Sleep( 1.2 );
	TriggerEvent( 'Fail', self, None );

loop:
	Sleep( 0.1 );

	goto 'loop';
}

state GameCatch
{
	function BeginState()
	{
		super.BeginState();
		QuidHud( Harry.MyHud ).SetHUDGameType(HUDG_FLYINGKEYS);
	}
}

defaultproperties
{
     fSnitchNeutralRadiusAt0=600
     fSnitchNeutralRadiusAt100=200
     fSnitchMaxLossRadiusAt0=1500
     bNeedsCommentator=False
}
