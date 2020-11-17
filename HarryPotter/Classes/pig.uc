	class pig extends baseChar;

	var rotator rotval;
	var vector newloc;
	var rotator newrot;

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
			loopanim('breath');
			sleep(2+frand()*3);	
			playanim('lookup');
			finishanim();

			if(frand() >= 0.5)
				{
					PlaySound(sound 'HPSounds.critters_sfx.pig_squeal1',, 3.2, true, 1000.0, 0.5);
				}
		}

}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skpigMesh'
     CollisionHeight=30
     bCollideActors=False
}
