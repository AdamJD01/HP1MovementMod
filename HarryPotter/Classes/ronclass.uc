	class ronclass extends baseChar;

	var rotator rotval;

auto state lookaround
{

	begin:
		setPhysics(PHYS_none);
		rotval=rotation;
		

	lcloop:
		loopanim('idle');
		finishanim();
		sleep(2.0);
		loopanim('write');

	//	PlaySound(sound 'HPSounds.events_sfx.s_writing2', SLOT_Interact, 1.0, false, 1000.0, 1.0);

		sleep(14);
		finishanim();
		loopanim('look');
		sleep(1);
		finishanim();
		goto 'lcloop';



}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skronclassMesh'
     CollisionHeight=30
}
