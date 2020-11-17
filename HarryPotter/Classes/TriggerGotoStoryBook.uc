class TriggerGotoStoryBook extends trigger;


var() name TriggerToSendWhenDone;
var() int  StoryBookIdx;


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
	//local bool       tmp;
	local baseHarry  p;
	//StoryBookIdx
	
	foreach AllActors(class'baseHarry', p)
		break;

	if( p != none )
	{
		Log("************** TriggerGotoStoryBook " $ StoryBookIdx $ " " $ TriggerToSendWhenDone );
		hpconsole(p.player.console).menuBook.DoStoryBookInterlude( StoryBookIdx, TriggerToSendWhenDone );
		//log("sldkjf" $ tmp);
	}
}


//*****************************************************************************

defaultproperties
{
}
