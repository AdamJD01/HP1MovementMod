class CutScene extends baseScript;

enum CUT_COMMAND
{
	CUT_NONE, 

	CUT_GOTO,
	CUT_MOVETO,
	CUT_FACE,
	CUT_TURNTO,

	CUT_ANIMATE,
	CUT_SAY,
	CUT_TEXT,
	CUT_SOUND,

	CUT_CUE,
	CUT_WAITFOR,
	CUT_SLEEP,

	CUT_CAPTURE,
	CUT_RELEASE,
	CUT_CHANGELEVEL,

	CUT_ERROR,
	CUT_TRIGGER,
	CUT_PREFACE,

	CUT_SETIDLE,
	CUT_SETWALK,
	CUT_TALK,
	CUT_CAMRESTORE,
	CUT_CAMSPEED,

	CUT_EMOTE,
	CUT_FADEIN,
	CUT_FADEOUT,

	CUT_CAMPROX,

};


struct CutCast{
	var() actor actorName;
	var() string alias;
	var int nCurAction;
	var float fNextActionTime;
	var bool bWaiting;
	var string strWaitingFor;
	var bool bFinished;
};


struct CutLoc{
	var() actor locName;
	var() string alias;
};

var() bool bPlayOnce;
var() bool bTouchStarts;
var() bool bTriggerStarts;
var() bool bLevelLoadStarts;
var() bool bDelayLevelFadeIn;
var() bool bDebugScript;
var() CutCast Cast[12];
var() CutLoc Locs[40];
var actor preFaceActor;


const MAX_OLD_CUES=60;
var string OldCues[60];	//MAX_OLD_CUES
var int numOldCues;


var() string Cast0Script[40];
var() string Cast1Script[40];
var() string Cast2Script[40];
var() string Cast3Script[40];
var() string Cast4Script[40];
var() string Cast5Script[40];
var() string Cast6Script[40]; 



var bool bPlaying;
var bool bCanPlay;

//var bool bFastForward;
//var float fFastForwardFactor;


struct CastState{
	var CUT_COMMAND lastCommand;
	var string op;
	var string arg;
	var actor lastCommandTarget;
};
var CastState CastStates[7];
var bool bHistoryUpdate;
var int iCurCast;
var int nHistory;

//var string CommandHistory[40*6];
//var string numCommandHistory;

function DebugPrint(string str)
{
//	Log(str);
	PlayerHarry.ClientMessage(str);
}

function UpdateHistory()
{
local string tstr;
local int i;
 
	if(!bHistoryUpdate)
		return;
	bHistoryUpdate=false;
	tstr=string(nHistory) $":";
	nHistory++;
	for(i=0;i<7;i++)
		{
		if(Cast[i].actorName!=None)
			{
			tstr=tstr $CastStates[i].op $" " $CastStates[i].arg $"|";
			}
		}
	DebugPrint(tstr);
}
function string PaddString(string str,int ln)
{
local string tstr;
	tstr=left(str,ln);
	while(len(tstr)<ln)
		tstr=tstr $" ";
	return(tstr);		
}
function RecordCommand(CUT_COMMAND command,string op,string var1)
{
local int i,index;

	if(command==CUT_NONE)
		return;

	CastStates[iCurCast].lastCommand=command;
	CastStates[iCurCast].op=PaddString(left(op,6),6);
	CastStates[iCurCast].arg=PaddString(left(var1,12),12);
	bHistoryUpdate=true;

}

function CutSkip()
{
local int i;
	for(i=0;i<7;i++)
		cast[i].fNextActionTime=0;
}
event PostBeginPlay()
{
	super.postBeginPlay();
	bPlaying=false;
	if(bDelayLevelFadeIn)
		playerHarry.FadeRate = 0;
	if(bLevelLoadStarts)
		StartPlaying();
}


