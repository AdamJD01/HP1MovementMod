class baseChar expands Pawn;


	var actor realgoal;
	var actor start;
	var actor end;
	var NavigationPoint navP, tempNavP, LastNavP;
	var baseStation destP;
	var baseHarry p;		// pointer to harry
	var actor next;
	var float dis;
	var (patrol) name stationDestination;
	var (patrol) int stationNumber;
	var (patrol) name pathType;
	var (patrol) name firstPath;
	var (patrol) bool bLoopPath;
	var (patrol) float fNavPointColRadius;
	var (patrol) bool bIgnoreStationRotations;

	var (PatrolPoints) bool  bFollowPatrolPoints;
	//var (PatrolPoints) bool bAutoMoveToNextClosestPoint;
	var (PatrolPoints) name  firstPatrolPointTag;
	var (PatrolPoints) name  firstPatrolPointObjectName;
	var (PatrolPoints) bool  bUseFraySplines;
	var                bool  bUseFrayMoveTo;
	var                name  PatrolPointLinkTag;

	var                bool   bMoveRequest; //Ooof
	var                vector vMoveRequest; //Yet another bastardized variable.  My spline move code sets this to how much it would like the char to move.  Tick then moves it.
	var                vector vLastLocation;//Oof, ouch, oh god.

	var                float LastLevelTime;//saves the last Level.TimeSeconds
	var                float fTimeOnPath;  // 0 to 1
	var                bool bGoBackToLastNavPoint; //If this is on, you'll go back to LastNavP, then turn around and continue normally.
	var                PatrolPoint LastPatrolPoint;  //For automove, dont go back to the last point you were at.

	var(Sounds) sound	Footstep1;

	var(Sounds) sound speech[20];

	var int status;
	var vector forcelocation;
	var vector forcedir;


var class<Decal> ShadowClass;
var (SpellEffects) bool bCanLevitate;
var (SpellEffects) float levHeight;
var bool bIsLevitating;
var float levDestZ;

var (SpellEffects) bool bCanTransform;
var (SpellEffects) class<Actor> transformInto;
var bool hasTransformed;

var (SpellEffects) class<Actor> classRepairInto;
var (SpellEffects) class<ParticleFX> classRepairParticalFX;

var (SpellEffects) bool bFlintTarget;
var (SpellEffects) bool bAvifTarget;
var (SpellEffects) bool bVerdTarget;
var (SpellEffects) bool bAlohoTarget;
var (SpellEffects) bool bFlipTarget;
//var                bool bIsFlipped;
var (SpellEffects) bool bRepairoTarget;

var (SpellEffects) bool bSpellCausesTrigger;

var                bool bDoesntDestroySpell; //MirrorInnerBoxObj has this set, so that spellVoldemortStraight doesn't explode when it hits it.

var Actor CutWalkDest;
var Actor CutTurnDest;
var rotator CutSaveHeading;
var name CutAnimName;
var baseScript CutNotifyScript;
var string CutCueString;
var name CutSaveState;

var (CutScene) bool bCutFlying;
var (CutScene) name CutWalkAnim;
var (CutScene) name CutIdleAnim;
var (CutScene) name CutTalkAnim;
var (CutScene) name CutTalkStartAnim;
var (CutScene) name CutTalkEndAnim;
var float CutStopTalkingTime;
var float CutMoveToTimeout;
var bool bCutArrived;


struct Emote
{
	var() string EmoteName;
	var() name StartAnim;
	var() name LoopAnim;
	var() name StopAnim;
};

const MAX_EMOTES = 6;
var(Emotes) Emote Emotes[6];	//MAX_EMOTES
var bool bEmoting;
var Emote curEmote;
var float fEmoteFinishTime;
var name EmoteSaveState;

const MAX_BUMPLINES=6;
var (BumpLines) bool bUseBumpLine;
var (BumpLines) bool bRandomBumpLine;
var (BumpLines) bool bCaptureHarry;
var (BumpLines) string BumpLines[6];//MAX_BUMPLINES
var int curBumpLine;
var float fNextBumplineTime;


// information kiosks variables

var (inform) bool doesInform;

var enum EautoInform
{
	AI_autoNone,
	AI_auto1,
	AI_auto2,
	AI_auto3,
	AI_auto4,
	AI_auto5
}autoInform;
var int lastInform;
var bool wasInformed;
var struct tagInformData
{
	var() sound informSpeech;
	var()  eautoInform speechNumber ;
}informData;
var (inform) tagInformData information[5];
var (inform) name talkAnimName;
var float speechTime;

var(patrol) name walkAnimName;
var(patrol) name idleAnimName;

var baseHarry playerHarry;
var basecam cam;

var bool	bGestureOnTargeting;


state SafeIdle
{
	
}


