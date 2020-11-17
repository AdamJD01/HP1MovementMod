//=============================================================================
// Goat.
//=============================================================================
class Goat expands baseChar;

	var rotator rotval;
	var vector newloc;
	var rotator newrot;
	var float goatstuff;

auto state pause
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
	}


	begin:
		setPhysics(PHYS_walking);
		startup();

		while (true)
		{	
			loopanim('idle');
			sleep(1+frand()*3);	
			goatstuff=frand();

			if(goatstuff > 0.5)
			{			
				loopanim('lookaround');
				sleep(2);
				finishanim();
			}

			if(goatstuff < 0.5)
			{			
				loopanim('graze');
				sleep(1+frand()*5);
				playanim('lookup');
				finishanim();
			}
		}

}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skgoatMesh'
}
