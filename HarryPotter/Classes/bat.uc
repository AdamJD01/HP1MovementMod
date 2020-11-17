	class bat extends baseChar;

	var rotator rotval;
	var float offsetDir;

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
		setPhysics(PHYS_none);
		startup();
		rotval=rotation;
		loopanim('hang');
		offsetdir=-10;

	lcloop:
		sleep(0.5);
			if(abs(vsize(location-p.location))<300)
			{
				gotostate('fly');
			}
			goto 'lcloop';



}


state fly
{
	ignores SeePlayer, HearNoise, KilledBy, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, TakeDamage, PainTimer, Died;


function tick(float Deltatime)
{
	local vector offset;


	super.tick(deltatime);


	if(offsetdir<0)
	{
		if(abs(location.z-p.location.z)<60)
		{
			offsetdir=10;
		}
	}
	else
	{
		if(abs(location.z-p.location.z)>140)
		{
			offsetdir=-10;
		}
	}
	offset.x=100*deltatime;
	offset.z=offsetdir*deltatime;
		
	offset=offset>>rotation;
	rotval.yaw=rotval.yaw+(16000*deltatime);
	setrotation(rotval);

	movesmooth(offset);


}

	begin:
		loopanim('fly');
		setphysics(phys_none);
		
	//	PlaySound(sound 'HPSounds.critters_sfx.bats_squeaking1', SLOT_Interact, 1.0, false, 1000.0, 1.0);
	flyloop:
		sleep(4);
		



}

defaultproperties
{
     bCanTransform=True
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skbatMesh'
     CollisionRadius=30
     CollisionHeight=30
     bProjTarget=True
}