function PreBeginPlay()
{
local int count;

	Super.PreBeginPlay();

	foreach AllActors(class'baseharry', playerHarry)
		{
		if( playerHarry.bIsPlayer&& playerHarry!=Self)
			{
				break;
			}
		}

	foreach allActors(class'BaseCam', cam)
		break;


	foreach allActors(class'BaseCam', cam)
		break;

		//if no cut anims defined pull them from
		//the patrol ones.
		//or set to a default
	if(CutIdleAnim=='')
		{
		if(idleAnimName!='')
			CutIdleAnim=idleAnimName;
		else
			CutIdleAnim='Breath';
		}
	if(CutWalkAnim=='')
		{
		if(walkAnimName!='')
			CutWalkAnim=walkAnimName;
		else
			CutWalkAnim='Walk';
		}
		


	if(bCanTransform)
	{
		eVulnerableToSpell = SPELL_Transfiguration;
	}

	if( ShadowClass != none )
		Shadow = Spawn(ShadowClass,self);
}


	function startup()
	{
	
		foreach allActors(class'baseHarry', p)
		{
			if( p.bIsPlayer&& p!=Self)
			{
		
				break;
			}
		}

		foreach allActors(class 'navigationPoint',navP)
		{
			destP=baseStation(navP);
			if(destP!=None && destP.Name==stationDestination)
			{
				break;
			}
		}
		foreach allActors(class 'navigationPoint',navP)
		{

			if(navp.Name==firstPath)
			{
				
				break;
			}
		}

		

	}

//***********************************************************************************************************
function tick (float deltatime)
{
	impartinformation();
	fNextBumplineTime-=deltaTime;

}

//***********************************************************************************************************
//baseHarry calls this, if he's fighting a boss
function HarryWasHurt( bool bHarryWasKilled )
{
}

//***********************************************************************************************************
simulated function PlayFootStep()
{
	local sound step;
	local float decision;

	local Texture HitTexture;
	local int Flags;
	local sound Footstep1;
	local sound Footstep2;
	local sound Footstep3;

	if ( FootRegion.Zone.bWaterZone )
	{
		PlaySound(WaterStep, SLOT_Interact, 1, false, 1000.0, 1.0);
		return;
	}

	HitTexture = TraceTexture(Location + (vect(0,0,-128)), Location, Flags );

	Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_stone1';
	Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_stone2';
	Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_stone3';

	switch( HitTexture.FootstepSound )
	{
		case FOOTSTEP_Wood:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_wood1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_wood2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_wood3';
			break;

		case FOOTSTEP_Rug:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_rug1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_rug2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_rug3';
			break;

		case FOOTSTEP_Stone:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_stone1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_stone2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_stone3';
			break;

		case FOOTSTEP_cave:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_cave1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_cave2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_cave3';
			break;

		case FOOTSTEP_cloud:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_cloud1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_cloud2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_cloud3';
			break;

		case FOOTSTEP_wet:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_wet1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_wet2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_wet3';
			break;

		case FOOTSTEP_grass:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_grass1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_grass2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_grass3';  //bad sound
			break;

		case FOOTSTEP_metal:
			Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_metal1';
			Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_metal2';
			Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_metal3';
			break;
	}

	decision = FRand();
	if ( decision < 0.34 )
		step = Footstep1;
	else if (decision < 0.67 )
		step = Footstep2;
	else
		step = Footstep3;

	PlaySound(step, SLOT_Interact,RandRange(0.7, 1.0), false, 1000.0, RandRange(0.9, 1.1));
}

//*************************************************************************************************************************
function TriggerSpecial(actor Other, int Info)
{
}

//*************************************************************************************************************************
function impartInformation()
{
	local int count;

	//if( bFollowPatrolPoints )
	//	return;

	if(doesInform&&lastInform<6&&!bhidden)
	{
		if(!wasInformed)
		{
			if(vsize(location-(p.location))<100)
			{
				lastInform=lastInform+1;
				count=0;
				
				while(count<5)
				{
					if(information[count].speechNumber==lastInform)
					{
						playSound(information[count].informSpeech);
						speechTime=GetsoundDuration(information[count].informSpeech);
						loopanim(talkAnimName);
						wasInformed=true;
						break;
					}
					count++;
				}
			}
		}
		else
		{
			if(vsize(location-(p.location))>1000)
			{
				wasInformed=false;
				p.clientMessage("cleared informed");
			}
		}
	}

}

// Return the health of the char
// range 0 to 1.0
function float GetHealth()
{
	return 1.0;
}


//Fluffy's probably the only one that will need to use this
function float GetSpecialHealth(int iVar, out int iOutVar)
{
	return 1.0;
}

function respondToStation()
{
}

function setBaseStation(baseStation s)
{
	stationDestination=s.aiData[0].stationDestination;
	pathType=s.aiData[0].pathType;
	firstPath=s.aiData[0].firstPath;
	stationNumber=0;
}

state atStation
{
	begin:

	if( !bIgnoreStationRotations )
	{
		SetPhysics(PHYS_Rotating);
		desiredRotation=(destP.rotation);
	}

	respondToStation();

	if( destP.aiData[stationNumber].pauseTime > 0 )
		sleep(destP.aiData[stationNumber].pauseTime);
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
	stationNumber=destP.aiData[stationNumber].nextStationGroup;
	gotostate('patrol');
}

