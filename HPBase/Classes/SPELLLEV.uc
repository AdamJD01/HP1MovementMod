//===============================================================================
//  [SPELLLEV] 
//===============================================================================

class SPELLLEV extends BASESPELL;
#exec MESH  MODELIMPORT MESH=SPELLLEVMesh MODELFILE=models\LevProjectile.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SPELLLEVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SPELLLEVAnims ANIMFILE=models\LevProjectile.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SPELLLEVMesh X=2.0 Y=2.0 Z=2.0
#exec MESH  DEFAULTANIM MESH=SPELLLEVMesh ANIM=SPELLLEVAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SPELLLEVAnims VERBOSE

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage

//#EXEC TEXTURE IMPORT NAME=SPELLLEVTex0  FILE=TEXTURES\Lev.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=SPELLLEVMesh NUM=0 TEXTURE=SPELLLEVTex0

#EXEC MESHMAP SETTEXTURE MESHMAP=SPELLLEVMesh NUM=0 TEXTURE=HPBase.FXPackage.win_p

#EXEC TEXTURE IMPORT NAME=levSpellIcon  FILE=TEXTURES\levSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: Lev.bmp  Path: C:\HarryPotter\FX 

// Import the pattern
#exec PATTERN IMPORT PATTERN=LevPattern FILE=Patterns/Wingardium.hpg

//    ImpactSound=Sound'HPSounds.magic_sfx.s_lev_hit'
//    CastSound=Sound'HPSounds.magic_sfx.s_spell_wing_throw'

// AE:
function PlayIncantateSound(bool bSneaking)
{
	if( bSneaking )
	{
		switch( Rand(2) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.QSpells7_1_q');	break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.QSpells7_3_q');	break;
		}
	}
	else
	{
		switch( Rand(7) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.Spells2');		break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.Spells2_a');	break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.Spells2_b');	break;
			case 3:	PlaySound(sound'HPSounds.Har_inc.Spells2_c');	break;
			case 5:	PlaySound(sound'HPSounds.Har_inc.Spells2_f');	break;
			case 6:	PlaySound(sound'HPSounds.Har_inc.Spells2_g');	break;
		}
	}
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.levSpellIcon'
     spellName="Levitate"
     SpellIncantation="spells2"
     QuietSpellIncantation="spells7"
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Wing_fly'
     hitParticleEffectClass=Class'HPParticle.Wing_hit'
     Gesture=Gesture'HPBase.LevPattern'
     GestureParticleEffectClass=Class'HPParticle.SpellShape_Wing'
     Style=STY_Translucent
     Mesh=None
}
