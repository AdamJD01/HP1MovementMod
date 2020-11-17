//=============================================================================
// Quaffle  -- A red ball that can be held by players in Quidditch
//=============================================================================
class Quaffle extends QuidditchPawn;


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	if ( Mesh == None )
		Mesh = SkeletalMesh'HProps.QuidditchQuaffleMesh';

	if ( ParticleTrail == None )
		ParticleTrail = class'Quaffle_FX';

	Super.PostBeginPlay();
}

defaultproperties
{
     ParticleTrail=Class'HPParticle.Quaffle_FX'
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.QuidditchQuaffleMesh'
     CollisionRadius=40
     CollisionHeight=40
}
