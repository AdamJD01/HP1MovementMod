class TriggerSetBaseCharOnPatrolPath extends trigger;

//Takes every baseChar whos tag matches this trigger's event, and makes
// them start patrolling, starting with DestPatrolPoint_ObjectName.

var() name DestPatrolPoint_ObjectName;
var() bool bAlsoTriggerBaseChar;

//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	ProcessTrigger();
}

function touch(actor other)
{
	if( bAlsoTriggerBaseChar )
		super.touch(other);

	ProcessTrigger();
}

//*******************************************************************************
function ProcessTrigger()
{
	local PatrolPoint   dp;
	local baseChar      a;

	foreach AllActors( class'PatrolPoint', dp )
		if( dp.name == DestPatrolPoint_ObjectName )
			break;

	if( dp == none )
	{
		Log("TriggerSetBaseCharOnPatrolPath: Couldn't find Dest patrol point");
		return;
	}

	foreach allactors(class'baseChar', a, event)
	{
		a.firstPatrolPointObjectName = DestPatrolPoint_ObjectName;
		a.bFollowPatrolPoints = true;
		a.bGoBackToLastNavPoint = false;
		a.navP = none;
		a.tempNavP = none;
		a.LastNavP = none;
		a.GotoState('patrol');
	}
}


//*****************************************************************************

defaultproperties
{
     bAlsoTriggerBaseChar=True
}