function parseCutLine(string line,out CUT_COMMAND command,out string var1)
{
local int p;
local string op;

	
	line=caps(line);

	p=InStr(line, " ");
	if(p!=-1)
		{
		op=left(line,p);
		var1=right(line,len(line)-(p+1));
		}
	else
		{
		op=line;
		var1="";
		}

//playerHarry.clientMessage("Parse:" $line $"-->"$op $"var1:" $var1);

	switch(op)
		{
		case "":
		case "NONE":
			command=CUT_NONE;
			break;
		case "GOTO":
		case "TELEPORT":
			command=CUT_GOTO;
			break;
		case "MOVETO":
			command=CUT_MOVETO;
			break;
		case "FACE":
			command=CUT_FACE;
			break;
		case "TURNTO":
			command=CUT_TURNTO;
			break;


		case "ANIMATE":
			command=CUT_ANIMATE;
			break;
		case "SAY":
			command=CUT_SAY;
			break;
		case "TEXT":
			command=CUT_TEXT;
			break;
		case "SOUND":
			command=CUT_SOUND;
			break;


		case "CUE":
			command=CUT_CUE;
			break;
		case "WAITFOR":
			command=CUT_WAITFOR;
			break;
		case "SLEEP":
			command=CUT_SLEEP;
			break;

		case "CAPTURE":
			command=CUT_CAPTURE;
			break;
		case "RELEASE":
			command=CUT_RELEASE;
			break;
		case "CHANGELEVEL":
			command=CUT_CHANGELEVEL;
			break;
		case "TRIGGER":
			command=CUT_TRIGGER;
			break;
		case "PREFACE":
			command=CUT_PREFACE;
			break;
		case "SETIDLE":
			command=CUT_SETIDLE;
			break;
		case "SETWALK":
			command=CUT_SETWALK;
			break;
		case "TALK":
		case "TALK0":
		case "TALK1":
		case "TALK2":
		case "TALK3":
		case "TALK4":
		case "TALK5":
		case "TALK6":
			command=CUT_TALK;
			break;
		case "CAMRESTORE":
			command=CUT_CAMRESTORE;
			break;
		case "CAMSPEED":
			command=CUT_CAMSPEED;
			break;
		case "CAMPROX":
			command=CUT_CAMPROX;
			break;
		case "EMOTE":
		case "EMOTE0":
		case "EMOTE1":
		case "EMOTE2":
		case "EMOTE3":
		case "EMOTE4":
		case "EMOTE5":
		case "EMOTE6":
			command=CUT_EMOTE;
			break;
		case "FADEIN":
			command=CUT_FADEIN;
			break;
		case "FADEOUT":
			command=CUT_FADEOUT;
			break;
		default:
			command=CUT_ERROR;
			break;

		}

	if(command!=CUT_NONE)
		RecordCommand(command,op,var1);


}
function actor lookupTarget(string str)
{
local int n;
local int i;
	str=caps(str);

//	playerHarry.clientMessage("Lookuping up target:" $str);

	if(str=="HARRY")
		return(playerHarry);


	for(i=0;i<7;i++)
		{
		//playerHarry.clientMessage("LOOKUP Cast alias:" $str $" " $caps(cast[i].alias) $"__");
		if(caps(cast[i].alias)==str)
			return(cast[i].actorName);
		}

	for(i=0;i<40;i++)
		{
		//playerHarry.clientMessage("LOOKUP Loc alias:" $str $" " $caps(cast[i].alias) $"__");
		if(locs[i].locName!=None)
			if(caps(locs[i].alias)==str)
				return(locs[i].locName);
		}

	if(InStr(str,"CAST")!=-1)
		{
		if(left(str,4)=="CAST")
			{
			n=int(mid(str,4,4));
			//playerHarry.clientMessage("LOOKUP cast:" $str $" " $n);
			if(n<6)
				return(cast[n].actorName);
			}
		}

	if(InStr(str,"LOC")!=-1)
		{
		if(left(str,3)=="LOC")
			{
			n=int(mid(str,3,3));
			//playerHarry.clientMessage("LOOKUP loc:" $str $" " $n);
			if(n<40)
				return(locs[n].locName);
			}
		}


/*
	for(i=0;i<6;i++)
		{
		playerHarry.clientMessage("LOOKUP name:" $str $" " $cast[i].actorName);
		if(caps(cast[i].actorName)==str)
			return(cast[i].actorName);
		}
*/
	playerHarry.clientMessage("Failed to lookup target:" $str);
	return(None);

}

