	class hermione extends baseChar;



	var int dialog1[20];
	var int currentspeech;
	var baseprops desk;
	var vector newloc;
	var rotator pigrot;



state atStation
{

	begin:


	if(destP.aiData[stationNumber].behavior==BH_die)
	{
		destroy();
	}


	SetPhysics(PHYS_Rotating);

	
	desiredRotation=(destP.rotation);

	loop:
		
	
	
	sleep(destP.aiData[stationNumber].pauseTime);
	
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
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
		sleep(5);

		
		

		loopAnim('run');

	moveLoop:
		
		next=findPath(navP,stationDestination);
		p.clientMessage("navP is "$navp);
		p.clientMessage("next is "$next);
		do
		{
			moveTo(navP.location);
			sleep(0.005);
		}until(vsize(location-(navP.location))<75);

		if(destp==navP)
		{
			gotostate('atstation');
		}
		navP=navigationPoint(next);
		
		next=none;
		
		goto 'moveLoop';


}


state idle
{
	begin:

	loop:

		FinishAnim();
		//if(frand() < 0.4)
			LoopAnim('Breathe',,0.5);
		//else
		//	LoopAnim('Look',,0.5);		
	
		goto 'loop';
}

defaultproperties
{
     GroundSpeed=150
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhermioneMesh'
}
