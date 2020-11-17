//=============================================================================
// BroomPracticeReferee -- Keeper of the rules of the mini-game; main game logic
//=============================================================================
class BroomPracticeReferee extends GameReferee;

var BroomHarry	Harry;
var BroomHooch	Hooch;

var BroomHoop	Hoops[250];				// MaxPaths * MaxStages * MaxHoopsPerStage
const			MaxPaths = 2;
const			MaxStages = 5;
const			MaxHoopsPerStage = 25;

var int			CurrentPath;			// Which path currently in play (one-based)
var int			LastPath;				// Which path was in play last trial (one-based)
var int			CurrentStage;			// Which stage currently in play (one-based)
var int			NextHoopToHit;
var int			HoopsHit;
var	int			MaxHoops[2];			// Per path
var	int			HoopsInStage;			// Hoops in current stage

var int			HousePointsEarned;		// How many house points were earned but not posted yet

var(GameReferee) int	PathToStartWith;			// Which path to start game with
var(GameReferee) float	fMaxBankedTime;				// Theoretical maximum of how much time you could bank on path 1
var(GameReferee) float	fMaxBankedTime_Path2;		// Theoretical maximum of how much time you could bank on path 2
var(GameReferee) float	TimeAddedEachStage[5];		// 0 = beginning of stage 1, path 1
var(GameReferee) float	TimeAddedEachStage_Path2[5];// 0 = beginning of stage 1, path 2
var(GameReferee) int	MinHoopsToPass;

var Sound				HoopSounds[16];				// All the different through-hoop sounds

var bool		bLastHoopWellDone;					// Whether last hoop was executed well
var float		fTimeOfLastComment;					// When last comment was made
const			fMinTimeBetweenComments = 8.0;		// How much time must elapse before another comment can be said

var float		fTimeForNextPopup;					// When next popup hint should appear
var bool		bBoostHintShown;					// Whether boost popup hint has been shown
var bool		bBrakeHintShown;					// Whether brake popup hint has been shown

var bool		bSecretFound;
var bool		bPlayedSecretScene;

var bool		bReplay;		// Whether we're playing from menu rather than hub-flow


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	local BroomHoop Hoop;
	local int HoopNumber;
	local int Stage;

	// Initialize
	Super.PostBeginPlay();

	// Find actors that are subjects to this game
	foreach AllActors( class'BroomHarry', Harry )
		break;
	foreach AllActors( class'BroomHooch', Hooch )
		break;

	// Find all the hoops
	MaxHoops[0] = 0;	// Path 1
	MaxHoops[1] = 0;	// Path 2
	foreach AllActors( class'BroomHoop', Hoop )
	{
		if ( Hoop.Stage >= 1 && Hoop.Stage <= MaxStages )
		{
			if (    Hoop.PathNumber >= 1 && Hoop.PathNumber <= MaxPaths
				 && Hoop.HoopNumber >= 1 && Hoop.HoopNumber <= MaxHoopsPerStage )
			{
				Hoops[ HoopIndex( Hoop.PathNumber, Hoop.Stage, Hoop.HoopNumber ) ] = Hoop;
				++MaxHoops[ Hoop.PathNumber-1 ];
			}
			else
			{
				Log( "Lost Hoop "$Hoop.Name );
			}
		}
		else
		{
			Log( "Lost Hoop "$Hoop.Name );
//			// Stage number lost: give hoop a default stage number
//			Hoop.Stage = 1;
//			while ( Hoops[ HoopIndex( Hoop.PathNumber, Hoop.Stage, Hoop.HoopNumber ) ] != None )
//				Hoop.Stage += 1;
//			Hoops[ HoopIndex( Hoop.PathNumber, Hoop.Stage, Hoop.HoopNumber ) ] = Hoop;
		}
	}

	// Load the hoop sounds
	HoopSounds[ 0] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop';
	HoopSounds[ 1] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop01';
	HoopSounds[ 2] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop02';
	HoopSounds[ 3] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop03';
	HoopSounds[ 4] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop04';
	HoopSounds[ 5] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop05';
	HoopSounds[ 6] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop06';
	HoopSounds[ 7] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop07';
	HoopSounds[ 8] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop08';
	HoopSounds[ 9] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop09';
	HoopSounds[10] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop10';
	HoopSounds[11] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop11';
	HoopSounds[12] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop12';
	HoopSounds[13] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop13';
	HoopSounds[14] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop14';
	HoopSounds[15] = Sound'HPSounds.Quidditch_sfx.Q_Through_Hoop15';

	// Setup HUD
	Harry.HUDType = class'HPMenu.BroomHud';

	// Initialize other members
	bLastHoopWellDone  = false;
	fTimeOfLastComment = 0.0;

	bBoostHintShown = false;
	bBrakeHintShown = false;

	bSecretFound	   = false;
	bPlayedSecretScene = false;

	// Start the mini-game with intro CutScene
	InitialState = 'GameIntro';
}


