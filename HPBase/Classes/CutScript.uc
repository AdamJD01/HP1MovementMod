class CutScript expands baseProps;

const MAX_EVENTS=	30;


enum CUT_COMMAND
{
	CUT_NONE, 
	CUT_MOVETO,
	CUT_FACE,
	CUT_ANIMATE,
	CUT_SETSTATE,
	CUT_SAY,
	CUT_SOUND,
	CUT_TELEPORT,
	CUT_CAMERATARGET,
	CUT_CAMERAPOSITION,
	CUT_TRIGGER,
	CUT_WAITFOR,
	CUT_FREEZE,
	CUT_UNFREEZE,
	CUT_SLEEP,

};


struct CutEvent{
	var() actor who;
	var() CUT_COMMAND what;
	var() actor where;
	var() float time;
	var() string var1,var2;
};


var () CutEvent events[30];
var () bool playOnce;
var () bool bTouchStarts;
var () bool bTriggerStarts;
var () bool bDebugScript;

var	int nCurEvent;
var float fNextEventTime;
var bool bPlaying;
var bool bCanPlay;
var bool bWaitForNotify;

var baseCam theCamera;
function processEvent(CutEvent event)
{
local rotator newHeading;
/*
//	playerHarry.clientMessage("HarryState:" $playerHarry.GetStateName());

	switch(event.what)
		{
		case CUT_NONE:
		case CUT_ANIMATE:
		case CUT_SETSTATE:
		case CUT_SOUND:
			break;
		case CUT_CAMERATARGET:
			if(bDebugScript)
				playerHarry.clientMessage("CutCamera:" $event.who $"->"$event.where);
			theCamera.DirectionActor=event.where; 
			theCamera.PositionActor=event.who;
			theCamera.gotostate('CutState');
			break;
		case CUT_CAMERAPOSITION:
			break;
		case CUT_TRIGGER:
			break;
		case CUT_FACE:
			if(bDebugScript)
				playerHarry.clientMessage("CutFace:" $event.who $"->"$event.where);
					
			newHeading=rotator(normal(event.where.location-event.who.location));
			newHeading.pitch=0;
			event.who.desiredRotation=newHeading;
			event.who.setRotation(newHeading);
			break;
		case CUT_FREEZE:
			if(bDebugScript)
				playerHarry.clientMessage("CutFreeze:");
			playerHarry.forceHarryLook(event.where);
			break;
		case CUT_UNFREEZE:
			if(bDebugScript)
				playerHarry.clientMessage("CutUnFreeze:");
			theCamera.gotostate('StandardState');
			playerHarry.freeHarry();
			break;
		case CUT_MOVETO:
			if(bDebugScript)
				playerHarry.clientMessage("CutWalkTo:" $event.who $"->" $event.where );
			if(event.who==None || event.where==None )
				playerHarry.clientMessage("ERROR CutWalkTo:" $event.who $"->" $event.where );
			else
				{
				if(baseHarry(event.who)!=None)	//is it harry we want to move
					playerHarry.CutWalkTo(event.where,self);
				else	
					baseChar(event.who).CutWalkTo(event.where,self);
				}
			break;
		case CUT_TELEPORT:
			if(bDebugScript)
				playerHarry.clientMessage("CutTeleport:" $event.who $"->" $event.where );
			if(event.who==None || event.where==None )
				playerHarry.clientMessage("ERROR CutTeleport:" $event.who $"->" $event.where );
			else
				event.who.setlocation(event.where.location);
			break;
		case CUT_SAY:
			if(bDebugScript)
				playerHarry.clientMessage("CutSay:" $event.var1);
			playerHarry.ReceiveIconMessage(None,event.var1,4.0);
			break;
		case CUT_WAITFOR:
			if(bDebugScript)
				playerHarry.clientMessage("Waiting for Notify:");
			bWaitForNotify=true;
			break;
		case CUT_SLEEP:
			if(bDebugScript)
				playerHarry.clientMessage("CutSleep for:" $event.time);
			fNextEventTime=event.time;
			break;
		}
*/

}


