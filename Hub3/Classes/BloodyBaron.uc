// BloodyBaron.uc - Source for the Bloody Baron wanderer...

class BloodyBaron extends BaseChar;

var () float nGhostDamage;
var () bool  bWaitForTrigger;

var float OldYaw;

// ********************************************************
// Class Functions & Events
function bump(Actor Other)
{
	if(Other==playerHarry)
	{
		playerharry.TakeDamage(nGhostDamage, self,Location, Location * 0,'exploded');
		gotostate('stunned');
	}
}

function PostBeginPlay()
{
	enable('bump');
}

event Trigger( Actor Other, Pawn EventInstigator )
{
	if(bWaitForTrigger)
		gotostate('patrol');
}


// ******************************************************************************
// States
auto state startstate  // start here to determine what to do...
{
begin:
	if(!bWaitForTrigger)
		gotostate('patrol');
	else
		gotostate('idle');
}

state idle
{
begin:
	loopanim('float');
looppoint:
	Sleep(1);
	goto('looppoint');
}

// Override patrol so that we use PHYS_Flying
state patrol
{
	event Tick(float DeltaTime)
	{
		Super.Tick(DeltaTime);

		if(vsize(location-playerHarry.location) < CollisionRadius)
		{
			playerharry.TakeDamage(nGhostDamage, self,Location, Location * 0,'exploded');
			gotostate('stunned');
		}
	}

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

					if(destP.Name==stationDestination)
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
	}

  Begin:
	enable( 'Tick' );
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

			moveTo(navP.location);
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


// When he hits Harry, he hangs out here for a while...
state stunned
{
begin:

	// Stop in place
	OldYaw = rotationrate.yaw;
	rotationrate.yaw = 0.0;
	moveto(location);
	rotationrate.yaw = OldYaw;

	// Play a little animation
	playanim('Reaction2Harry');
	finishanim();
	loopanim('Float');
	gotostate('patrol');
}

// Your Standard Defaults for the Bloody Baron

defaultproperties
{
     nGhostDamage=5
     bUseFraySplines=True
     walkAnimName=Float
     GroundSpeed=160
     Physics=PHYS_Flying
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skbloodybaronMesh'
     Opacity=0.3
     CollisionRadius=32
     bCollideWorld=False
     bBlockActors=False
     bBlockPlayers=False
}
