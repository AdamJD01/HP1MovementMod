class FireSeedTrigger extends trigger;

var()	int			iNumSeedsToCollect;

var		int			iCurrentNumSeeds;
var		baseHarry	Player;


function Activate( actor Other, pawn Instigator )
{
	log("fireseed activating");
	foreach AllActors(class'baseharry', Player)
	{
		break;
	}
	iCurrentNumSeeds = Player.iFireSeedCount;
	GotoState('Active');
}

auto state() Inactive
{
	function beginstate()
	{
		log("fireseed beginstate");
	}

}

state Active
{
	function tick(float deltatime)
	{
		local	actor	A;

//		log("fireseed current num seeds " $Player.iFireSeedCount $" to collect " $(iNumSeedsToCollect + iCurrentNumSeeds));
		if (Player.iFireSeedCount >= (iNumSeedsToCollect + iCurrentNumSeeds))
		{
			// trigger the event!
			if( Event != '' )
			{
				foreach AllActors( class 'Actor', A, Event )
				{
//					log("fireseed trigger " $string(a.name));
					A.Trigger( Player, Player.Instigator );
				}
			}
			Destroy();
		}
	}
}

defaultproperties
{
}
