	class mcgonagall extends baseChar;



	var int dialog1[20];
	var int currentspeech;
	var baseprops desk;
	var vector newloc;
	var rotator pigrot;
	var sound storeroom;
	var sound nextSound;
	var sound frogtalk;
	var sound gargtalk;
	var bool solvedGargoyle;

function postbeginplay()
{
	super.postbeginplay();
	nextsound=storeroom;
	solvedGargoyle=false;
}

function Trigger( actor Other, pawn EventInstigator )
{

	nextsound=frogtalk;
	solvedGargoyle=true;

}

function tick(float deltaTime)
{

		if((vsize(location-(P.location))<200))
		{
			
			if(nextSound!=none)
			{
			//	PlaySound(nextSound, SLOT_Talk,1.0, false, 1000.0, 0.9);
				nextSound=none;
			}
		}
		if((vsize(location-(P.location))>500)&&nextSound==none)
		{
			if(solvedGargoyle)
			{

			}
			else
			{
				nextsound=gargtalk;
			}
		}


}






state atStation
{

	begin:

//	p.clientmessage("at station");

		if(destP.aiData[stationNumber].behavior==BH_Idle2)
		{
			loopAnim('write');
		}
		else
		{
			playanim('castspell');
			SetPhysics(PHYS_Rotating);
			desiredRotation=(destP.rotation);

			sleep(1.5);
			foreach allActors(class 'baseprops',desk)
			{
				if(desk.isa('TransTeachersDesk')==true)
				{
					newloc=desk.location;
					newloc.z=newloc.z+10;
					desk.destroy();
					pigrot.yaw=42360;
					Spawn(Class'transhiteffect',,, newloc);
					Spawn(Class'HarryPotter.pig',,, newloc,pigrot);
//					PlaySound(sound 'HPSounds.Critters_sfx.pig_squeal1', SLOT_Interact, 1.0, false, 1000.0, 1.0);
				
				}	

			}


		}

	SetPhysics(PHYS_Rotating);

	
	desiredRotation=(destP.rotation);

	loop:
		
	
	
	sleep(destP.aiData[stationNumber].pauseTime);
	
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
	finishanim();
	gotostate('patrol');

	goto 'loop';

}


auto state patrol
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
			if(destP.Name==stationDestination)
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
		SetPhysics(PHYS_Walking);
		startup();

		
		

		loopAnim('walk');

	moveLoop:
		
		next=findPath(navP,stationDestination);
		do
		{
			moveTo(navP.location);
			sleep(0.005);
		}until(vsize(location-(navP.location))<75);

		if(destp==navP)
		{
			finishanim();
			gotostate('atstation');
		}
		navP=navigationPoint(next);
		
		next=none;
		
		goto 'moveLoop';


}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skmcgonagallMesh'
     DrawScale=1.3
}
