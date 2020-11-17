class TriggerReportCard extends trigger;

var() name TriggerToSendWhenDone;
var() float DisplayTime;

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
	local baseHarry  p;
	local baseHUD hud;
	
	foreach AllActors(class'baseHarry', p)
		break;

	if( p != none )
	{
		hud = baseHUD(p.myHUD);

		// Report card has been disabled!
		log("Report card trigger ... done (report card disabled)");
/*
		if (hud != None)
		{
			Log("************** TriggerReportCard"@ TriggerToSendWhenDone );

			hud.ShowPopup(class'hudReportCard');
			hudReportCard(hud.curPopup).TriggerOnDeath = TriggerToSendWhenDone;
			hudReportCard(hud.curPopup).lifeSpan = DisplayTime;
		}
*/
		p.TriggerEvent( TriggerToSendWhenDone, none, none); // make sure follow-on trigger is still card, even tho this trigger is now useless

	}
}


//*****************************************************************************

defaultproperties
{
     DisplayTime=5
}