function bool findDelimText(string line,out string text, string startToken, string endToken)
{
local int start,end;

	start=instr(line,startToken);
	if(start<0)
		return false;
	end=instr(line,endToken);
	if(end>0 && end>start)
		{
		text=Mid(line,start+1,(end-start)-1);
		return(true);
		}
	else
		return(false);
}

function handleCamSpeed(out CutCast me,string line)
{
local string dialogID;
local string var1;
local string var2;

	if(baseCam(me.actorName)==None)
		return;	//only works on cameras.


	if(InStr(line," ")<0)
		{
		var1=line;
		baseCam(me.actorName).SetCameraSpeed(float(var1));
		}
	else
		{
		var1=left(line,InStr(line," "));
		var2=mid(line,InStr(line," ")+1);
		baseCam(me.actorName).SetCameraSpeed(float(var1));
		baseCam(me.actorName).SetCameraRotSpeed(float(var2));
		}
//	playerHarry.clientMessage("Parse CamSpeed:" $line $" var1:" $var1 $" var2:" $var2);
//	playerHarry.clientMessage("Speed:" $float(var1) $"Rot:" $float(var2));

//	if(findDelimText(BumpLines[curBumpLine],dialogID,"<",">"))


}
function handleCamProx(out CutCast me,string line)
{
	if(baseCam(me.actorName)==None)
		{
		if(bDebugScript)
			playerHarry.clientMessage("CamProx called on non camera actor");
		return;	//only works on cameras.
		}

	if(bDebugScript)
		playerHarry.clientMessage("Setting CamProx to:" $float(line) );

	baseCam(me.actorName).SetCutCameraProx(float(line));


}
function handleCast(out CutCast me,string line,float fDeltaTime)
{
local rotator newHeading;
local string dlgText;
local sound dlgSound;
local CUT_COMMAND command;
local string var1;
local actor target;
local float delay;
local name tempName;
local actor tempActor;
local int tempNum;
local int i;
local string AutoCue;	//used to build a Cue returned by MoveTo type commands.

	if(me.actorName==None)
		{
		me.bFinished=true;
		return;
		}

		 
	if(me.bWaiting) //if waiting for a cue
		{
		for(i=0;i<numOldCues;i++)	//loop through all old cues to see if it was already issued.
			{
			if(oldCues[i]~=me.strWaitingFor)
				{
				me.bWaiting=false;
				me.strWaitingFor="";
				}
			}
		}

	if(me.bWaiting || me.bFinished)
		return;

		//update time.
	me.fNextActionTime-=fDeltaTime;

	if(me.fNextActionTime>0.0)
		return;

	parseCutLine(line,command,var1);
	if(command==CUT_ERROR)
		{
		playerHarry.clientMessage("CutScene:Error parsing:" $line);
		}

	if(command==CUT_CAMSPEED)
		handleCamSpeed(me,var1);
	else if(command==CUT_CAMPROX)
		handleCamProx(me,var1);

	switch(command)
		{
		case CUT_NONE:
			break;
		case CUT_TRIGGER:
			if(bDebugScript)
				playerHarry.clientMessage("CutTrigger:Event name=" $var1);
			BroadcastTrigger(var1);
			break;
		case CUT_GOTO:
			target=lookupTarget(var1);
			if(target==None)
				playerHarry.clientMessage("CutGoto: Invalid Target" $"->"$var1);

			if(bDebugScript)
				playerHarry.clientMessage("CutGoto:" $me.actorName $"->" $target );
//playerHarry.clientMessage("CutGoto:" $me.actorName $"->" $target.location $"@" $me.actorName.location );
			if(baseCam(me.actorName)!=None)
				{
				if(preFaceActor!=None)
					{
					if(bDebugScript)
						playerHarry.clientMessage("preFaceActor:" $preFaceActor );

					newHeading=rotator(normal(preFaceActor.location-target.location));
					baseCam(me.actorName).DirectionActor=preFaceActor;
					me.actorName.desiredRotation=newHeading;
					me.actorName.setRotation(newHeading);
					preFaceActor=None;
					}
				baseCam(me.actorName).PositionActor=target;
				baseCam(me.actorName).setlocation(target.location);
				}
			else
{
//playerHarry.clientMessage("Here");
				me.actorName.setlocation(target.location);
}
//playerHarry.clientMessage("EndGoto:" $me.actorName $"->" $target.location $"@" $me.actorName.location );
			break;
		case CUT_MOVETO:
			target=lookupTarget(var1);
			if(target==None)
				playerHarry.clientMessage("CutMoveTo: Invalid Target" $me.actorName $"->"$var1);
	
			if(bDebugScript)
				playerHarry.clientMessage("CutMoveTo:" $me.actorName $"->" $target );

				//this is the Cue that will be issued by the MoveTo callbacks.
			AutoCue=string(me.nCurAction) $string(me.actorName);

			if(baseChar(me.actorName)!=None)
				baseChar(me.actorName).CutMoveTo(target,self,AutoCue);
			else if(baseHarry(me.actorName)!=None)
				baseHarry(me.actorName).CutMoveTo(target,self,AutoCue);
			else if(baseCam(me.actorName)!=None)
				{
				baseCam(me.actorName).CutMoveTo(target,self,AutoCue);
				if(preFaceActor!=None)
					{
					baseCam(me.actorName).DirectionActor=preFaceActor;
					preFaceActor=None;
					}
				}
			me.bWaiting=true;
			me.strWaitingFor=AutoCue;
			break;
		case CUT_TURNTO:
			target=lookupTarget(var1);
			if(target==None)
				playerHarry.clientMessage("CutTurnTo: Invalid Target" $me.actorName $"->"$var1);

			if(bDebugScript)
				playerHarry.clientMessage("CutTurnTo:" $me.actorName $"->"$target);
				
				//this is the Cue that will be issued by the TurnTo callbacks.
			AutoCue=string(me.nCurAction) $string(me.actorName);

			if(baseCam(me.actorName)!=None)
				baseCam(me.actorName).DirectionActor=target;
			else if(baseChar(me.actorName)!=None)
				{
				baseChar(me.actorName).CutTurnTo(target,self,AutoCue);
				me.bWaiting=true;
				me.strWaitingFor=AutoCue;
				}
			else if(baseHarry(me.actorName)!=None)
				{
				baseHarry(me.actorName).CutTurnTo(target,self,AutoCue);
				me.bWaiting=true;
				me.strWaitingFor=AutoCue;
				}
			break;
		case CUT_CHANGELEVEL:
			baseConsole(playerHarry.player.console).ChangeLevel(var1,true);
			break;
		case CUT_ANIMATE:
			if(bDebugScript)
				playerHarry.clientMessage("CutAnimate:Animation Name=" $var1);
			tempName=name(var1);
			if(baseChar(me.actorName)!=None)
				baseChar(me.actorName).CutAnimate(name(var1),self,"Ignore");
			else if(baseHarry(me.actorName)!=None)
				baseHarry(me.actorName).CutAnimate(name(var1),self,"Ignore");	
			break;			
		case CUT_SOUND:
			break;
		case CUT_CUE:
			if(bDebugScript)
				playerHarry.clientMessage("CutCue:" $var1);
			CutCue(var1);
			break;

		case CUT_PREFACE:
			if(bDebugScript)
				playerHarry.clientMessage("CutPreFace:" $me.actorName $"->"$var1);
			target=lookupTarget(var1);
			if(target==None)
				playerHarry.clientMessage("CutPreFace: Invalid Target" $me.actorName $"->"$var1);

			if(baseCam(me.actorName)==None)
				playerHarry.clientMessage("CutPreFace ERROR:Actor is not a Camera:" $me.actorName );

			preFaceActor=target;
			break;
			
		case CUT_FACE:
			target=lookupTarget(var1);
			if(target==None)
				playerHarry.clientMessage("CutFace: Invalid Target" $me.actorName $"->"$var1);
		

			if(bDebugScript)
				playerHarry.clientMessage("CutFace:" $me.actorName $"->"$target);
					
			newHeading=rotator(normal(target.location-me.actorName.location));

			if(baseCam(me.actorName)!=None)
				{
				baseCam(me.actorName).DirectionActor=target;
				me.actorName.desiredRotation=newHeading;
				me.actorName.setRotation(newHeading);
				}
			else
				{
				newHeading.pitch=0;
				me.actorName.desiredRotation=newHeading;
				me.actorName.setRotation(newHeading);
				}
			break;
		case CUT_CAPTURE:
			if(bDebugScript)
				playerHarry.clientMessage("CutFreeze:");
			if(baseHarry(me.actorName)!=None)
				{		
				baseHud(playerHarry.myhud).bCutSceneMode=true;
				baseHud(playerHarry.myhud).curCutScene=self;
				playerHarry.CutDoIdle();
				}
			else if(baseCam(me.actorName)!=None)
				{
				baseCam(me.actorName).EnterCutState(None,None);
				}
			else if(baseChar(me.actorName)!=None)
				{		
				baseChar(me.actorName).CutCapture();
				}
			break;
		case CUT_RELEASE:
			if(bDebugScript)
				playerHarry.clientMessage("CutUnFreeze:");
			if(baseHarry(me.actorName)!=None)
				{				
				baseHud(playerHarry.myhud).bCutSceneMode=false;
				baseHud(playerHarry.myhud).curCutScene=None;
				playerHarry.CutRelease();
				}
			else if(baseCam(me.actorName)!=None)
				{
				baseCam(me.actorName).ExitCutState();
				}
			else if(baseChar(me.actorName)!=None)
				{		
				baseChar(me.actorName).CutRelease();
				}
			break;
		case CUT_SAY:
			if(bDebugScript)
				playerHarry.clientMessage("CutSay:" $var1);
			me.fNextActionTime=theNarrator.DeliverDialog(var1);
			break;
		case CUT_TALK:
			if(bDebugScript)
				playerHarry.clientMessage("CutSay:" $var1);

			//playerHarry.clientMessage("Line:" $line);
			//playerHarry.clientMessage("Switch:" $int(mid(line,4,4)));

				//figure out what actor is supposed to talk
			tempNum=asc(mid(line,4,4));
			if(tempNum>=asc("0") && tempNum<=asc("9"))
				tempActor=cast[int(mid(line,4,4))].actorName;
			else
				tempActor=me.actorName;

//			playerHarry.clientMessage("Talk actor is:" $tempActor);

			delay=theNarrator.DeliverDialog(var1);
			if(baseChar(tempActor)!=None)
				baseChar(tempActor).CutDoTalk(delay); 
			me.fNextActionTime=delay;
			break;
		case CUT_EMOTE:
			if(bDebugScript)
				playerHarry.clientMessage("CutEmote:" $var1);

			//playerHarry.clientMessage("Line:" $line);
			//playerHarry.clientMessage("Switch:" $int(mid(line,4,4)));

				//figure out what actor is supposed to talk
			tempNum=asc(mid(line,5,5));
			if(tempNum>=asc("0") && tempNum<=asc("9"))
				tempActor=cast[int(mid(line,5,5))].actorName;
			else
				tempActor=me.actorName;

			//playerHarry.clientMessage("Emote actor is:" $tempActor);
			if(baseChar(tempActor)!=None)
				{
				delay=baseChar(tempActor).DoEmoteLine(line);
				me.fNextActionTime=delay;
				}
			else
				playerHarry.clientMessage("ERROR:Emote on non-baseChar:" $tempActor);
				
			break;
		case CUT_TEXT:
			if(bDebugScript)
				playerHarry.clientMessage("CutText:" $var1);
			playerHarry.ReceiveIconMessage(None,var1,4.0);
			break;
		case CUT_WAITFOR:
			if(bDebugScript)
				playerHarry.clientMessage("Waiting for Cue:" $var1);

			me.bWaiting=true;
			me.strWaitingFor=caps(var1);
			break;
		case CUT_SLEEP:
			if(bDebugScript)
				playerHarry.clientMessage("CutSleep for:" $var1);
			me.fNextActionTime=float(var1);
			break;
		case CUT_SETIDLE:
			if(bDebugScript)
				playerHarry.clientMessage("CutSetIdle:Animation Name=" $var1);
			if(baseChar(me.actorName)!=None)
				baseChar(me.actorName).CutSetIdleAnim(name(var1));
			else 
				playerHarry.clientMessage("Error CutSetIdle:Doesnt work on none BaseChar");
			break;			
		case CUT_SETWALK:
			if(bDebugScript)
				playerHarry.clientMessage("CutSetWalk:Animation Name=" $var1);
			if(baseChar(me.actorName)!=None)
				baseChar(me.actorName).CutSetWalkAnim(name(var1));
			else 
				playerHarry.clientMessage("Error CutSetWalk:Doesnt work on non BaseChars");
			break;			
		case CUT_CAMRESTORE:
			if(bDebugScript)
				playerHarry.clientMessage("CutCamRestore:");
			if(baseCam(me.actorName)!=None)
				baseCam(me.actorName).RestoreStateWithoutPop(true);
			else
				playerHarry.clientMessage("CutCamRestore:Error. Called on non-Camera");
			break;			
		case CUT_FADEIN:
			playerHarry.ClientFadeIn(vec(0,0,0),float(var1));
			break;			
		case CUT_FADEOUT:
			playerHarry.ClientFadeOut(vec(0,0,0),float(var1));
			break;			
		}

	me.nCurAction++;
	if(me.nCurAction>=40)
		{
		me.bFinished=true;
		}

}
function CutCue(string cue)
{
local int i;
	

	cue=caps(cue);

	oldCues[numOldCues++]=cue;	//save cue 
	if(numOldCues>=MAX_OLD_CUES)
		{
		log("$$$$$$$$$$$$$$$$$$$$$$$$$Exceeded MAX_OLD_CUES$$$$$$$$$$$$$$$$$$$$$$$$$");
		PlayerHarry.ClientMessage("$$$$$$$$$$$$$$$$$$$$$$$$$Exceeded MAX_OLD_CUES$$$$$$$$$$$$$$$$$$$$$$$$$");
		PlayerHarry.ClientMessage("$$$$$$$$$$$$$$$$$$$$$$$$$Exceeded MAX_OLD_CUES$$$$$$$$$$$$$$$$$$$$$$$$$");
		PlayerHarry.ClientMessage("$$$$$$$$$$$$$$$$$$$$$$$$$Exceeded MAX_OLD_CUES$$$$$$$$$$$$$$$$$$$$$$$$$");
		}

	for(i=0;i<7;i++)
		{
		if(cast[i].bWaiting)
			{
			if(cast[i].strWaitingFor==cue)
				{

				//playerHarry.clientMessage("Cueing:" $actors[i].actorName $" " $actors[i].strWaitingFor);
				cast[i].bWaiting=false;
				cast[i].strWaitingFor="";
				}
			}
		}
	
}

