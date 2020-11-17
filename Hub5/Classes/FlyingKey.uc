//=============================================================================
// FlyingKey  -- The little magic key that Harry chases around in Flying Keys level
//=============================================================================
class FlyingKey extends Snitch;


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
     Mesh=SkeletalMesh'HPModels.skflyingkeyMesh'
     CollisionRadius=10
     CollisionHeight=10
}
