//=============================================================================
// starsTrigger.
//=============================================================================
class StarsTrigger expands Trigger;

var(StarsTrigger) name loserTrigger;
var(StarsTrigger) name avgTrigger;
var(StarsTrigger) name winnerTrigger;
var(StarsTrigger) int avgStarCount;
var(StarsTrigger) int winnerStarCount;
var bool alreadytriggered;


function Touch( actor Other )
{
	super.touch(other);
	if (alreadytriggered==true)
	{
		return;
	}
	alreadytriggered=true;
	if(Pawn(Other).bIsPlayer)
	{
		if(baseHarry(other).numStars>=winnerStarCount)
		{
			baseharry(other).numStars=0;
			TriggerEvent(winnerTrigger, self,Pawn(other));
			baseharry(other).addhousepoints(20);
			return;
		}
		else
		{
			if(baseharry(other).numStars>=avgStarCount)
			{
				baseharry(other).numStars=0;
				baseharry(other).clientmessage("called avgTrigger "$avgTrigger);
				TriggerEvent(avgTrigger, self, pawn(other));
				baseharry(other).addhousepoints(10);
				return;
			}
			else
			{
				baseharry(other).numStars=0;
				TriggerEvent(loserTrigger, self, pawn(other));
				baseharry(other).addhousepoints(5);
				return;
			}
		}
	baseharry(other).numStars=0;
	}
}

defaultproperties
{
}
