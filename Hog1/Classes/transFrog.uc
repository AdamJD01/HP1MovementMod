class transFrog extends baseChar;

var rotator rotval;
var Vector spawnLoc;
var Vector destLoc;
var Vector destDir;
var int hopCount;


event PreBeginPlay()
{
	spawnLoc=location;
}

auto state idle
{
/*
	begin:
		setPhysics(PHYS_walking);
		loopanim('breath');

	lcloop:
		sleep(FRand()*3.0);
		if(bHidden)
			goto 'lcloop';


		finishanim();

		if(VSize(spawnLoc-location)>100)
			{
			hopCount=3.0;		
			destDir=normal(spawnLoc-location);
			}
		else
			{
			hopCount=FRand()*3.0;		
			destDir=vrand()*4;
			}
//		destLoc=destDir+spawnLoc;
		TurnTo(location+destDir);

		loopanim('hopstart');
		finishanim();
		gotostate('hop');
*/
}


state hop
{

	function tick(float Deltatime)
		{
		movesmooth(destDir);
		}

	begin:
		
	hoploop:
		Disable('Tick');
		loopanim('hopstart');
		finishanim();

		Enable('Tick');			
		loopanim('hop');
		finishanim();
		Disable('Tick');

		loopanim('hopend');
		finishanim();

		hopCount--;
		if(hopCount>0)
			goto 'hoploop';

	
		gotostate('idle');

}

defaultproperties
{
     bCanTransform=True
     transformInto=Class'HProps.MatchBox'
     bFlintTarget=True
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skfrogMesh'
     CollisionRadius=20
     CollisionHeight=30
     bProjTarget=True
}
