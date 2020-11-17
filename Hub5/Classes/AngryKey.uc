//=============================================================================
// AngryKey  -- An angry red key that can wear Harry out during Flying Keys level
//=============================================================================
class AngryKey extends Bludger;


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	Super.PostBeginPlay();

	LoopAnim( 'Fly' );
}

defaultproperties
{
     ParticleTrail=Class'HPParticle.badkeys'
     HaloClass=None
     DrawType=DT_None
     Mesh=SkeletalMesh'HPModels.skangryflyingkeyMesh'
}