// patrol state moves the characters around a path described by hpath and basestations

// Or, if bFollowPatrolPoints in PatrolPoints is true, follows path of patrol points.

auto state patrol
{
	function startup()
	{
		foreach allActors(class'baseHarry', p)
			if( p.bIsPlayer&& p!=Self)
				break;

		if( bFollowPatrolPoints )
		{
			//Only look for first patrol tag if navP isn't set.  This lets you go to another state, and then back here
			// again without starting the path over again.
			if( navP == none )
			{
				if( firstPatrolPointTag != '' )
				{
					foreach allActors(class 'navigationPoint',navP,firstPatrolPointTag)
						break;
				}
				else
				{
					foreach allActors(class 'navigationPoint',navP)
						if( navP.name == firstPatrolPointObjectName )
							break;
				}

				PatrolPointLinkTag = PatrolPoint(navP).PatrolPointLinkTag;
				LastNavP = navP;
			}
		}
		else
		{
			if(stationDestination!='')
			{
				foreach allActors(class 'navigationPoint',navP)
				{
					destP=baseStation(navP);

					if(destP!=None && destP.Name==stationDestination)
						break;
				}
			}

			if(firstPath!='')
			{
				foreach allActors(class 'navigationPoint',navP)
					if(navp.Name==firstPath)
						break;
			}
		}
	}

	function EndState()
	{
		LastLevelTime = 0;
		bMoveRequest = false;
	}

	function Tick(float dtime)
	{
		Global.Tick(dtime);

		//If bMoveRequest is true, Do a move smooth the amount set in vMoveRequest.  No one should be using this except my bastardized spline stuff.
		if( bMoveRequest )
		{
			bMoveRequest = false;
			vLastLocation = Location;
			MoveSmooth( vMoveRequest );
		}
	}

  Begin:
	enable( 'Tick' );
	SetPhysics(PHYS_Walking);
	startup();
	//playerHarry.clientMessage(self $" starting patrol");

	if( !bFollowPatrolPoints  &&  firstPath == '' )
		goto 'idleloop';

	patrolPlayWalkAnim();

  moveLoop:
	
	if( !bFollowPatrolPoints )
		next = findPath(navP,stationDestination);

	/*	if(next==none)
			goto 'idleloop';	*/

	if( bFollowPatrolPoints && bUseFraySplines && !bGoBackToLastNavPoint && PatrolPoint(navP).bHasSplineInfo )
	{
		while( !MoveTo_FraySpline() )
			sleep(0.005);
	}
	else //normal
	{
		do
		{
			//If bGoBackToLastNavPoint is set, set navp to LastNavP
			if( bFollowPatrolPoints && bGoBackToLastNavPoint )
			{
				navP = LastNavP;
				bGoBackToLastNavPoint = false;
			}

			if( bFollowPatrolPoints && bUseFrayMoveTo )
			{
				while( !MoveTo_Fray() )
					sleep(0.005);
			}
			else
			{
				moveTo(navP.location);
			}

			sleep(0.005);
		}until( vsize(location-navP.location) < fNavPointColRadius );
	}

	impartinformation();

	if( bFollowPatrolPoints )
		_PawnAtPatrolPoint( PatrolPoint(navP) );
	else
	if( destp==navP )
		PawnAtStation();

	if( bFollowPatrolPoints )
	{
		tempNavP = navP;

		if( PatrolPoint(navP).NextPatrolPoint == none )
			navP = FindClosestPatrolPoint( LastNavP, navP );  //Find closest, excluding Last one you were at, and the one you're currently at.
		else
			navP = PatrolPoint(navP).NextPatrolPoint;

		LastNavP = tempNavP;

		_PostPawnAtPatrolPoint( PatrolPoint(LastNavP), PatrolPoint(navP) );
	}
	else
	{
		navP=navigationPoint(next);
	}

	if(navP==none)
	{
	  idleLoop:
		while( true )
		{
			loopAnim(idleAnimName);
			impartinformation();
			sleep(speechTime);
			speechTime=0;
			sleep(0.5);

			//If loop path, just start the whole patrol process over again by setting navp to firstPath.
			if( bLoopPath )
			{
				if( bFollowPatrolPoints )
				{
					if( firstPatrolPointTag != '' )
					{
						foreach allActors(class 'navigationPoint',navP,firstPatrolPointTag)
							break;
					}
					else
					{
						foreach allActors(class 'navigationPoint',navP)
							if( navP.name == firstPatrolPointObjectName )
								break;
					}
				}
				else
				{
					foreach allActors(class 'navigationPoint',navP)
						if(navp.Name==firstPath)
							break;
				}

				break; //break the while loop
			}

			//goto 'idleloop';
		}
	}

	
	next=none;
	
	goto 'moveLoop';
}

