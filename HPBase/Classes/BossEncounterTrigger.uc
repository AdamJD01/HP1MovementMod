class BossEncounterTrigger extends trigger;

//var() bool   bSendTriggerOnTouch;
var() bool       bHarryShouldLockOntoBoss;
var() bool       bReverseInput;
var() bool       bKeepHarryFixed;
var() bool       bCanCast;
var() ESpellType ForceSpellType;
var() bool       bFixedFaceDirection;  //Uses direction this Trigger faces
var() bool       bDontNeedABoss;
var() bool       bExtendedTargetting;

var   bool       bDisabled;

//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	local baseBoss  boss;

	if( !bDisabled )
	{
		ProcessTrigger();
		super.Touch( Other );

		//What the hell am I doing wrong?  Why doesn't the trigger get sent off?  Why do I have to do this?
		foreach AllActors( class'baseBoss', boss, Event )
		{
			Log("******** BossEncoutnerTrigger sent trigger to boss:"$boss);
			boss.Trigger(none, none);
		}

		//boss.Trigger(none, none);	
	}
}

//*******************************************************************************
function Touch( actor Other )
{
	if( baseHarry(Other) == none )
		return;

	if( !bDisabled )
	{
		//if( bSendTriggerOnTouch )
			Super.Touch( Other );

		Log("******** boss encounter touch");

		ProcessTrigger();

		//if( bSendTriggerOnTouch )
		//	TriggerEvent( Event, none, none );
	}
}

//*******************************************************************************
function ProcessTrigger()
{
	local baseHarry h;
	local baseBoss  boss;
	local vector    vFixedFaceDirection;

	bDisabled = true;

	if( bFixedFaceDirection )
		vFixedFaceDirection = vector( Rotation );
	else
		vFixedFaceDirection = vect(0,0,0);

	//Find nearest boss
	foreach AllActors( class'baseBoss', boss, Event )
		break;

	Log("Found Boss:" $ boss);

	if( boss != none  ||  bDontNeedABoss )
	{
		foreach AllActors( class'baseHarry', h )
		{
			h.StartBossEncounter(boss, bHarryShouldLockOntoBoss, bReverseInput, bKeepHarryFixed, bCanCast, vFixedFaceDirection, ForceSpellType, bExtendedTargetting);
			break;
		}
	}
	else
	{
		Log("BossEncounterTrigger : Couldn't find boss to have encounter with");
	}

	//return boss;
}


//*****************************************************************************

defaultproperties
{
     bHarryShouldLockOntoBoss=True
     bDirectional=True
}