//-------------------------------------------------------------------------------------------
// Functions for managing hoops and stages
//-------------------------------------------------------------------------------------------

function int HoopIndex( int PathNumber, int Stage, int HoopNumber )
{
	// Returns the array index for the hoop indicated by the given path, stage
	// and hoop sequence number

	return ((PathNumber-1)*MaxStages + (Stage-1))*MaxHoopsPerStage + (HoopNumber-1);
}

function StartStage()
{
	// Setups the hoops to begin the stage indicated by CurrentStage
	local BroomHoop	Hoop;
	local int		HoopNumber;

	// Play comment from Hooch (but only if time isn't almost out so as to
	// avoid stepping on next comment)
	if ( BroomHud( Harry.MyHud ).GetCountdown() > 3.0 )
	{
		switch ( CurrentStage )
		{
			case 2: Hooch.SayComment( HC_SmallerHoops );	break;
			case 3: Hooch.SayComment( HC_Height );			break;
			case 4: Hooch.SayComment( HC_Challenge );		break;
			case 5: Hooch.SayComment( HC_MovingHoops );		break;
		}
	}

	// Determine how many hoops are in this stage
	HoopsInStage = 0;
	for ( HoopNumber = 1; HoopNumber <= MaxHoopsPerStage; ++HoopNumber )
	{
		Hoop = Hoops[ HoopIndex( CurrentPath, CurrentStage, HoopNumber ) ];
		if ( Hoop == None )
			break;
		else
			++HoopsInStage;
	}

	// Turn on first three hoops of first stage
	for ( HoopNumber = 1; HoopNumber <= 3; ++HoopNumber )
	{
		Hoop = Hoops[ HoopIndex( CurrentPath, CurrentStage, HoopNumber ) ];
		Hoop.GotoState( 'HoopAppearing' );
	}

	// Emphasize next hoop to hit
	NextHoopToHit = 1;
	Hoop = Hoops[ HoopIndex( CurrentPath, CurrentStage, NextHoopToHit ) ];
	Hoop.GotoState( 'HoopNextToHit' );
	if ( IsInState( 'GameTrial' ) )
		Harry.SetLookForTarget( Hoop );
}