function runActors(float fDeltaTime)
{
local int i;
local bool bAllFinished;

	bAllFinished=true;

		//there is a reason this isnt done in a loop. Ask Chris if you want to know.

	if(!cast[0].bFinished)
		{
		iCurCast=0;
		handleCast(cast[0],cast0Script[cast[0].nCurAction],fDeltaTime);
		bAllFinished=false;
		}
	if(!cast[1].bFinished)
		{
		iCurCast=1;
		handleCast(cast[1],cast1Script[cast[1].nCurAction],fDeltaTime);
		bAllFinished=false;
		}
	if(!cast[2].bFinished)
		{
		iCurCast=2;
		handleCast(cast[2],cast2Script[cast[2].nCurAction],fDeltaTime);
		bAllFinished=false;
		}
	if(!cast[3].bFinished)
		{
		iCurCast=3;
		handleCast(cast[3],cast3Script[cast[3].nCurAction],fDeltaTime);
		bAllFinished=false;
		}
	if(!cast[4].bFinished)
		{
		iCurCast=4;
		handleCast(cast[4],cast4Script[cast[4].nCurAction],fDeltaTime);
		bAllFinished=false;
		}
	if(!cast[5].bFinished)
		{
		iCurCast=5;
		handleCast(cast[5],cast5Script[cast[5].nCurAction],fDeltaTime);
		bAllFinished=false;
		}
	if(!cast[6].bFinished)
		{
		iCurCast=6;
		handleCast(cast[6],cast6Script[cast[6].nCurAction],fDeltaTime);
		bAllFinished=false;
		}

	if(bAllFinished)
		FinishPlaying();

	UpdateHistory();
}



