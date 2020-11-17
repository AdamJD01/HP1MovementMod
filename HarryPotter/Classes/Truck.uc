//===============================================================================
//  [Truck] 
//===============================================================================

class Truck extends baseChar;
//#EXEC MESH  MODELIMPORT MESH=TruckMesh MODELFILE=models\Truck.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=TruckMesh X=0 Y=0 Z=20 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=TruckAnims ANIMFILE=models\Truck.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=TruckMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=TruckMesh ANIM=TruckAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=TruckAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=TruckTex0  FILE=TEXTURES\ambulanc_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=TruckMesh NUM=0 TEXTURE=TruckTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: ambulanc_128.bmp  Path: H:\Art\Models\Objects\Dursley Props\Toys\Truck 




	var name prevState;
	var rotator oldRot;




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
//	disable('touch');
//	enable('tick');
//	p.clientmessage("at station");


	

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
		SetPhysics(PHYS_WALKING);

		
		enable('tick');
		loopanim('breath');
	//	p.clientmessage("in wait");
	loop:
		sleep(0.01);
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

		
		

		//loopAnim('walk');

	moveLoop:
		
		next=findPath(navP,stationDestination);
	//	if(next!=none)
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
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.TruckMesh'
     bCollideActors=False
     bBlockActors=False
}
