class CutScriptII expands baseScript;

const MAX_ACTIONS=40;
const MAX_ACTORS=6;


enum CUT_COMMAND
{
	CUT_NONE, 
	CUT_MOVETO,
	CUT_FACE,
	CUT_ANIMATE,
	CUT_SAY,
	CUT_SOUND,
	CUT_TELEPORT,
	CUT_CUE,
	CUT_WAITFOR,
	CUT_CAPTURE,
	CUT_RELEASE,
	CUT_SLEEP,
	CUT_CHANGELEVEL,
	CUT_TEXT,
	CUT_TRIGGER,
	CUT_TURNTO,	//
	CUT_PREFACE,
};

struct CutAction
{
	var() CUT_COMMAND command;
	var() actor target;
	var() string var1;
};

struct CutActor{
	var int nCurAction;
	var float fNextActionTime;
	var bool bWaiting;
	var string strWaitingFor;
	var bool bFinished;
	var() actor actorName;
	var() CutAction actions[40];
};

var() CutActor actors[6];

var actor preFaceActor;


var () bool playOnce;
var () bool bTouchStarts;
var () bool bTriggerStarts;
var () bool bDebugScript;

var bool bPlaying;
var bool bCanPlay;

var int StaticNumber;

function BeginPlay()
{
//return;	//disable conversion.
	Convert();
}

function string LookupCommandInfo(CUT_COMMAND cmd,out int argType)
{
local string cmdStr;

	switch(cmd)
		{
		case CUT_NONE: 
			cmdStr="";
			argType=0;
			break;
		case CUT_MOVETO:
			cmdStr="MOVETO";
			argType=1;
			break;
		case CUT_FACE:
			cmdStr="FACE";
			argType=1;
			break;
		case CUT_ANIMATE:
			cmdStr="ANIMATE";
			argType=2;
			break;
		case CUT_SAY:
			cmdStr="SAY";
			argType=2;
			break;
		case CUT_SOUND:
			cmdStr="SOUND";
			argType=2;
			break;
		case CUT_TELEPORT:
			cmdStr="TELEPORT";
			argType=1;
			break;
		case CUT_CUE:
			cmdStr="CUE";
			argType=2;
			break;
		case CUT_WAITFOR:
			cmdStr="WAITFOR";
			argType=2;
			break;
		case CUT_CAPTURE:
			cmdStr="CAPTURE";
			argType=0;
			break;
		case CUT_RELEASE:
			cmdStr="RELEASE";
			argType=0;
			break;
		case CUT_SLEEP:
			cmdStr="SLEEP";
			argType=2;
			break;
		case CUT_CHANGELEVEL:
			cmdStr="CHANGELEVEL";
			argType=2;
			break;
		case CUT_TEXT:
			cmdStr="TEXT";
			argType=2;
			break;
		case CUT_TRIGGER:
			cmdStr="TRIGGER";
			argType=2;
			break;
		case CUT_TURNTO:	//
			cmdStr="TURNTO";
			argType=1;
			break;
		case CUT_PREFACE:
			cmdStr="PREFACE";
			argType=1;
			break;
		}
	return(cmdStr);
}
function Convert()
{
local int i,a,b;
local int numLocs;
local string cmdName;
local int argType;
local string tempStr;

	log("Begin Actor Class=CutScene Name=CutScene" $default.staticNumber);
	for(i=0;i<6;i++)
		{
		if(actors[i].actorName!=None)
			{
			tempStr=Mid(actors[i].actorName,InStr(actors[i].actorName,"."));
			log("    Cast(" $i $")=(actorName=" $actors[i].actorName.class $"'MyLevel" $tempStr $"',alias=" $chr(34) $"CastName" $i $chr(34) $")"); 
			}
		}

	numLocs=0;
	for(i=0;i<6;i++)
		{
		if(actors[i].actorName!=None)
			{
			for(a=0;a<40;a++)
				{
				if(actors[i].actions[a].command!=CUT_NONE)
					{
					if(actors[i].actions[a].target!=None)
						{
						tempStr=Mid(actors[i].actions[a].target,InStr(actors[i].actions[a].target,"."));
						log("    Locs(" $numLocs $")=(locName=" $actors[i].actions[a].target.class $"'MyLevel" $tempStr $"',alias=" $chr(34) $"LocName" $numLocs $chr(34) $")"); 
						numLocs++;
						}
					}
				}
			}
		}

	numLocs=0;
	for(i=0;i<6;i++)
		{
		if(actors[i].actorName!=None)
			{
			for(a=0;a<40;a++)
				{
				if(actors[i].actions[a].command!=CUT_NONE)
					{
					cmdName=LookupCommandInfo(actors[i].actions[a].command,argType);
					switch(argType)
						{
						case 0:
							log("    Cast" $i $"Script(" $a $")=" $chr(34) $cmdName $chr(34));
							break;
						case 1:
							log("    Cast" $i $"Script(" $a $")=" $chr(34) $cmdName $" LocName" $numLocs $chr(34));
							break;
						case 2:
							log("    Cast" $i $"Script(" $a $")=" $chr(34) $cmdName $" " $actors[i].actions[a].var1 $chr(34));
							break;
						}
					if(actors[i].actions[a].target!=None)
						{
						numLocs++;
						}
					}
				}
			}
		}

	
//    Level=LevelInfo'MyLevel.LevelInfo0'
    log(" Tag="$Tag);
    log(" Event="$Event);

	log(" bPlayOnce="$playOnce);
	log(" bTouchStarts="$bTouchStarts);
	log(" bTriggerStarts="$bTriggerStarts);
//   Region=(Zone=LevelInfo'MyLevel.LevelInfo0',ZoneNumber=1)
    log(" Location=(X="$Location.x $",Y=" $Location.y $",Z=" $Location.z $")");
    log(" CollisionRadius="$CollisionRadius);
//    Name=CutScene1
	log(" Name=CutScene" $default.staticNumber);
	log("End Actor");

	default.staticNumber++;

}
function CutSkip()
{
local int i;
	for(i=0;i<6;i++)
		actors[i].fNextActionTime=0;
}


