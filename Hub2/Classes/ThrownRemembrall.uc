//=============================================================================
// ThrownRemembrall -- The stone thrown by Draco to Harry in RememberallChase
//=============================================================================
class ThrownRemembrall extends QuidditchPawn;


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	if ( Mesh == None )
		Mesh = SkeletalMesh'HProps.RememberallMesh';

	if ( ParticleTrail == None )
		ParticleTrail = class'Quaffle_FX';

	Super.PostBeginPlay();

	StopFlyingOnPath();		// Don't fly now, wait until triggered
}


function Trigger( Actor Other, Pawn EventInstigator )
{
	// Start flying on path

	FlyOnPath( Path[CurPath] );
	Show();
}


event FinishedInterpolation(InterpolationPoint Other)
{
	// Just hide Rememberall (don't switch to another path)
	Hide();
}

defaultproperties
{
     ParticleTrail=Class'HPParticle.Quaffle_FX'
     Tag='
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.RememberAllMesh'
     CollisionRadius=10
     CollisionHeight=10
}
