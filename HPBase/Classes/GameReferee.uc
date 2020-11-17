//=============================================================================
// GameReferee -- Keeper of the rules of a mini-game; main game logic base class
//=============================================================================
class GameReferee extends Actor;

// This class is the base class for all Mini-Game Referee classes.  It is an
// abstract class.  Define your own referee class based on this one and place
// an instance of that class into the level map for the mini-game it for.

// All game referees must be tagged as 'GameReferee' (which is set as default
// by this class, but check it anyway) so that event detectors in the level
// know who to trigger without having to know exactly what game is being played.

// Objects that detect touch events that could be important to the overall game
// state, must report the event to the GameReferee by calling the OnTouchEvent
// function.  Descendant referee's override that handler and respond to the
// touch event as appropriate for the type of mini-game.

// CutScene's communicate to the referee by using their Trigger command and
// 'GameReferee' as the trigger event.  These events are caught by the
// OnCutSceneEvent handler, which descendant referee's override and respond to
// the event as appropriate.

// Standard trigger objects communicate to the referee by having 'GameReferee'
// as their trigger event.  These events are caught by the OnTriggerEvent
// handler, which descendant referee's override and respond to the event as
// appropriate.  Note that the referee cannot distinguish which trigger object
// triggered a 'GameReferee' event.

// All descendant GameReferees can use the PlayerHarry variable to channel
// ClientMessages through.

var baseHarry	PlayerHarry;
var baseConsole	Console;

enum GamePlayMode
{
	PM_Auto,			// Game will auto-detect which mode it should play in (by checking HPConsole state)
	PM_InHubFlow,		// Game should act as if played from within hub-to-hub level flow
	PM_MenuDirect,		// Game should act as if played from direct access buttons on menu
};

var(GameReferee) GamePlayMode	PlayMode;	// Which mode should mini-game play in

function PreBeginPlay()
{
	// Initialize
	Super.PreBeginPlay();

	// Find player that channels ClientMessages
	foreach AllActors( class'baseHarry', PlayerHarry )
		break;
}

function OnTouchEvent( Pawn Subject, Actor Object )
{
	// Something touched something, and the event affects the flow of the
	// mini-game.  Update game state accordingly.

	// This is the default handler for mini-game touch events; the descendant class
	// should override this function to handle all mini-game touch events that need
	// refereeing, but it should also call this version for any touch events that
	// the descendant class doesn't know how to handle.

	// Unexpected touch event
	PlayerHarry.ClientMessage( Subject.Name$" touched "$Object.Name );
}

function OnHitEvent( Pawn Subject )
{
	// Something hit part of the world (walls/floors), and the event affects
	// the flow of the mini-game.  Update game state accordingly.

	// This is the default handler for mini-game touch events; the descendant class
	// should override this function to handle all mini-game hit events that need
	// refereeing, but it should also call this version for any hit events that
	// the descendant class doesn't know how to handle.

	// Unexpected hit event
	PlayerHarry.ClientMessage( Subject.Name$" hit an obstacle" );
}

function OnCutSceneEvent( Name CutSceneTag )
{
	// A CutScene triggered the GameReferee.  The CutSceneTag parameter is the
	// tag name of the triggering CutScene.

	// This is the default handler for mini-game CutScene events; the descendant class
	// should override this function to handle all mini-game CutScene events that need
	// refereeing, but it should also call this version for any CutScene events that
	// the descendant class doesn't know how to handle.

	// Unexpected CutScene event
	PlayerHarry.ClientMessage( "CutScene "$CutSceneTag$" triggered GameReferee" );
}

function OnTriggerEvent( Actor Other, Pawn EventInstigator )
{
	// Something activated a standard trigger that was linked to the 'GameReferee'.
	// Update game state accordingly.

	// The Other parameter will be the actor that activated the trigger, and the
	// EventInstigator will be "Other's" current instigator.  The trigger object
	// itself is not identified.

	// This is the default handler for mini-game trigger events; the descendant class
	// should override this function to handle all mini-game trigger events that need
	// refereeing, but it should also call this version for any trigger events that
	// the descendant class doesn't know how to handle.

	// Unexpected trigger event
	PlayerHarry.ClientMessage( Other$" triggered GameReferee with "$EventInstigator );
}

function Trigger( Actor Other, Pawn EventInstigator )
{
	// Something triggered a 'GameReferee' event.  This could originate from an
	// actor encountering a standard trigger object, or a CutScene executing a
	// Trigger command from its script.

	// For standard trigger objects, the Other parameter will be the actor that
	// activated the trigger, and the EventInstigator will be "Other's" current
	// instigator.  The trigger object itself is not identified.

	// For CutScene triggers, the Other parameter will be the CutScene itself,
	// and the EventInstigator will be None.

	// This function simply splits the possibilities into two handlers.

	local baseScript	CutScene;

//	PlayerHarry.ClientMessage( Other$" triggered GameReferee with "$EventInstigator );
//	Log( Other$" triggered GameReferee with "$EventInstigator );
	CutScene = baseScript( Other );

	if ( CutScene != None )
	{
		OnCutSceneEvent( CutScene.Tag );
	}
	else
	{
		OnTriggerEvent( Other, EventInstigator );
	}
}

function OnPlayerPossessed()
{
	// Called when player gets possessed by (attached to) the viewport (Player).
	// This is the first moment when the Player member of PlayerPawn is valid,
	// and thus a reference to the Console.

	// Get a reference to the console
	Log( "Player possessed" );
	Console = baseConsole( PlayerHarry.Player.Console );
}

function OnPlayerDying()
{
	// Called when player starts dying.

	PlayerHarry.ClientMessage( "Player dying..." );
}

function OnPlayersDeath()
{
	// Called when player dies.

	PlayerHarry.ClientMessage( "Player died; restarting game" );
	Level.Game.RestartGame();
}

function OnActionKeyPressed()
{
	// Called when the player's "Action" key/button is pressed.

	PlayerHarry.ClientMessage( "Action key pressed" );
}

defaultproperties
{
     bHidden=True
     Tag='
     Texture=Texture'Engine.S_Flag'
     DrawScale=3
}
