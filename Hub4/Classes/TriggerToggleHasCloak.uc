class TriggerToggleHasCloak extends trigger;


//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	Log("********** TriggerToggleHasCloak 1");

	ProcessTrigger();
}

function touch(actor other)
{
	Log("********** TriggerToggleHasCloak 2");
	super.touch(other);

	ProcessTrigger();
}

//*******************************************************************************
function ProcessTrigger()
{
	local InvisibleHarry  a;
	
	Log("********** TriggerToggleHasCloak 3");

	foreach AllActors(class'InvisibleHarry', a)
	{
		Log("********** TriggerToggleHasCloak 4");
		a.bHasCloak = !a.bHasCloak;
	}

}


//*****************************************************************************

defaultproperties
{
}