function EndStage()
{
	// Ends the current stage and prepares to run another stage
	local BroomHoop Hoop;
	local int HoopNumber;
	local float fNewCountdownTime;
	local int	MaxHoopsInPath;

	// Turn off all remaining hoops
	for ( HoopNumber = NextHoopToHit; HoopNumber < NextHoopToHit + 3; ++HoopNumber )
	{
		if ( HoopNumber <= MaxHoopsPerStage )
		{
			Hoop = Hoops[ HoopIndex( CurrentPath, CurrentStage, HoopNumber ) ];
			if ( Hoop != None && !Hoop.IsInState('HoopDisappearing') && !Hoop.IsInState('HoopInvisible') )
				Hoop.GotoState( 'HoopDisappearing' );
		}
	}

	// Determine next stage to go to
	if ( !BroomHud( Harry.MyHud ).bCountingDown || CurrentStage >= MaxStages )
	{
		LastPath = CurrentPath;
		MaxHoopsInPath = MaxHoops[ CurrentPath-1 ];
		if ( HoopsHit >= MaxHoopsInPath )
		{
			// Hit all the hoops!
			BroomHud( Harry.MyHud ).StopCountdown();
			PlayerHarry.ClientMessage( "Perfect" );
			HousePointsEarned = 20;
			TriggerEvent( 'Perfect', self, None );

			// Switch paths for bonus replay
			if ( CurrentPath >= 2 )
				CurrentPath = 1;
			else
				++CurrentPath;

			GotoState( 'GamePass' );
		}
		else if ( HoopsHit >= (MaxHoopsInPath-MinHoopsToPass)*2/3 + MinHoopsToPass )
		{
			// Excellent
			PlayerHarry.ClientMessage( "Excellent" );
			HousePointsEarned = 15;
			TriggerEvent( 'Excellent', self, None );
			GotoState( 'GamePass' );
		}
		else if ( HoopsHit >= (MaxHoopsInPath-MinHoopsToPass)*1/3 + MinHoopsToPass )
		{
			// Good
			PlayerHarry.ClientMessage( "Good" );
			HousePointsEarned = 10;
			TriggerEvent( 'Good', self, None );
			GotoState( 'GamePass' );
		}
		else if ( HoopsHit >= MinHoopsToPass )
		{
			// Pass
			PlayerHarry.ClientMessage( "Pass" );
			HousePointsEarned = 5;
			TriggerEvent( 'Pass', self, None );
			GotoState( 'GamePass' );
		}
		else
		{
			// Redo
			PlayerHarry.ClientMessage( "Redo" );
			GotoState( 'GameRedo' );
		}
	}
	else
	{
		// Add time bonus for completing stage
		if ( CurrentPath == 2 )
			BroomHud( Harry.MyHud ).fCountdownTime += TimeAddedEachStage_Path2[ CurrentStage ];
		else
			BroomHud( Harry.MyHud ).fCountdownTime += TimeAddedEachStage[ CurrentStage ];

		// Move to next stage
		++CurrentStage;
		PlayerHarry.ClientMessage("Going to Stage "$CurrentStage);
		StartStage();
	}
}

//-------------------------------------------------------------------------------------------
// Operational methods
//-------------------------------------------------------------------------------------------

function bool IsOkayToComment()
{
	// Returns True if it's a safe time for Hooch to make an in-stage comment.
	// "Safe" means that Hooch's comment won't step on her mandatory comments
	// she makes at the beginning of each stage and at the end of the trial.

	return (    NextHoopToHit > 3 && NextHoopToHit < HoopsInStage
			 && Level.TimeSeconds > fTimeOfLastComment + fMinTimeBetweenComments
			 && BroomHud( Harry.MyHud ).GetCountdown() > 3.0 );
}

function OnPlayerPossessed()
{
	// Called when player gets possessed by (attached to) the viewport (Player).
	// This is the first moment when the Player member of PlayerPawn is valid,
	// and thus a reference to the Console.
	local JellyBean	Bean;
	local WizzardCardIcon	Card;

	// Find out from console whether the mini-game is being replayed directly
	// from the menu (rather than in the course of hub flow).
	Super.OnPlayerPossessed();

	// Determine play mode
	switch ( PlayMode )
	{
		case PM_Auto:		bReplay = !HPConsole( Console ).bInHubFlow;	break;
		case PM_InHubFlow:	bReplay = false;							break;
		case PM_MenuDirect:	bReplay = true;								break;
	}

	// If played Menu Direct, omit wizard card and beans
	if ( bReplay )
	{
		foreach AllActors( class'JellyBean', Bean )
		{
			Bean.GotoState( 'DeadBean' );
		}
		foreach AllActors( class'WizzardCardIcon', Card )
		{
			Card.bHidden=true;
			Card.SetCollision( false, false, false );
			Card.bCollideWorld = false;
		}
	}

	// Trigger the correct intro cut-scene that corresponds to the play mode
	// the level is in
	if ( bReplay )
		TriggerEvent( 'ReplayIntro', self, None );
	else
		TriggerEvent( 'Intro', self, None );
}

