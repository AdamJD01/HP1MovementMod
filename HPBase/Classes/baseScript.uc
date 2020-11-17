class baseScript expands actor;

#EXEC TEXTURE IMPORT NAME=CutSceneIcon  FILE=TEXTURES\CutSceneIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

var baseHarry playerHarry;
var baseNarrator theNarrator;

function PreBeginPlay()
{

	Super.PreBeginPlay();
	foreach AllActors(class'baseharry', playerHarry)
		{
		if( playerHarry.bIsPlayer&& playerHarry!=Self)
			{
				break;
			}
		}
}

function CutSkip()
{
}
function CutCue(string cue)
{
}
function BroadcastTrigger(string Event)
{
local actor A;
local name eventName;

	eventName=name(event);
	// Broadcast the Trigger message to all matching actors.
	if( eventName != '' )
		foreach AllActors( class 'Actor', A, eventName )
			A.Trigger( self, None );
}

defaultproperties
{
     bHidden=True
     Texture=Texture'HPBase.Icons.CutSceneIcon'
     bCollideActors=True
}
