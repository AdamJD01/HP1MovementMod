//===============================================================================

class spellVerd extends BASESPELL;
#exec MESH  MODELIMPORT MESH=SPELLLEVMesh MODELFILE=models\LevProjectile.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SPELLLEVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SPELLLEVAnims ANIMFILE=models\LevProjectile.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SPELLLEVMesh X=2.0 Y=2.0 Z=2.0
#exec MESH  DEFAULTANIM MESH=SPELLLEVMesh ANIM=SPELLLEVAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SPELLLEVAnims VERBOSE
#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage

#EXEC TEXTURE IMPORT NAME=verdSpellIcon  FILE=TEXTURES\verdSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC MESHMAP SETTEXTURE MESHMAP=SPELLLEVMesh NUM=0 TEXTURE=HPBase.FXPackage.win_p

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('all', 2.0, 0.0);
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.verdSpellIcon'
     spellName="Verdimillious"
     CastSound=Sound'HPSounds.magic_sfx.Spells.s_spell_verd_throw'
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Verd_fly'
     hitParticleEffectClass=Class'HPParticle.Verd_hit'
     ImpactSound=Sound'HPSounds.magic_sfx.Spells.s_spell_hit4'
     Style=STY_Translucent
}