//*******************************************************************************************************
state statePatrolPointPause
{
  Begin:
	LoopAnim( PatrolPoint(LastNavP).PauseAnim, 1.0, 0.5 );

	//Actually, use the character's location so that it will always point the same direction.  (the char may not be standing on the patrolpoint)
	if( PatrolPoint(LastNavP).bUseLookDir )
		TurnTo( /*PatrolPoint(LastNavP).*/Location + PatrolPoint(LastNavP).lookdir );

	sleep( PatrolPoint(LastNavP).pauseTime );
	GotoState( 'patrol' );
}

//*******************************************************************************************************
// Try to move to navP, using my fancy new patented "frayspline"
function bool MoveTo_FraySpline()
{
	local float dtime;
	local float d, speed2, fScale;
	local float t;
	local float NewTimeOnPath;

	//local vector vLastNavPoint, vOut;
	local vector v, v1, v2, vMove;
	local PatrolPoint p;

	//All right, my fault.  Any problems with this, and it needs to be changed so it uses tick().
	if( LastLevelTime == 0 )
		LastLevelTime = Level.TimeSeconds;

	dtime = Level.TimeSeconds - LastLevelTime;
	LastLevelTime = Level.TimeSeconds;

	dtime = fmin( dtime, 0.1 );  //10 frame a second max

	//Find what percent we need to move along
	d = GroundSpeed * dtime;
	t = d / PatrolPoint(navP).GetTanLenIn(); //t is set to how much percent we want to advance so we move the distance we require ( d )
	NewTimeOnPath = fTimeOnPath + t;

	if( NewTimeOnPath > 1 )
		NewTimeOnPath = 1;

	//Do a movesmooth towards the current loc
	v2 = navP.Location + (PatrolPoint(navP).vFraySplineTangent * -PatrolPoint(navP).GetTanLenIn() * (1-NewTimeOnPath));
	p = PatrolPoint(navP).PrevPatrolPoint;
	v1 = p.Location    + p.vFraySplineTangent * p.GetTanLenOut() * NewTimeOnPath;
	v = v1 + (v2-v1) * EaseBetween(NewTimeOnPath);

	vMove = v - Location;  //this is how much we'd like to move
	vMove.z = 0;

	//vMove = normal(vMove) * GroundSpeed * dtime;

	//Scale it back, based on our ground speed
	speed2 = VSize(vMove) / dtime;
	//playerHarry.ClientMessage("********* speed2="$speed2$" z="$vMove.z/dtime$"  dtime="$dtime);
	if( speed2 > GroundSpeed*1.5 )
		vMove *= GroundSpeed*1.5 / speed2;

	//MoveSmooth( vMove );

	//You'll want to rotate to what the last vMoveRequest was, since that's how much we actually moved.
	//One thing could try here, set DesiredRotation to rotator( Location-vLastLocation ).  Cause that's pointing the direction you actually moved, instead of the direction you requested to move.
	//DesiredRotation = rotator( vMoveRequest * vect(1,1,0) );//SetRotation( rotator(vMove) );
	v1 = Location-vLastLocation;
	if( v1.x != 0 || v1.y != 0 )
		DesiredRotation = rotator( v1 * vect(1,1,0) );

	fTimeOnPath = NewTimeOnPath;

	//Ah, even more bastardization, of everything that is sacred!  Set bMoveRequest to true, and Tick will move the char vMoveRequest.
	bMoveRequest = true;
	vMoveRequest = vMove;

	//playerHarry.ClientMessage("********* vsize2d(Location - navP.Location)="$vsize2d(Location - navP.Location));
	if( vsize2d(Location - navP.Location) < 1 )
	{
		fTimeOnPath = 0;
		LastLevelTime = 0;
		return true;
	}
	else
	{
		return false;
	}
}

//*******************************************************************************************************
function bool MoveTo_Fray()
{
	local float dtime;
	local float d, speed2, fScale;
	local float t;

	//local vector vLastNavPoint, vOut;
	local vector v, v1, v2, vMove;
	local PatrolPoint p;

	//All right, my fault.  Any problems with this, and it needs to be changed so it uses tick().
	if( LastLevelTime == 0 )
		LastLevelTime = Level.TimeSeconds;

	dtime = Level.TimeSeconds - LastLevelTime;
	LastLevelTime = Level.TimeSeconds;

	dtime = fmin( dtime, 0.1 );  //10 frame a second max

	//Find what percent we need to move along
	d = GroundSpeed * dtime;

	//Do a movesmooth towards the current loc
	vMove = normal( (navP.Location - Location) * vect(1,1,0) ) * d;

	//"Save" our location.  Actually, it was saved in Tick, before the MoveSmooth.
	v = vLastLocation;

	//MoveSmooth( vMove );

	//One thing could try here, set DesiredRotation to rotator( Location-vLastLocation ).  Cause that's pointing the direction you actually moved, instead of the direction you requested to move.
	//DesiredRotation = rotator( vMoveRequest * vect(1,1,0) );//SetRotation( rotator(vMove) );
	v1 = (Location-vLastLocation);
	if( v1.x != 0 || v1.y != 0 )
		DesiredRotation = rotator( v1 * vect(1,1,0) );

	//Ah, even more bastardization, of everything that is sacred!  Set bMoveRequest to true, and Tick will move the char vMoveRequest.
	bMoveRequest = true;
	vMoveRequest = vMove;

	//playerHarry.ClientMessage("********* vsize2d(Location - navP.Location)="$vsize2d(Location - navP.Location));
	//You're there, if you crossed the point
	//if( vsize2d(Location - navP.Location) < 1 )
	v1 = navP.Location -        v;
	v2 = navP.Location - Location;
	v1.z = 0;  //hee hee, if you dont set z to zero and the nav point is off the floor, the vectors point more up than out, so the dot is always positive.
	v2.z = 0;
	t = v1 dot v2;

	if( t <= 0 )
	{
		LastLevelTime = 0;
		return true;
	}
	else
	{
		return false;
	}
}

