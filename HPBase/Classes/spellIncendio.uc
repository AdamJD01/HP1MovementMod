//===============================================================================

class spellIncendio extends BASESPELL;
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
#exec PATTERN IMPORT PATTERN=IncendioPattern FILE=Patterns/Incendio.hpg

//    ImpactSound=Sound'HPSounds.magic_sfx.s_spell_Alohomora_hit'
//    CastSound=Sound'HPSounds.magic_sfx.s_spell_throw5'

// AE:
function PlayIncantateSound(bool bSneaking)
{
	if( bSneaking )
	{
		switch( Rand(3) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.QSpells9_a_q');	break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.QSpells9_b_q');	break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.QSpells9_c_q');	break;
		}
	}
	else
	{
		switch( Rand(3) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.Spells5');		break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.Spells5_a');	break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.Spells5_b');	break;
		}
	}
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.alohoSpellIcon'
     spellName="Incendio"
     SpellIncantation="spells5"
     QuietSpellIncantation="spells9"
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Incend_fly'
     hitParticleEffectClass=Class'HPParticle.Incend_hit'
     Gesture=Gesture'HPBase.IncendioPattern'
     GestureParticleEffectClass=Class'HPParticle.SpellShape_Incend'
     Speed=500
     Style=STY_Translucent
     Mesh=None
}
