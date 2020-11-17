//===============================================================================

class spellAvif extends BASESPELL;
#exec MESH  MODELIMPORT MESH=SPELLLEVMesh MODELFILE=models\LevProjectile.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SPELLLEVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SPELLLEVAnims ANIMFILE=models\LevProjectile.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SPELLLEVMesh X=2.0 Y=2.0 Z=2.0
#exec MESH  DEFAULTANIM MESH=SPELLLEVMesh ANIM=SPELLLEVAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SPELLLEVAnims VERBOSE
#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage


#EXEC TEXTURE IMPORT NAME=avifSpellIcon  FILE=TEXTURES\avifSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC MESHMAP SETTEXTURE MESHMAP=SPELLLEVMesh NUM=0 TEXTURE=HPBase.FXPackage.win_p

// Import the pattern
#exec PATTERN IMPORT PATTERN=AvifPattern FILE=Patterns/Avifores.hpg

function PostBeginPlay()
{
	Super.PostBeginPlay();
//	LoopAnim('all', 2.0, 0.0);
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.avifSpellIcon'
     spellName="Avifors"
     CastSound=Sound'HPSounds.magic_sfx.Spells.s_spell_avif_throw'
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.avifors_fly'
     hitParticleEffectClass=Class'HPParticle.avifors_hit'
     reactParticleEffectClass=Class'HPParticle.Avifors_react'
     Gesture=Gesture'HPBase.AvifPattern'
     ImpactSound=Sound'HPSounds.magic_sfx.Spells.s_spell_hit2'
     Style=STY_Translucent
     Mesh=None
}