function handleActor(out CutActor act,float fDeltaTime)
{
local CutAction action;
local rotator newHeading;
local string dlgText;
local sound dlgSound;
local float delay;
local name tempName;

	if(act.actorName==None)
		return;

	if(act.bWaiting || act.bFinished)
		return;

	act.fNextActionTime-=fDeltaTime;
	if(act.fNextActionTime>0.0)
		return;

	action=act.actions[act.nCurAction];
				
//playerHarry.clientMessage("CutAction:" $act.actorName $" " $act.nCurAction $" " $action.command);
//log("CutAction:" $act.actorName $" " $act.nCurAction $" " $action.command);

	switch(action.command)
		{
		case CUT_NONE:
			break;

		case CUT_TRIGGER:
			if(bDebugScript)
				playerHarry.clientMessage("CutTrigger:Event name=" $action.var1);
			BroadcastTrigger(action.var1);
			break;
		case CUT_CHANGELEVEL:
			baseConsole(playerHarry.player.console).ChangeLevel(action.var1, true );
			break;
		case CUT_ANIMATE:
			if(bDebugScript)
				playerHarry.clientMessage("CutAnimate:Animation Name=" $action.var1);
			tempName=name(action.var1);
			if(baseChar(act.actorName)!=None)
				baseChar(act.actorName).CutAnimate(name(action.var1),self,string(act.actorName));
			else if(baseHarry(act.actorName)!=None)
				baseHarry(act.actorName).CutAnimate(name(action.var1),self,string(act.actorName));	

			//note: No wait until finished.
			break;			
		case CUT_SOUND:
			break;
		case CUT_CUE:
			if(bDebugScript)
				playerHarry.clientMessage("CutCue:" $action.var1);
			CutCue(action.var1);
			break;
		case CUT_TURNTO:
			if(bDebugScript)
				playerHarry.clientMessage("CutTurnTo:" $act.actorName $"->"$action.target);
				
			if(baseCam(act.actorName)!=None)
				baseCam(act.actorName).DirectionActor=action.target;
			break;
		case CUT_PREFACE:
			if(bDebugScript)
				playerHarry.clientMessage("CutPreFace:" $act.actorName $"->"$action.target);
			if(baseCam(act.actorName)==None)
				playerHarry.clientMessage("CutPreFace ERROR:Actor is not a Camera:" $act.actorName );

			preFaceActor=action.target;
			break;
		case CUT_FACE:
			if(bDebugScript)
				playerHarry.clientMessage("CutFace:" $act.actorName $"->"$action.target);
					
			newHeading=rotator(normal(action.target.location-act.actorName.location));

			if(baseCam(act.actorName)!=None)
				{
				baseCam(act.actorName).DirectionActor=action.target;
				act.actorName.desiredRotation=newHeading;
				act.actorName.setRotation(newHeading);
				}
			else
				{
				newHeading.pitch=0;
				act.actorName.desiredRotation=newHeading;
				act.actorName.setRotation(newHeading);
				}
			break;
		case CUT_CAPTURE:
			if(bDebugScript)
				playerHarry.clientMessage("CutFreeze:");
			if(baseHarry(act.actorName)!=None)
				{		
				baseHud(playerHarry.myhud).bCutSceneMode=true;
				baseHud(playerHarry.myhud).curCutScene=self;
				playerHarry.CutDoIdle();
				}
			else if(baseCam(act.actorName)!=None)
				{
				baseCam(act.actorName).PositionActor=None;
				baseCam(act.actorName).DirectionActor=None;
				baseCam(act.actorName).gotostate('CutState');
				}
			break;
		case CUT_RELEASE:
			if(bDebugScript)
				playerHarry.clientMessage("CutUnFreeze:");
			if(baseHarry(act.actorName)!=None)
				{				
				baseHud(playerHarry.myhud).bCutSceneMode=false;
				baseHud(playerHarry.myhud).curCutScene=None;
				playerHarry.CutRelease();
				}
			else if(baseCam(act.actorName)!=None)
				{
				baseCam(act.actorName).PositionActor=None;
				baseCam(act.actorName).DirectionActor=None;
				baseCam(act.actorName).gotostate('StandardState');
				}
			break;
		case CUT_MOVETO:
			if(bDebugScript)
				playerHarry.clientMessage("CutWalkTo:" $act.actorName $"->" $action.target );

			if(baseChar(act.actorName)!=None)
				baseChar(act.actorName).CutMoveTo(action.target,self,string(act.actorName));
			else if(baseHarry(act.actorName)!=None)
				baseHarry(act.actorName).CutMoveTo(action.target,self,string(act.actorName));
			else if(baseCam(act.actorName)!=None)
				baseCam(act.actorName).CutMoveTo(action.target,self,string(act.actorName));

			act.bWaiting=true;
			act.strWaitingFor=string(act.actorName);

			break;
		case CUT_TELEPORT:
			if(bDebugScript)
				playerHarry.clientMessage("CutTeleport:" $act.actorName $"->" $action.target );

			if(baseCam(act.actorName)!=None)
				{
				if(preFaceActor!=None)
					{
					if(bDebugScript)
						playerHarry.clientMessage("preFaceActor:" $preFaceActor );

					newHeading=rotator(normal(preFaceActor.location-action.target.location));
					baseCam(act.actorName).DirectionActor=preFaceActor;
					act.actorName.desiredRotation=newHeading;
					act.actorName.setRotation(newHeading);
					//preFaceActor=None;
					}
				baseCam(act.actorName).PositionActor=action.target;
				baseCam(act.actorName).setlocation(action.target.location);
				}
			else
				act.actorName.setlocation(action.target.location);
			break;
		case CUT_SAY:
/*
			if(bDebugScript)
				playerHarry.clientMessage("CutSay:" $action.var1);

			delay=4.0;	//assume this unless sound overrides.
			if(theDialog!=None)
				{
				if(theDialog.FindDialog(action.var1,dlgSound,dlgText))
					{
					if(dlgSound!=None)
						{
						delay=GetsoundDuration(dlgSound)+0.5;
						playerHarry.clientMessage("Playing Sound: Len:" $delay);
//delay=4.0;
						PlaySound(dlgSound, SLOT_Interact, 3.2, false, 2000.0, 1.0);
						}
					}
				playerHarry.ReceiveIconMessage(None,dlgText,delay);
				}
			else
				playerHarry.ReceiveIconMessage(None,action.var1,delay);
			act.fNextActionTime=delay;
*/
			break;
		case CUT_TEXT:
			if(bDebugScript)
				playerHarry.clientMessage("CutText:" $action.var1);
			playerHarry.ReceiveIconMessage(None,action.var1,4.0);
			break;
		case CUT_WAITFOR:
			if(bDebugScript)
				playerHarry.clientMessage("Waiting for Cue:" $action.var1);
			act.bWaiting=true;
			act.strWaitingFor=action.var1;
			break;
		case CUT_SLEEP:
			if(bDebugScript)
				playerHarry.clientMessage("CutSleep for:" $action.var1);
			act.fNextActionTime=float(action.var1);
			break;
		}

	act.nCurAction++;
	if(act.nCurAction>=40)
		act.bFinished=true;

}
function runActors(float fDeltaTime)
{
local int i;

	for(i=0;i<6;i++)
		handleActor(actors[i],fDeltaTime);

}

