	class hermioneclass extends baseChar;

	var rotator rotval;

auto state lookaround
{

	begin:
		setPhysics(PHYS_none);
		rotval=rotation;
		

	lcloop:
		loopanim('breath');
		sleep(8.0);
		finishanim();
		loopanim('write');

	//	PlaySound(sound 'HPSounds.events_sfx.s_writing1', SLOT_Interact, 1.0, false, 1000.0, 1.0);

		sleep(5);
		finishanim();
		loopanim('look');
		sleep(2);
		finishanim();
		goto 'lcloop';



}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhermioneclassMesh'
     CollisionHeight=30
}
