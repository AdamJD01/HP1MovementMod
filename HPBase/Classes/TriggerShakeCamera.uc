class TriggerShakeCamera extends trigger;

var() float shaketime;
var() float RollMag;
var() float vertmag;

var   baseHarry   playerHarry;

//*******************************************************************************
function PostBeginPlay()
{
	ForEach AllActors(class'baseHarry', playerHarry)
		break;
}

//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	ProcessTrigger();
}

function touch(actor other)
{
	super.touch(other);

	ProcessTrigger();
}

//*******************************************************************************
function ProcessTrigger()
{
	playerHarry.ShakeView( shaketime, RollMag, vertmag );
}

defaultproperties
{
}
