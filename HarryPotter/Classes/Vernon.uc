/*------------------------------------------------------------------------------------------------------------------------
//			Vernon, enemy of all that is true and good
------------------------------------------------------------------------------------------------------------------------*/

	class Vernon extends baseChar;




	var int dialog1[10];
	var int currentspeech;
	var name prevState;
	var rotator oldRot;
	var int yellcount;




state yellAtHarry
{

	begin:
	prevState=GetStateName();
	playanim('look');
	oldRot=rotation;
	turnto(p.location);
	SLEEP (5);
	sleep(5);
	if(yellCount==0)
	{
//removed by cmp		p.dialogResponse(05);
		yellCount=1;
	}
	else
	{
		if(yellCount==1)
		{
//removed by cmp			p.dialogResponse(06);
			yellcount++;
		}
	}

	gotostate('wait');
	goto 'begin';


}

function yellAt()
{

		local sound step;
		step=speech[01];
		PlaySound(step, SLOT_Talk,1.0, false, 1000.0, 0.9);
		gotostate('yellAtHarry');
		
}


function DialogResponse(int dialogNum)
{
		local sound step;
		step=speech[dialogNum];
		PlaySound(step, SLOT_Talk,1.0, false, 1000.0, 0.9);
		
	
}


/*

state faceHag
{


function Tick(float DeltaTime)
{

}



 begin:
 	moveto(forcelocation);
	Disable( 'tick' );
	loopanim('breath');
	
	
	

	floop:
	turnto(forcedir);
	sleep(1.0);
	goto 'floop';



}


*/





state spottedharry
{


	begin:

//	p.clientMessage("spotted harry");
	gotostate('wait');
}

state atStation
{

	begin:
	disable('touch');
	disable('tick');
//	p.clientmessage("at station");
		playAnim('sit');

	SetPhysics(PHYS_Rotating);

	
	desiredRotation=(destP.rotation);

	loop:
		
	/*
	
	sleep(destP.aiData[stationNumber].pauseTime);
	
//	p.clientMessage("sleeptime "$destP.aiData[stationNumber].pauseTime);
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
//	p.clientMessage("back to patrol");
	gotostate('patrol');
*/
	sleep(1);
	goto 'loop';

}
auto state wait
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





	begin:
		startup();
		SetPhysics(PHYS_Rotating);

		
		disable('tick');
		loopanim('look');
	//	p.clientmessage("in wait");
	loop:
		PlaySound(speech[02], SLOT_Talk,1.0, false, 500.0, 0.9);

		sleep(6.01);
		goto 'loop';

}

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


/*
function touch (actor other)
{

	if(other==destp)
	{
	
		
		gotostate('atstation');
	}
	
}
*/
Begin:
		Disable( 'Tick' );
		Disable('Touch');
		SetPhysics(PHYS_Walking);
		startup();

		
		

		loopAnim('walk');

	moveLoop:
		
		next=findPath(navP,stationDestination);
//		if(next!=none)
//			p.clientMessage("next is "$next);
//		if(navp!=none)
//			p.clientMessage("in patrol towards "$navp);	

		do
		{
			moveTo(navP.location);
			sleep(0.005);
		}until(vsize(location-(navP.location))<50);

		if(destp==navP)
		{
			gotostate('atstation');
		}

		navP=navigationPoint(next);
		next=none;
		
		goto 'moveLoop';


}

defaultproperties
{
     dialog1(0)=11
     dialog1(1)=4
     dialog1(2)=-1
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skvernonMesh'
}
