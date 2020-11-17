//===============================================================================
//  [ChocolateFrog] 
//===============================================================================

class ChocolateFrog extends baseProps;

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: chocfrog_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects 

var()	Sound pickup;
var() sound prox;
var actor shower;
var bool playedRibbit;
var float fPickupFlyTime;


auto state holdstill
{


function PreBeginPlay()
{
	local vector newloc;
	Super.PreBeginPlay();
	newloc=location;
	newloc.z=newloc.z+96;
	shower=spawn(class'jellyglow',,,newloc);

}

function touch (actor other)
{
	if(other==playerharry)
	{
		//hpHud(playerharry.myhud).numFrogs=hphud(playerharry.myhud).numFrogs+1;

	GotoState('PickingUp');
	}


}

begin:
loop:
/*	if(!playedRibbit)
	{
		if(vsize(location-(playerHarry.location))<200)
		{	
			playsound(prox);
			playedRibbit=true;
		}
	}
*/
	LoopAnim('CROAK', 1.0, 0.0);
	finishanim();

	// @AE: Trigger the audio croak.
	PlaySound(sound'HPSounds.critters_sfx.frog_ribbit');

	LoopAnim('hop', 1.0, 0.0);
	finishanim();

	LoopAnim('BREATH', 0.6, 0.0);
	sleep(frand()*3);
	finishanim();

	// @AE: Trigger the audio croak again here.
	PlaySound(sound'HPSounds.critters_sfx.frog_ribbit');

	LoopAnim('hop', 1.0, 0.0);
	finishanim();

	goto 'Loop';
}

state PickingUp
{
	event tick(float delta)
		{
		local vector dest;
		fPickupFlyTime-=delta;
		Move((playerharry.CameraToWorld(vect(-0.75,0.75,150))-location)/(fPickupFlyTime/delta));
		}

	begin:
		disable('touch');
		PlaySound(pickup);
		bCollideWorld=false;
		playerharry.AddHealth(10);
		fPickupFlyTime=0.25;
		while(fPickupFlyTime>0)
			{
			sleep(0.1);
			}
		
		destroy();
}

defaultproperties
{
     Pickup=Sound'HPSounds.magic_sfx.pickups.pickup_frog'
     bStatic=False
     Physics=PHYS_Falling
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skChocolateFrogMesh'
     DrawScale=0.5
     CollisionHeight=20
     bCollideWorld=True
}