//*************************************************************************************************************************
//This function should be in object.uc
function float EaseBetween(float t)
{
	if( t <= 0 )
		return 0;
	else
	if( t < 0.5 )
		return 2.0*t*t;
	else
	if( t < 1.0 )
		return 1.0 - 2.0*(1.0-t)*(1.0-t);
	else
		return 1.0;
}

//*******************************************************************************************************
//You can override this, if you're cool.
function patrolPlayWalkAnim()
{
	loopAnim(walkAnimName);
}

//*******************************************************************************************************
//Dont consider ExclusionActor in the check
function PatrolPoint FindClosestPatrolPoint( actor ExclusionActor1, actor ExclusionActor2 )
{
	local PatrolPoint     tempPatrolPoint;
	local float           fDist, fClosestDist;
	local PatrolPoint     ClosestActor;

	fClosestDist = 100000;

	//Hope this isn't too slow doing this...

	foreach AllActors(class'PatrolPoint', tempPatrolPoint)
	{
		//If PatrolPointLinkTag is set, only use tempPatrolPoints that have the same name
		if( PatrolPointLinkTag != ''  &&  PatrolPointLinkTag != tempPatrolPoint.PatrolPointLinkTag )
			continue;

		fDist = VSize( Location - tempPatrolPoint.Location );

		if(   tempPatrolPoint != ExclusionActor1
		   && tempPatrolPoint != ExclusionActor2
		   && fDist < fClosestDist
		  )
		{
			fClosestDist = fDist;
			ClosestActor = tempPatrolPoint;
		}
	}

	return ClosestActor;
}

//*******************************************************************************************************
//Override this so you can do your own at station stuff
function PawnAtStation()
{
	gotostate('atstation');
}

//*******************************************************************************************************
function _PawnAtPatrolPoint(PatrolPoint pp)
{
	PawnAtPatrolPoint(pp);

	if( pp.EventToSend != '' )
		TriggerEvent( pp.EventToSend, none, self );
}

function PawnAtPatrolPoint(PatrolPoint pp)
{
}

//*******************************************************************************************************
//Here, navP (passed in as NextP) has already been set to the next one you're going to
function _PostPawnAtPatrolPoint(PatrolPoint CurrentP, PatrolPoint NextP)
{
	PostPawnAtPatrolPoint(CurrentP, NextP);

	if( CurrentP.bDestroyPawn )
		Destroy();

	if( CurrentP.bStopBossEncounter )
		StopBossEncounter();

	if( CurrentP.pauseTime > 0 )	
		GotoState('statePatrolPointPause');
}

function PostPawnAtPatrolPoint(PatrolPoint CurrentP, PatrolPoint NextP)
{
}

//*******************************************************************************************************
function StopBossEncounter()
{
	playerHarry.StopBossEncounter();
}

//*******************************************************************************************************
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

//*******************************************************************************************************
event Bump(actor other)
{
	super.bump(other);

	if(!bUseBumpLine)
		return;

	if(bEmoting)
		return;	//already doing something.

	if(baseHarry(other)==None)
		return;

	if(baseHud(playerHarry.myHud).bCutSceneMode)	//cant play while in a cutscene
		return;
//playerHarry.clientMessage("Bumplinetime:"$fNextBumpLineTime);

	baseHarry(other).WaitingCount=-2;	//supress harrys idle animation for a bit.


		//wait for last bumpline to finish.
	if(fNextBumpLineTime>0)
		return;
	if(bRandomBumpLine)
		{
		curBumpLine=rand(6);
		while(bumpLines[curBumpLine]=="" && curBumpLine>0)
			curBumpLine--;
		}
	else
		{
		curBumpLine++;
		while(bumpLines[curBumpLine]=="" && curBumpLine!=0)
			curBumpLine=(curBumpLine+1)%MAX_BUMPLINES;
		}

	if(BumpLines[curBumpLine]!="")
		fNextBumpLineTime=DoEmoteLine(BumpLines[curBumpLine]);
}