event Tick(float fDeltaTime)
{
local actor a;
local float duration;

	super.tick(fDeltaTime);
	if(!bPlaying)
		return;

/*		//only fastforward if in cutmode and debugmode
	if(baseHud(playerHarry.myhud).bCutSceneMode && baseConsole(playerHarry.player.console).bDebugMode)
		{
		if(	baseConsole(playerHarry.player.console).bSpacePressed && !bFastForward )
			{
			bFastForward=true;
			playerHarry.SloMo(fFastForwardFactor);
			}
		else if(bFastForward && !baseConsole(playerHarry.player.console).bSpacePressed)
			{
			bFastForward=false;
			playerHarry.SloMo(1.0);
			}
		}
	else if(bFastForward)
		{
		bFastForward=false;
		playerHarry.SloMo(1.0);
		}
*/
//log("T:" $bFastForward $" " $fDeltaTime);


	runActors(fDeltaTime);
		
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

function StartPlaying()
{
local int i;

	if(theNarrator==None)
		foreach AllActors(class'baseNarrator', theNarrator)
			break;

	if(theNarrator==None)
		log("Cant find narrator");
	if(!bPlaying && bCanPlay)
		{
		if(bPlayOnce)
			bCanPlay=false;
		bPlaying=true;
//playerHarry.SloMo(10.0);
		DebugPrint("CutScene start:"$self);
		}
}


function Reset()
{
local int i;

	bCanPlay=true;
	bPlaying=false;
	for(i=0;i<7;i++)
		{
		cast[i].nCurAction=0;
		cast[i].fNextActionTime=0;
		cast[i].bWaiting=false;
		cast[i].strWaitingFor="";
		cast[i].bFinished=false;
		}
	for(i=0;i<MAX_OLD_CUES;i++)
		OldCues[i]="";	//MAX_OLD_CUES
	numOldCues=0;;

	playerHarry.NormalSpeed();
}

function FinishPlaying()
{
	local CutScene  cs;
	local int       i;

	playerHarry.NormalSpeed();
//playerHarry.SloMo(1.0);

	DebugPrint("CutScene finish:"$self);

	bPlaying=false;
	if(!bPlayOnce)
		Reset();

	//if(bDebugScript)
	//{
		ForEach AllActors(class'CutScene', cs)
		{
			if( cs.bPlaying )
			{
				DebugPrint(" CutScene '"$cs$"' still playing");
				cs.ReportRunningCastMembers();
			}
		}
	//}
}

function ReportRunningCastMembers()
{
	local int i;
	
	for( i = 0; i < 7; i++ )
		if( !cast[i].bFinished )
			DebugPrint("  Cast "$i$" not finished.  nCurAction:"$cast[i].nCurAction);
}

defaultproperties
{
     bPlayOnce=True
     bTouchStarts=True
     bTriggerStarts=True
     bCanPlay=True
}
