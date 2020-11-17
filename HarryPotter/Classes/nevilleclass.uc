	class nevilleclass extends baseChar;

	var rotator rotval;

auto state lookaround
{

	begin:
		setPhysics(PHYS_none);
		rotval=rotation;
		

	lcloop:
		loopanim('idle');
		sleep(5.0);
		finishanim();
		loopanim('write');
	//	PlaySound(sound 'HPSounds.events_sfx.s_writing2', SLOT_Interact, 1.0, false, 1000.0, 1.0);
		sleep(10);
		finishanim();
		loopanim('look');
		sleep(3);
		finishanim();
		goto 'lcloop';



}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.sknevilleclassMesh'
     CollisionHeight=30
}
