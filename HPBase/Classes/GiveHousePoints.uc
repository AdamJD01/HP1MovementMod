class GiveHousePoints extends trigger;

var() int     HousePoints;

//*******************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	ProcessTrigger();
}

function touch(actor other)
{
	//super.touch(other);

	//ProcessTrigger();
}

//*******************************************************************************
function ProcessTrigger()
{
	local baseHarry   a;

	foreach AllActors( class'baseHarry', a )
		break;

	if( a == none )
	{
		Log("TriggerChangeLevel: Couldn't find baseHarry, and that ain't right!");
		return;
	}

	a.AddHousePoints(HousePoints);


}


//*****************************************************************************

defaultproperties
{
}