//*******************************************************************************************************
function float DoEmoteLine(string line)
{
local float duration;
local string emoteName;
local string triggerName;
local string dialogID;

	if(bEmoting==true)
		return(0);

	duration=2.0;	
	if(findDelimText(line,dialogID,"<",">"))
		{
		playerHarry.clientMessage("Delivering dialog:" $dialogID);
		duration=playerHarry.theNarrator.DeliverDialog(dialogID);
		}

	if(findDelimText(line,emoteName,"(",")"))
		DoEmote(emoteName,duration);

	if(findDelimText(line,triggerName,"[","]"))
		TriggerEvent(name(triggerName),self,self);

	playerHarry.clientMessage("Did EmoteLine. Text:" $dialogID $" Emote:" $emoteName);

	duration+=0.75;	//a little slop factor to make sure emote animation has enough time to finish.
	return(duration);
}

//*******************************************************************************************************
function bool FindDialog(string dialogID,out sound dlgSound,out string dlgText)
{
	return playerHarry.theNarrator.FindDialog(dialogID, dlgSound, dlgText);
}

//******* ******* ******* ******* ******* ******* ******* ******* ******* ******* ******* ******* ******* 
function bool FindEmote(string dialogID,out sound dlgSound)
{
	return playerHarry.theNarrator.FindEmote(dialogID, dlgSound);
}

//*******************************************************************************************************
function DoEmote(string name,float duration)
{
local int i;
		
	if(name~="none" || name=="")
		return; //early exit.

	if(bEmoting==true)
		return;

	for(i=0;i<MAX_EMOTES;i++)
		{
		if(emotes[i].EmoteName~=name)
			{
			EmoteSaveState=GetStateName();
			curEmote=emotes[i];
			break;
			}
		}
	bEmoting=true;
	fEmoteFinishTime=duration;
	gotoState('Emoting');

}

//*******************************************************************************************************
state Emoting
{
	function BeginState()
	{
		disable('Bump');
	}

	event tick(float fDeltaTime)
		{
		Global.Tick(fDeltaTime);
		fEmoteFinishTime-=fDeltaTime;
		}

Begin:
	disable('Bump');
	enable( 'Tick' );

	SetPhysics(PHYS_ROTATING);
	CutSaveHeading=rotation;
	rotationRate.pitch=0;

	if( curEmote.StartAnim!='')
		{
		playAnim(curEmote.StartAnim);

		TurnTo(playerHarry.location);
		finishAnim();
		}

	if(curEmote.LoopAnim!='')
		{
		TurnTo(playerHarry.location);
		loopAnim(curEmote.LoopAnim);
		}

	while(fEmoteFinishTime>0)
		{
		sleep(0.2);
		}
	bEmoting=false;

	if(curEmote.StopAnim!='')
		{
		playAnim(curEmote.StopAnim);
		TurnTo(playerHarry.location);
		finishAnim();
		}

	desiredRotation=CutSaveHeading;

	enable('Bump');
	gotostate(EmoteSaveState);
}
function CutCapture()
{
	CutSaveState=GetStateName();

}
function CutRelease()
{
	gotostate(CutSaveState);
}
state CutIdle
{

Begin:
	loopAnim(CutIdleAnim);
}
function CutDoTalk(float delay)
{
//	CutSaveState=GetStateName();

	CutStopTalkingTime=delay;

	gotostate('CutTalking');
}

state CutTalking
{
	event tick(float fDeltaTime)
		{
		Global.Tick(fDeltaTime);
		CutStopTalkingTime-=fDeltaTime;
		}
Begin:
	enable( 'Tick' );
	playAnim(CutTalkStartAnim);
	finishAnim();
	loopAnim(CutTalkAnim);
	while(CutStopTalkingTime>0)
		{
		sleep(0.2);
		}
	playAnim(CutTalkEndAnim);
	finishAnim();

//playerHarry.clientMessage(self $"Doing IDLE:" $CutIdleAnim);

	loopAnim(CutIdleAnim);
	gotostate('CutIdle');
}

function CutMoveTo(actor dest,baseScript script,string cue)
{
	CutWalkDest=dest;
	CutNotifyScript=script;
	CutCueString=cue;
//	CutSaveState=GetStateName();
		//this is an error.
	if(dest==None)
		{
			//send this back to avoid a hang in the script.
		CutNotifyScript.CutCue(CutCueString);

		CutCueString="";
		CutNotifyScript=None;
		return;
		}
	SetupMoveTo(dest);
	gotostate('CutMovingTo');
}

function SetupMoveTo(actor actorDest)
{
local vector curLoc;
local vector dest;

	CutWalkDest=actorDest;

	curLoc=location;
	dest=CutWalkDest.location;
	dest.z=curLoc.z;

	CutMoveToTimeout=vsize(dest-curLoc)/GroundSpeed;
	CutMoveToTimeout+=1.0;	//slop

//PlayerHarry.ClientMessage(self $" SetupMoveTo:Dist:" $vsize(dest-curLoc) $" Estimated Time:"$CutMoveToTimeout);
	bCutArrived=false;
}


