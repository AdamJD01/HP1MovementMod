	class ghost extends baseChar;

	var bool approachingHarry;
	var vector randvector;
	var vector facedir;
	var (ghost) float idleSleep;




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

		Style=STY_Translucent;
		

	}


function tick(float deltaTime)
{
		if(approachingHarry)
		{
			
				movesmooth(normal(p.location-location)*(deltatime*100));
				facedir=p.location;
				
				
			if((vsize(location-(P.location))<300))
			{
				approachingHarry=false;
				randvector=vrand();
				randvector.z=0;
				facedir=((randvector*1000000)+location);	
			
				
				
			}
		}
		else
		{
				movesmooth(normal(randvector)*(deltatime*100));
				
				
			if(vsize(location-(P.location))>5000)
			{
				approachingHarry=true;
			}
		}
}

Begin:
		disable('tick');
		sleep(idlesleep);
		enable( 'Tick' );
		SetPhysics(PHYS_flying);
		startup();
		approachingHarry=true;

		
		

		loopAnim('float');

	moveLoop:
		
		sleep(0.11);
		turnto(facedir);
		goto 'moveloop';



}

defaultproperties
{
     idleSleep=120
     GroundSpeed=150
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skghostMesh'
     bCollideActors=False
     bCollideWorld=False
}
