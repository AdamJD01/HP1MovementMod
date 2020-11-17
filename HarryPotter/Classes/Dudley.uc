/*------------------------------------------------------------------------------------------------------------------------
			Dudley, enemy of all that is true and good
------------------------------------------------------------------------------------------------------------------------*/

	class Dudley extends baseChar;





	var int dialog1[10];
	var int currentspeech;
	var name prevState;
	var rotator oldRot;
	var weapon weap;





state yellAtHarry
{

	begin:
	prevState=GetStateName();
	playanim('look');
	oldRot=rotation;
	turnto(p.location);
	SLEEP (5);

	gotostate(prevstate);
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

	
	desiredRotation=(destP.rotation);

	loop:
		

	
	sleep(destP.aiData[stationNumber].pauseTime);
	
//	p.clientMessage("sleeptime "$destP.aiData[stationNumber].pauseTime);
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
//	p.clientMessage("back to patrol");
	gotostate('patrol');

	sleep(1);
	goto 'loop';

}
auto state wait
{

	

	function startup()
	{

	local weapon weap;

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



	PendingWeapon = spawn(class'RCTruckControl');
	ChangedWeapon();

	weap.WeaponSet(self);
		

	}

 



	begin:
		startup();
		SetPhysics(PHYS_Rotating);

		
		disable('tick');
		loopanim('smash');
	loop:
		sleep(2.01);

	PendingWeapon = spawn(class'WTruck');
	ChangedWeapon();
		sleep(3);
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



function touch (actor other)
{

	if(other==destp)
	{
	
		
		gotostate('atstation');
	}
	
}

Begin:
		Disable( 'Tick' );
		Enable('Touch');
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



state takeRemote
{


function startTruck()
{
	local truck t;
	foreach allactors(class'truck',t)
	{
		t.bHidden=false;
		t.gotostate('patrol');
		break;

	}
}


	begin:
		playanim('sit2stand');
		startTruck();
	
	
	loop:
		sleep(2);
		
		PendingWeapon = spawn(class'RCTruckControl');
		ChangedWeapon();

	weap.WeaponSet(self);
		



		gotostate('patrol');



}

defaultproperties
{
     dialog1(0)=1
     dialog1(1)=8
     dialog1(2)=2
     dialog1(3)=-1
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skdudleyMesh'
}