state CutMovingTo
{
	event tick(float fDeltaTime)
		{
		local vector heading;
		local vector delta;
		local vector curLoc;
		local vector dest;
		
		Global.Tick(fDeltaTime);

		if(bCutArrived)
			return;
			//calc new heading

		curLoc=location;
		dest=CutWalkDest.location;
		dest.z=curLoc.z;

		heading=normal(dest-curLoc);

			//set char rotation
		desiredRotation=rotator(heading);
		desiredRotation.pitch=0;

			//calc position change
		delta=(heading*GroundSpeed)*fDeltaTime;
		delta.z+=0.1; //slight up angle to assist climbing stairs.

//PlayerHarry.ClientMessage(self $" Dist:" $vsize(dest-curLoc) $" Delta:" $vsize(delta) $" Time:"$CutMoveToTimeout);

			//apply movement delta
		if(vsize(delta) < vsize(dest-curLoc) )
			{
			MoveSmooth(vect(0,0,15));	//move up enough to clear stairs.
			MoveSmooth(delta);	//full move
			MoveSmooth(vect(0,0,-15));	//back down.
			}
		else 
			{	//partial move to dest.
//PlayerHarry.ClientMessage(self $" Arrived. Time left:" $CutMoveToTimeout );
			MoveSmooth(vect(0,0,15));	//move up enough to clear stairs.
			MoveSmooth(dest-curLoc);
			MoveSmooth(vect(0,0,-15));	//back down.
			bCutArrived=true;
			}
			
			//check for timeout
		CutMoveToTimeout-=fDeltaTime;
		if(CutMoveToTimeout<0 && !bCutArrived)
			{
//PlayerHarry.ClientMessage(self $" Gaveup. Remaining dist" $vsize(dest-curLoc) );
			SetLocation(CutWalkDest.location);
				//make sure char is on the floor.
			MoveSmooth(vect(0,0,-100));
			bCutArrived=true;
			}


		}
Begin:

	enable( 'Tick' );
	SetPhysics(PHYS_Walking);

	loopAnim(CutWalkAnim);
moveLoop:
	
	while(!bCutArrived)
		{
		Sleep(0.1);
		}	
	if(CutNotifyScript!=None)
		{
		CutNotifyScript.CutCue(CutCueString);
		CutCueString="";
		CutNotifyScript=None;
		}
	gotostate('CutIdle');
}

state xxxCutMovingTo
{
	event tick(float fDeltaTime)
		{
		CutMoveToTimeout-=fDeltaTime;

//		Log(self $"###:" $Velocity);
//		Log(self $"###POS:" $Location);
		}

Begin:


	enable( 'Tick' );

	if(bCutFlying)
		{
		SetPhysics(PHYS_FLYING);
		}
	else
		SetPhysics(PHYS_WALKING);

	loopAnim(CutWalkAnim);
	CutMoveToTimeout=9999;
moveLoop:
	
/*	do
		{
		moveTo(CutWalkDest.location);
		}until(vsize(location-CutWalkDest.location) < fNavPointColRadius);
*/
//	Log(self $" MoveTo from:"$location $" To->:" $CutWalkDest.location $" Dist:" $vsize(location-CutWalkDest.location)); 

	Log(self $"*** MoveTo.StartPos:   " $location); 
	Log(self $"*** MoveTo.Target:     " $CutWalkDest.location); 
retry:

	moveTo(CutWalkDest.location);

//	Log(self $" Finished MoveTo:"$location $" Desired Loc:" $CutWalkDest.location $" Dist:" $vsize(location-CutWalkDest.location)); 
	if(vsize(location-CutWalkDest.location) > fNavPointColRadius)
		{
		Log(self $"*** " $self $" Failed to reach Dest in CutMovingTo. Current Loc:"$location $" Dest Loc:" $CutWalkDest.location $" Dist:" $vsize(location-CutWalkDest.location)); 
		ClientMessage("*** " $self $" Failed to reach Dest in CutMovingTo. Current Loc:"$location $" Dest Loc:" $CutWalkDest.location $" Dist:" $vsize(location-CutWalkDest.location)); 
//		SetPhysics(PHYS_None);
//		SetPhysics(PHYS_WALKING);
		Acceleration = Vect(0,0,0);
		Velocity = Vect(0,0,0);
		if(CutMoveToTimeout>100.0)
			CutMoveToTimeout=2.0;
		
		if(CutMoveToTimeout>0.0)
			goto 'retry';
		SetLocation(CutWalkDest.location);
		}

	Log(self $"*** MoveTo.Destination:" $Destination); 
	Log(self $"*** MoveTo.CurLocation:" $location); 
	Log(self $"*** MoveTo.Error:      " $(location-CutWalkDest.location)); 

	if(CutNotifyScript!=None)
		{
		CutNotifyScript.CutCue(CutCueString);

		CutCueString="";
		CutNotifyScript=None;
		}
	gotostate('CutIdle');
}
function CutTurnTo(actor dest,baseScript script,string cue)
{
	CutTurnDest=dest;
	CutNotifyScript=script;
	CutCueString=cue;
		//this is an error.
	if(dest==None)
		{
			//send this back to avoid a hang in the script.
		CutNotifyScript.CutCue(CutCueString);

		CutCueString="";
		CutNotifyScript=None;
		return;
		}

	gotostate('CutTurningTo');
}
state CutTurningTo
{

Begin:

	enable( 'Tick' );

//	playerHarry.clientMessage(self $" starting turnTo->" $CutTurnDest $" " $CutNotifyScript);
	SetPhysics(PHYS_ROTATING);

moveLoop:
	
	turnto(CutTurnDest.location);

	if(CutNotifyScript!=None)
		{
//		playerHarry.clientMessage(self $" Notifying:" $CutNotifyScript $" Cue:" $CutCueString);
		CutNotifyScript.CutCue(CutCueString);

		CutCueString="";
		CutNotifyScript=None;
		}

	gotostate('CutIdle');
}



