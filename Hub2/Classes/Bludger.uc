//=============================================================================
// Bludger  -- A black ball beaters hit away from seekers in Quidditch
//=============================================================================
class Bludger extends QuidditchPawn;

const		NUM_HIT_SOUNDS = 2;
var Sound	HitSounds[2];				// All the different sounds of bludger hitting something

var(Quidditch) int	Damage;				// How much damage pawn imparts on impact

//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	if ( Mesh == None )
		Mesh = SkeletalMesh'HProps.QuidditchBludgerMesh';

	if ( ParticleTrail == None )
		ParticleTrail = class'Bludger_FX';

	Super.PostBeginPlay();

	// Load the bludger hit sounds
	HitSounds[0] = Sound'HPSounds.Quidditch_sfx.Q_Bludger_Hit1';
	HitSounds[1] = Sound'HPSounds.Quidditch_sfx.Q_Bludger_Hit2';

	// Initialize other members
	bRecycle = true;
}


function Touch( Actor Other )
{
	local Pawn	Subject;

	// Okay to hit a pawn, but not the pawn throwing this object
	Subject = Pawn( Other );
	if ( Subject != None && Subject != Emitter )
	{
		if ( bMine )
		{
			if ( Other == Target )
			{
				ExplodeMine();
				Subject.TakeDamage( Damage, Self, Location, 100*Normal(Velocity), 'Bludgered' );
				FinishMine();
			}
		}
		else
		{
			PlaySound( HitSounds[ Rand( NUM_HIT_SOUNDS ) ], SLOT_Interact, , , 2000.0 );	// Radius makes sure player can be heard near by

			Subject.TakeDamage( Damage, Self, Location, 100*Normal(Velocity), 'Bludgered' );
			Super.Touch( Other );
		}
	}
}

defaultproperties
{
     Damage=4
     ParticleTrail=Class'HPParticle.Bludger_FX'
     HaloClass=Class'HPParticle.Bludger_Halo'
     ExplosionFX=Class'HPParticle.Bludger_Explo'
     PursuitSound=Sound'HPSounds.Quidditch_sfx.bludger_loop'
     ExplosionSound=Sound'HPSounds.Hub1_sfx.MAL_candy_explodes'
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.QuidditchBludgerMesh'
     CollisionRadius=50
     CollisionHeight=50
}
