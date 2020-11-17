/*------------------------------------------------------------------------------------------------------------------------
//			Petunia, enemy of all that is true and good
------------------------------------------------------------------------------------------------------------------------*/

	class petunia extends baseChar;


	var int dialog1[10];
	var int currentspeech;
	var int status;



state spottedharry
{



}



function yellAt()
{

		local sound step;
		step=speech[01];
		PlaySound(step, SLOT_Talk,1.0, false, 1000.0, 0.9);
	//	turnto(p);
}

state atStation
{

	begin:

//	p.clientmessage("at station");
		loopAnim('scrub');

	SetPhysics(PHYS_Rotating);

	
	desiredRotation=(destP.rotation);

	loop:
		
	
	
	sleep(destP.aiData[stationNumber].pauseTime);
	
//	p.clientMessage("sleeptime "$destP.aiData[stationNumber].pauseTime);
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
//	p.clientMessage("back to patrol");
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
		Disable( 'Tick' );
		SetPhysics(PHYS_Walking);
		startup();

		
		

		loopAnim('walk');

	moveLoop:
		
		next=findPath(navP,stationDestination);
		
//		if(next!=none)
			p.clientMessage("next is "$next);
//		if(navp!=none)
			p.clientMessage("in patrol towards "$navp);	
		do
		{
			moveTo(navP.location);
			sleep(0.005);
			p.clientmessage("distance to navp is "$vsize(location-(navP.location)));
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
     dialog1(0)=13
     dialog1(1)=1
     dialog1(2)=-1
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skpetuniaMesh'
}