function CutAnimate(name animName,baseScript script,string cue)
{
	CutAnimName=animName;

//	CutSaveState=GetStateName();

	gotostate('CutAnimating');
}

state CutAnimating
{

Begin:

	enable( 'Tick' );

	playAnim(CutAnimName);
	finishAnim();

//	loopAnim(CutIdleAnim);
//	gotostate(CutSaveState);

	gotostate('CutIdle');

}
function CutSetIdleAnim(name animName)
{
	CutIdleAnim=animName;
}
function CutSetWalkAnim(name animName)
{
	CutWalkAnim=animName;
}

function bool TakeSpellEffect(baseSpell spell)
{
local vector spawnLoc;
local actor newSpawn;
local bool isHit;
local actor a;

//	playerPawn(spell.Instigator).clientMessage("XXXXXXX:Spell " $spell);

	isHit=false;
	if(spell.class==class'spellLev')
		{
		if(bCanLevitate)
			{
//			startLevitate();
//			isHit=(true);	//spell took effect.
			}
		else
			isHit=(false);
		}
	else if(spell.class==class'spellTrans')
		{
		if(bCanTransform)
			{
			spawnLoc=location;
			spawnLoc.z=location.z+30;
//			playerPawn(spell.Instigator).clientMessage("XXXXXXX:transforminto" $transforminto);

			newSpawn=Spawn(transformInto,,, spawnLoc);

			bCanTransform=false;

			Destroy();
			isHit=(true);	//spell took effect.
			}
		else
			isHit=(false);
		}
	else if(spell.class==class'spellFlint')
		{
		if(bCanTransform)
			{
			spawnLoc=location;
			spawnLoc.z=location.z+30;

			newSpawn=Spawn(transformInto,,, spawnLoc);

			bCanTransform=false;
 
			Destroy();
			isHit=(true);	//spell took effect.
			}
		else
			isHit=(false);
		}
	else if(spell.class==class'spellFlip')
		{
		if(bFlipTarget)
			{
			bFlipTarget=false;
	
			HandleFlipSpell();
	
			isHit=(true);	//spell took effect.
			}
		else
			isHit=(false);
		}
	else if(spell.class==class'spellRepairo')
		{
		if(bRepairoTarget)
			{
			bRepairoTarget=false;
	
			HandleRepairoSpell();
	
			isHit=(true);	//spell took effect.
			}
		else
			isHit=(false);
		}
	else if(spell.class==class'spellFire')
		{
			HandleFireSpell();
			isHit = true;	//spell took effect.
		}
	else if(spell.class==class'spellIncendio')
		{
			HandleIncendioSpell();
			isHit = true;	//spell took effect.
		}

	if(isHit && bSpellCausesTrigger)
		{
		if( Event != '' )
			foreach AllActors( class 'Actor', A, Event )
				A.Trigger( self, self );

		}
	return(isHit);

}

//********************************************************************
// Handle this in your derived class, or let this code flip the object
function bool HandleFlipSpell()
{
}

//********************************************************************
// Handle this in your derived class, or let this code flip the object
function bool HandleRepairoSpell()
{
	//local actor newSpawn;

	Spawn(classRepairInto, , , Location);
	Spawn(classRepairParticalFX, , , Location);
	Destroy();
}

//********************************************************************
function bool HandleFireSpell()
{
	TakeDamage( 5, none, vect(0,0,0), vect(0,0,0), '' );

}

//********************************************************************
function HandleIncendioSpell()
{
}

//********************************************************************

defaultproperties
{
     fNavPointColRadius=50
     ShadowClass=Class'Engine.ActorShadow'
     talkAnimName=Talk
     walkAnimName=Walk
     idleAnimName=Idle
     bGestureOnTargeting=True
     bCanWalk=True
     GroundSpeed=50
     AirSpeed=100
     AccelRate=1024
     SightRadius=1000
     PeripheralVision=0.85
     BaseEyeHeight=40.75
     EyeHeight=40.75
     MenuName="Dudley"
     bProjTarget=False
     Mass=1
     Buoyancy=118.8
}
