	class canary extends baseChar;

	var rotator rotval;

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

	//	PlaySound(sound 'HPSounds.Critters_sfx.s_canary_twip', SLOT_Interact, 1.0, false, 1000.0, 1.0);
		setPhysics(PHYS_walking);
		startup();
		rotval=rotation;
		loopanim('idle');

	lcloop:
		sleep(1.0);
		//	if(abs(vsize(location-p.location))<100)
		//	{
				gotostate('fly');
		//	}
			goto 'lcloop';



}


state fly
{
	ignores SeePlayer, HearNoise, KilledBy, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, TakeDamage, PainTimer, Died;


function tick(float Deltatime)
{
	local vector offset;


	super.tick(deltatime);

	offset.x=100*deltatime;
	offset.z=100*deltatime;
	offset=offset>>rotation;
	rotval.yaw=rotval.yaw+(16000*deltatime);
	setrotation(rotval);


	if(!move(offset))
	{

		destroy();
	}


}

	begin:
		loopanim('fly');
		setphysics(phys_none);
		//PlaySound(sound 'HPSounds.Critters_sfx.s_canary_flap_loop', SLOT_Interact, 1.0, false, 500.0, 1.0);
		
	flyloop:
		sleep(1);
		if(abs(location.z-p.location.z)>1000)
		{

			destroy();
		}
		



}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skcanaryMesh'
     CollisionRadius=5
     CollisionHeight=5
}