event PostBeginPlay()
{
	super.postBeginPlay();
	bPlaying=false;
	fNextEventTime=0;
	nCurEvent=0;
	bWaitForNotify=false;

		//find the camera for later use.
	foreach allActors(class'baseCam', theCamera)
		break;
}


event Tick(float fDeltaTime)
{
local actor a;
local float duration;

	super.tick(fDeltaTime);
	if(!bPlaying)
		return;
	fNextEventTime-=fDeltaTime;
	if(fNextEventTime<=0.0 && bWaitForNotify==false)
		{
		processEvent(events[nCurEvent]);
		nCurEvent++;
		if(nCurEvent>=MAX_EVENTS)
			{
			FinishPlaying();
			}
		}
		
}

/*
	//if there is a sound put the text up for the duration of the sound plus the textDuration
	if(events[nCurEvent].sound!=None)
		duration+=GetsoundDuration(events[nCurEvent].sound);
	playerHarry.ReceiveIconMessage(None,events[nCurEvent].text,duration);

	//play sound if any
	if(events[nCurEvent].sound!=None)
		PlaySound(events[nCurEvent].sound, SLOT_Interact, 3.2, false, 2000.0, 1.0);

*/

function StartPlaying()
{
	if(!bPlaying && bCanPlay)
		{
		if(playOnce)
			bCanPlay=false;
	
		bPlaying=true;
		fNextEventTime=0;
		nCurEvent=0;
		}
}
function FinishPlaying()
{
	bPlaying=false;
	nCurEvent=0;

//	playerHarry.gotostate('PlayerWalking');
}

function int parseEvent(string event,out string command,out string arg1,out string arg2,out string arg3)
{
local int numItems,i;
local string items[5],ch;

	for(i=0;i<Len(event);i++)
		{
		ch = mid(event, i, 1);
		if(ch==" ")
			{
			numItems++;
			if(numItems>3)
				break;
			}
		else
			items[numItems]=items[numItems] $ch;
		}

	
	command=items[0];
	arg1=items[1];
	arg2=items[2];
	arg3=items[3];

//	playerHarry.clientMessage("Parsed:" $event);
//	playerHarry.clientMessage("Found:" $command $" " $arg1 $" " $arg2 $" " $arg3);

	return(numItems);

}
function baseStation findBaseStation(string name)
{
local baseStation navP;

	foreach allActors(class 'baseStation',navP)
		{
		if(caps(string(navP.Name))==caps(name))
			return(navP);
		}
	return(None);

} 
function CutDest findCutDest(string name)
{
local CutDest navP;

	foreach allActors(class 'CutDest',navP)
		{
		if(caps(string(navP.Name))==caps(name))
			return(navP);
		}
	return(None);

} 
function Pawn findPawn(string name)
{
local Pawn p;

	foreach allActors(class 'Pawn',p)
		{
		if(caps(string(p.Name))==caps(name))
			return(p);
		}
	return(None);

} 
function Notify()
{
	bWaitForNotify=false;
	if(bDebugScript)
		playerHarry.clientMessage("Got notify:");
		
}




event Touch(actor other)
{
local int i;

	if(baseHarry(other)!=None)
		StartPlaying();

}
event Trigger( Actor Other, Pawn EventInstigator )
{
	StartPlaying();
}



/*
freeze
unfreeze

say dialogLine
Sound soundname
text string

anim actor animname
state actor statename

camera actor
cameraTarget Actor

waitTime seconds
waitEvent eventName

trigger eventName
popto <station>


freeze harry0

popto harry HarryCut1Base1
popto fred HarryCut1Base1
popto george HarryCut1Base1

dialog HPDialog.Cut1.Line1
text "This is a text test"
sound HPSounds.harry.hello

state fred patrol
state george patrol
waitEvent doorTrigger

waitTime 3.0

state harry patrol
waitEvent Cut1Done

unfreeze harry0

*/

defaultproperties
{
     playOnce=True
     bTouchStarts=True
     bTriggerStarts=True
     bDebugScript=True
     bCanPlay=True
     bStatic=False
     bHidden=True
}
