//===============================================================================

class spellAloho extends BASESPELL;
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

//    ImpactSound=Sound'HPSounds.magic_sfx.s_spell_Alohomora_hit'
//   CastSound=Sound'HPSounds.magic_sfx.s_spell_throw5'
 
// AE:
function PlayIncantateSound(bool bSneaking)
{
	if( bSneaking )
	{
		PlaySound(sound'HPSounds.Har_inc.QSpells4_q');
	}
	else
	{
		switch( Rand(3) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.Spells3');		break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.Spells3_a');	break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.Spells3_e');	break;
		}
	}
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.alohoSpellIcon'
     spellName="Alohomora"
     SpellIncantation="spells3"
     QuietSpellIncantation="spells4"
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Aloh_Fly'
     hitParticleEffectClass=Class'HPParticle.Aloh_hit'
     Gesture=Gesture'HPBase.AlohoPattern'
     GestureParticleEffectClass=Class'HPParticle.SpellShape_Aloh'
     Style=STY_Translucent
}