function CutCue(string cue)
{
local int i;

	for(i=0;i<6;i++)
		{
		if(actors[i].bWaiting)
			{
			if(caps(actors[i].strWaitingFor)==caps(cue))
				{

				//playerHarry.clientMessage("Cueing:" $actors[i].actorName $" " $actors[i].strWaitingFor);
				actors[i].bWaiting=false;
				actors[i].strWaitingFor="";
				}
			}
		}
	
}


event PostBeginPlay()
{
	super.postBeginPlay();
	bPlaying=false;
}


event Tick(float fDeltaTime)
{
local actor a;
local float duration;

	super.tick(fDeltaTime);
	if(!bPlaying)
		return;
	runActors(fDeltaTime);
		
}


function StartPlaying()
{
	if(!bPlaying && bCanPlay)
		{
		if(playOnce)
			bCanPlay=false;
		bPlaying=true;
		}
}
function FinishPlaying()
{
	bPlaying=false;
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



event Touch(actor other)
{
local int i;

	if(bTouchStarts)
		{
		if(baseHarry(other)!=None)
			StartPlaying();
		}
}
event Trigger( Actor Other, Pawn EventInstigator )
{
	if(bTriggerStarts)
		{
		StartPlaying();
		}
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


/*
Harry
	freeze
	Popto CutDest0
	Face George
	Cue StartTalking
	waitfor HarryFollowMe
	Moveto Cutdest1		//auto adds waitfor <generated trigger>
	Moveto CutDest2
	Moveto CutDest3
	unfreeze

George
	waitfor StartTalking
	Say Blah				//auto adds waitfor <generated trigger>
	Say blah
	Moveto Cutdest1
	Animate OpenStatue		//auto adds waitfor <generated trigger>
	Cue FredFollowMe
	Moveto CutDest2
	Moveto CutDest3

Fred 
	waitfor FredFollowMe
	Moveto Cutdest1
	Cue HarryFollowMe
	Moveto CutDest2
	Moveto CutDest3
	Face harry0


Harry
	Freeze
	Cue RonEntrance
	Popto CutDest0
	Face ron
	waitfor RonLeaves
	unfreeze

Ron 
	waitfor RonEntrance
	moveto cutDest1
	face harry
	say Its me!
	say Follow Me.
	Cue RonLeaves
	MoveTo CutDest2
	MoveTo CutDest3
	MoveTo CutDest4
	
*/

defaultproperties
{
     playOnce=True
     bTouchStarts=True
     bTriggerStarts=True
     bDebugScript=True
     bCanPlay=True
     StaticNumber=50
}
