//===============================================================================
//  [skspikybushNoThorns] 
//===============================================================================

class spikybushNoThorns extends baseChar;


auto state Wilted
{
	event AnimEnd()
	{
		// When wilted, players can walk over
	   bBlockPlayers = false;

		// Don't know if the following line is completely necessary.
		// trying to fix problem where withered plants block spells being done on normal plants
		SetCollisionSize(0, 0);
	}

begin:
	log("spiky bush wilting...");
    //bprojtarget=false;

	playAnim('wither');

	Sleep(1); // hold on for the first second of animation before playing sound effect

	PlaySound ( sound'HPSounds.Hub2_sfx.spiky_bush_wilt', SLOT_None);
}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skspikybushnothornsMesh'
     DrawScale=2.4
     CollisionRadius=48
     CollisionHeight=48
     bCollideActors=False
     bCollideWorld=False
     bBlockActors=False
     bBlockPlayers=False
}
