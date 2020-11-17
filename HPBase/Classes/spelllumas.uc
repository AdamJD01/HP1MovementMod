//===============================================================================

class spelllumas extends BASESPELL;

//Edited by- AdamJD (edited code will have AdamJD by it)

#exec MESH  MODELIMPORT MESH=SPELLLEVMesh MODELFILE=models\LevProjectile.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SPELLLEVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SPELLLEVAnims ANIMFILE=models\LevProjectile.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SPELLLEVMesh X=2.0 Y=2.0 Z=2.0
#exec MESH  DEFAULTANIM MESH=SPELLLEVMesh ANIM=SPELLLEVAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SPELLLEVAnims VERBOSE
#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage

//#EXEC TEXTURE IMPORT NAME=alohoSpellIcon  FILE=TEXTURES\alohoSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF //not needed -AdamJD

#EXEC MESHMAP SETTEXTURE MESHMAP=SPELLLEVMesh NUM=0 TEXTURE=HPBase.FXPackage.win_p


// Import the pattern
#exec PATTERN IMPORT PATTERN=LumosPattern FILE=Patterns/Lumos.hpg

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('all', 2.0, 0.0);
}

//   ImpactSound=Sound'HPSounds.magic_sfx.s_spell_Alohomora_hit'
//    CastSound=Sound'HPSounds.magic_sfx.s_spell_throw5'
 
// AE:
function PlayIncantateSound(bool bSneaking)
{
	if( bSneaking )
	{
		PlaySound(sound'HPSounds.Har_inc.QSpells13_q');
	}
	else
	{
		switch( Rand(4) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.lumos6');		break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.lumos7');		break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.lumos8');		break;
			case 3:	PlaySound(sound'HPSounds.Har_inc.Spells12');	break;
		}
	}
}

defaultproperties
{
     //spellIcon=Texture'HPBase.Icons.alohoSpellIcon' //not needed -AdamJD
     spellName="Lumas"
     SpellIncantation="spells12"
     QuietSpellIncantation="spells13"
     flyParticleEffectClass=Class'HPParticle.Lumos_fly'
     hitParticleEffectClass=Class'HPParticle.Lumos_hit'
     Gesture=Gesture'HPBase.LumosPattern'
     GestureParticleEffectClass=Class'HPParticle.SpellShape_Lumos'
     LifeSpan=3.3
     DrawType=DT_None
     Style=STY_Translucent
}