//-------------------------------------------------------------------------------------------
// States
//
// GameIntro	- Playing an intro cut-scene
// GameTrial	- Interactive; flying Harry through hoops
// GameRedo		- Playing the fail cut-scene
// GamePass		- Playing one of the success cut-scenes
// GameSecret	- Playing the cut-scene about you finding the secret area
// GameReplay	- Playing a cut-scene about replaying the hoops again
// GameExit		- Playing the transitional cut-scene to next level
//-------------------------------------------------------------------------------------------

state GameIntro
{
	// Note: appropriate cut-scene was triggered from OnPlayerPossessed

	function BeginState()
	{
		// Make hoops visible for demo purposes in Intro CutScene
		CurrentPath = PathToStartWith;
		CurrentStage = 1;
		HoopsHit = 0;
		StartStage();
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// Intro CutScene ended; start broom flying trial
		GotoState( 'GameTrial' );
	}
}

state GameTrial
{
	function BeginState()
	{
		// Have hooch blow whistle
		Hooch.BlowWhistle();

		// Start hoop sequence and timer
		CurrentStage = 1;
		HoopsHit = 0;
		StartStage();

		Harry.AirSpeed = 10;
		Harry.Deceleration = Harry.AirSpeedNormal - Harry.AirSpeed;
		Harry.SetLookForTarget( Hoops[ HoopIndex( CurrentPath, CurrentStage, NextHoopToHit ) ] );

		fTimeForNextPopup = Level.TimeSeconds + 5.0;

		BroomHud( Harry.MyHud ).SetHoopCounts( HoopsHit, MaxHoops[ CurrentPath-1 ] );
		BroomHud( Harry.MyHud ).SetHoopBarType(BT_Practice);
		BroomHud( Harry.MyHud ).EnableHoopBarDraw( true );
		BroomHud( Harry.MyHud ).EnableHoopCountDraw( true );
		if ( CurrentPath == 2 )
		{
			BroomHud( Harry.MyHud ).StartCountdown( fMaxBankedTime_Path2 );			// Scale of time bar
			BroomHud( Harry.MyHud ).fCountdownTime = TimeAddedEachStage_Path2[0];	// Initial time left
		}
		else
		{
			BroomHud( Harry.MyHud ).StartCountdown( fMaxBankedTime );			// Scale of time bar
			BroomHud( Harry.MyHud ).fCountdownTime = TimeAddedEachStage[0];		// Initial time left
		}
	}

	function EndState()
	{
		Harry.SetLookForTarget( None );

		if ( baseHUD( Harry.myHUD ).curPopup != None )
			baseHUD( Harry.myHUD ).DestroyPopup();
	}

	event Tick( float DeltaTime )
	{
		// Handle hint popups
		if ( (fTimeForNextPopup != -1.0) && (Level.TimeSeconds > fTimeForNextPopup) )
		{
			if ( !Harry.bHasEverBoosted && !bBoostHintShown )
			{
				baseHUD( Harry.myHUD ).ShowPopup( class'basewarning' );
				BaseWarning( baseHUD( Harry.myHUD ).curPopup ).DisplayText = Localize( "all", "ingame_help_18", "Pickup" );
				baseHUD( Harry.myHUD ).curPopup.lifespan = 5;

				bBoostHintShown = true;
				fTimeForNextPopup = Level.TimeSeconds + 7.0;
			}
			else if ( !Harry.bHasEverBraked && !bBrakeHintShown )
			{
				baseHUD( Harry.myHUD ).ShowPopup( class'basewarning' );
				BaseWarning( baseHUD( Harry.myHUD ).curPopup ).DisplayText = Localize( "all", "ingame_help_19", "Pickup" );
				baseHUD( Harry.myHUD ).curPopup.lifespan = 5;

				bBrakeHintShown = true;
				fTimeForNextPopup = -1;
			}
			else
				fTimeForNextPopup = -1;
		}

		// Check timer
		if ( BroomHud( Harry.MyHud ).GetCountdown() == 0 )
		{
			// Ran out of time
			BroomHud( Harry.MyHud ).StopCountdown();
			EndStage();
		}
	}

	function OnTouchEvent( Pawn Subject, Actor Object )
	{
		// Something touched something, and the event affects the flow of the
		// mini-game.  Update game state accordingly.
		local BroomHoop Hoop, NextHoop;
		local int HoopNumber;

		local Vector	FlightDir;
		local Vector	HoopDir;
		local float		fInLine;
		local bool		bHoopWellDone;

		// If Harry touched something...
		if ( Subject == Harry )
		{
			Hoop = BroomHoop( Object );
			if ( Hoop != None )
			{
				// Harry touched a hoop: turn off hoop and turn on next one after
				// last visible one
				if ( Hoop.IsInState('HoopNextToHit') )
				{
					// Hit the right hoop...
					PlayerHarry.ClientMessage("Hit Hoop "$Hoop.HoopNumber);
					++HoopsHit;
					if ( Hoop.HoopNumber <= 15 )
						Hoop.PlaySound( HoopSounds[ Hoop.HoopNumber ] );
					else
						Hoop.PlaySound( HoopSounds[ 15 ] );
					BroomHud( Harry.MyHud ).SetHoopCounts( HoopsHit, MaxHoops[ CurrentPath-1 ] );

					// Hide current hoop
					Hoop.GotoState( 'HoopDisappearing' );

					// Go on to next hoop
					bHoopWellDone = false;
					++NextHoopToHit;
					if ( NextHoopToHit > MaxHoopsPerStage )
					{
						EndStage();
					}
					else
					{
						NextHoop = Hoops[ HoopIndex( CurrentPath, CurrentStage, NextHoopToHit ) ];
						if ( NextHoop == None )
						{
							EndStage();
						}
						else
						{
							// First see how well Harry did on last hoop and comment on it
							// (as long as we're not near the ends of a stage)
							if ( IsOkayToComment() )
							{
								FlightDir = Vector( Harry.Rotation );
								HoopDir = Vector( Hoop.Rotation );
								fInLine = FlightDir dot HoopDir;

								if ( fInLine > 0.98 && VSize(Harry.Velocity) > Harry.AirSpeedNormal )
								{
									// Harry hit hoop straight-on at a decent speed;
									// if done this twice in a row, say "Well Done!"
									if ( bLastHoopWellDone )
									{
										if ( Hooch.SayComment( HC_WellDone ) )
											fTimeOfLastComment = Level.TimeSeconds;
									}
									bHoopWellDone = true;
								}
								else if ( fInLine <= 0.0 )
								{
									// Harry hit hoop while not looking forward;
									// say "Keep your eye on next hoop!"
									if ( Hooch.SayComment( HC_KeepEyeOnHoop ) )
										fTimeOfLastComment = Level.TimeSeconds;
								}
								else if ( Harry.GetReversalsPerSecond() > 2.0 )
								{
									// Harry is overreacting on the controls;
									// say "Gently, Gently..."
									if ( Hooch.SayComment( HC_Gently ) )
										fTimeOfLastComment = Level.TimeSeconds;
								}
								else if ( CurrentStage >= 4 )
								{
									// Harry's doing pretty well; say a random comment
									if ( frand() < 0.1 )
									{
										if ( Hooch.SayComment( HC_NaturalTalent ) )
											fTimeOfLastComment = Level.TimeSeconds;
										else if ( Hooch.SayComment( HC_BonusPoints ) )
											fTimeOfLastComment = Level.TimeSeconds;
									}
								}
							}
							
							// Emphasize next hoop to hit
							NextHoop.GotoState( 'HoopNextToHit' );
							Harry.SetLookForTarget( NextHoop );

							// Reveal another hoop after last visible one
							HoopNumber = Hoop.HoopNumber + 3;
							if (HoopNumber <= MaxHoopsPerStage)
							{
								NextHoop = Hoops[ HoopIndex( CurrentPath, CurrentStage, HoopNumber ) ];
								if ( NextHoop != None )
									NextHoop.GotoState( 'HoopAppearing' );
							}
						}
					}
					bLastHoopWellDone = bHoopWellDone;
				}
				else if ( !Hoop.bHidden )
				{
					// Touched a hoop out of order...
					PlayerHarry.ClientMessage("Touched Hoop "$Hoop.HoopNumber);
				}
			}
			else if ( Object.Tag == 'BroomSecretTrigger' )
			{
				// Harry entered secret area
				if ( !bSecretFound )
				{
					bSecretFound = true;
					PlayerHarry.ClientMessage( "Found Secret!" );
				}
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

	function OnHitEvent( Pawn Subject )
	{
		// Something hit part of the world (walls/floors), and the event affects
		// the flow of the mini-game.  Update game state accordingly.

		// If Harry hit something...
		if ( Subject == Harry )
		{
			// He's being clumsy; comment on it
			// (if it's a safe time to make comments)
			if ( IsOkayToComment() )
			{
				if ( Hooch.SayComment( HC_WatchYourself ) )
					fTimeOfLastComment = Level.TimeSeconds;
			}
		}
		else
		{
			// Unexpected hit event
			Super.OnHitEvent( Subject );
		}
	}
}

state GameRedo
{
	function BeginState()
	{
		TriggerEvent( 'Redo', self, None );
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// Redo CutScene ended; restart broom flying trial
		GotoState( 'GameTrial' );
	}
}

state GamePass
{
	// Note: appropriate cut-scene was triggered
	// just before going into this state

	function BeginState()
	{
		// Unlock broom practice on special quidditch menu; earned it by passing level
		if ( !bReplay )
			FEQuidMatchPage( HPConsole( Console ).menuBook.QuidMatchPage ).
				UnlockQuidditch( "Broom" );
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// One of the success CutScenes ended; play next CutScene
		Harry.AddHousePoints(HousePointsEarned);

		BroomHud( Harry.MyHud ).EnableHoopBarDraw(false);
		BroomHud( Harry.MyHud ).EnableHoopCountDraw(false);

		if ( bSecretFound && !bPlayedSecretScene )
			GotoState( 'GameSecret' );
		else if ( bReplay )
			GotoState( 'GameReplay' );
		else
			GotoState( 'GameExit' );
	}
}

state GameSecret
{
	function BeginState()
	{
		TriggerEvent( 'SecretArea', self, None );
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// The Secret CutScene ended; play next Cut-Scene
		bPlayedSecretScene = true;

		if ( bReplay )
			GotoState( 'GameReplay' );
		else
			GotoState( 'GameExit' );
	}
}

state GameReplay
{
	function BeginState()
	{
		if ( CurrentPath != LastPath )
			TriggerEvent( 'ReplayAltPath', self, None );
		else
			TriggerEvent( 'Replay', self, None );
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// The Replay Cut-Scene ended; restart the trial
		GotoState( 'GameTrial' );
	}
}

state GameExit
{
	function BeginState()
	{
		TriggerEvent( 'Exit', self, None );
	}

	function OnCutSceneEvent( Name CutSceneTag )
	{
		// The Exit Cut-Scene ended; load next level
	baseConsole(harry.player.console).ChangeLevel("Lev_Tut3.unr",true);
	
//	Level.ServerTravel( "Lev_Tut3.unr", true );
	}
}

defaultproperties
{
     PathToStartWith=1
     fMaxBankedTime=100
     fMaxBankedTime_Path2=100
     TimeAddedEachStage(0)=100
     TimeAddedEachStage_Path2(0)=90
     TimeAddedEachStage_Path2(1)=10
     TimeAddedEachStage_Path2(2)=10
     TimeAddedEachStage_Path2(3)=10
     TimeAddedEachStage_Path2(4)=10
     MinHoopsToPass=30
}
