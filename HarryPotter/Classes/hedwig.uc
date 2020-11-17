	class hedwig extends baseChar;



	var int dialog1[20];
	var int currentspeech;
	var rotator testrot;



state atStation
{




	begin:

		testrot.pitch=0;
		testrot.yaw=0;
		testrot.roll=0;

		if(destP.aiData[stationNumber].behavior==BH_Die)
		{
			destroy();
		}
		if(destP.aiData[stationNumber].behavior==BH_Idle1)
		{
			// AE:
			PlaySound( sound'HPSounds.critters_sfx.owl_hoot2' );

			spawn(class'HedwigsScroll',,,,testrot);
			
		}

		if(destP.aiData[stationNumber].behavior==BH_Idle3)
		{
			// AE:
			PlaySound( sound'HPSounds.critters_sfx.owl_hoot3' );

			spawn(class'demoScroll',,,,testrot);			
		}

	
	desiredRotation=(destP.rotation);

	loop:
		
	
	
	sleep(destP.aiData[stationNumber].pauseTime);
	
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
	gotostate('patrol');

	goto 'loop';

}


auto state waitforTrigger
{
	
function Trigger( actor Other, pawn EventInstigator )
{
	bhidden=false;
	gotostate('patrol');
	
}
	begin:

	loop:

		sleep(2.4);
		
		goto 'loop';

}



// patrol state moves the characters around a path described by hpath and basestations

 state patrol
{
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

			if(destp!=None && destP.Name==stationDestination)
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

  Begin:
	enable( 'Tick' );
	SetPhysics(PHYS_flying);
	startup();
playerHarry.clientMessage(self $" starting patrol");
	if(firstPath=='')
	{
			goto 'idleloop';

	}
	loopAnim('fly');

  moveLoop:
	
	next=findPath(navP,stationDestination);
	playerHarry.clientMessage("navp is "$navp);
	playerHarry.clientMessage("next is "$next);
/*	if(next==none)
	{
		goto 'idleloop';
	}
*/
	do
	{
		moveTo(navP.location);
		impartinformation();
		sleep(0.005);
	}until(vsize(location-(navP.location)) < fNavPointColRadius);
	
	if(destp!=None && destp==navP)
	{
		PawnAtStation();
	}

	navP=navigationPoint(next);
	if(navP==none)
	{
	  idleLoop:
		while( true )
		{
			loopAnim('fly');
			impartinformation();
			sleep(speechTime);
			speechTime=0;
			sleep(0.5);

			//If loop path, just start the whole patrol process over again by setting navp to firstPath.
			if( bLoopPath )
			{
				foreach allActors(class 'navigationPoint',navP)
					if(navp.Name==firstPath)
						break;
				break; //break the while loop
			}

			//goto 'idleloop';
		}
	}

	
	next=none;
	
	goto 'moveLoop';
}

defaultproperties
{
     GroundSpeed=70
     AirSpeed=300
     AirControl=2
     bHidden=True
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhedwigMesh'
     CollisionHeight=42
     bCollideActors=False
     RotationRate=(Pitch=70000,Yaw=70000,Roll=70000)
}
