//===============================================================================

class spellFire extends BASESPELL;
#exec MESH  MODELIMPORT MESH=SPELLLEVMesh MODELFILE=models\LevProjectile.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SPELLLEVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SPELLLEVAnims ANIMFILE=models\LevProjectile.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SPELLLEVMesh X=2.0 Y=2.0 Z=2.0
#exec MESH  DEFAULTANIM MESH=SPELLLEVMesh ANIM=SPELLLEVAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SPELLLEVAnims VERBOSE
#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage

#EXEC TEXTURE IMPORT NAME=alohoSpellIcon  FILE=TEXTURES\alohoSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC MESHMAP SETTEXTURE MESHMAP=SPELLLEVMesh NUM=0 TEXTURE=HPBase.FXPackage.win_p

// Import the pattern
#exec PATTERN IMPORT PATTERN=AlohoPattern FILE=Patterns/Alohomora.hpg

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('all', 2.0, 0.0);
}

auto state Flying
{
	event tick(float dtime)
	{
		local float s1, s2;
		local float tv;

		Super.Tick(dtime);

		tv = 100;  // "terminal velocity"

		//Uh oh, this might be too slow
		s1 = VSize(Velocity);
		s2 = tv  +  1.0 / (1.0 + 10.0*dtime)  *  (s1 - tv);
		Velocity *= s2/s1;
	}

	function ProcessTouch (Actor Other, vector HitLocation)
	{
		if( pawn(other) == instigator )
			return;

		if( baseHarry(Other) != none )
		{
			other.TakeDamage( 5, none, vect(0,0,0), vect(0,0,0), '' );
		}

		PlaySound(ImpactSound, SLOT_Interact,  1.0, false, 2000.0, 1);

		hitParticleEffect=Spawn(hitParticleEffectClass,,, HitLocation,rot(0,0,0));
		hitParticleEffect.setRotation(hitParticleEffect.default.rotation);
		reactParticleEffect=Spawn(reactParticleEffectClass,,, HitLocation,rot(0,0,0));
		reactParticleEffect.setRotation(reactParticleEffect.default.rotation);
		reactParticleEffect.SetOwner(other);
		reactParticleEffect.SourceWidth.Base=baseProps(Other).collisionRadius;

		Destroy();
	} 

	function BeginState()
	{
		Velocity = vector(Rotation) * speed;
		Acceleration = vect(0, 0, -250); //vector(Rotation) * 1000;
	}
}

//*************************************************************************************************************************
function PlaySpellCastSound()
{
	PlaySound(Sound'HPSounds.Critters_sfx.firecrab_attack', SLOT_Interact,  1.0, false, 2000.0, 1);
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.alohoSpellIcon'
     spellName="Alohomora"
     CastSound=Sound'HPSounds.magic_sfx.Spells.s_spell_throw5'
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Crabfire'
     hitParticleEffectClass=Class'HPParticle.SmokeExplo_01'
     Gesture=Gesture'HPBase.AlohoPattern'
     Speed=2000
     ImpactSound=None
     Style=STY_Translucent
     Mesh=None
}
