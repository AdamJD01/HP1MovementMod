//===============================================================================

class spellFlip extends BASESPELL;

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
#exec PATTERN IMPORT PATTERN=FlipPattern FILE=Patterns/Flipendo.hpg

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('all', 2.0, 0.0);
}

//    ImpactSound=Sound'HPSounds.magic_sfx.s_spell_Alohomora_hit'
//    CastSound=Sound'HPSounds.magic_sfx.s_spell_throw5'

// AE:
function PlayIncantateSound(bool bSneaking)
{
	if( bSneaking )
	{
		switch( Rand(3) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.QSpells10_b_q');	break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.QSpells10_c_q');	break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.QSpells10_q');		break;
		}
	}
	else
	{
		switch( Rand(5) )
		{
			case 0:	PlaySound(sound'HPSounds.Har_inc.Spells1_a_2edit');	break;
			case 1:	PlaySound(sound'HPSounds.Har_inc.Spells1_b');		break;
			case 2:	PlaySound(sound'HPSounds.Har_inc.Spells1_d');		break;
			case 3:	PlaySound(sound'HPSounds.Har_inc.Spells1_e');		break;
			case 4:	PlaySound(sound'HPSounds.Har_inc.Spells1_f');		break;
		}
	}
}

defaultproperties
{
     //spellIcon=Texture'HPBase.Icons.alohoSpellIcon' //not needed -AdamJD
     spellName="Flipendo"
     SpellIncantation="spells1"
     QuietSpellIncantation="spells10"
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Flip_fly'
     hitParticleEffectClass=Class'HPParticle.Flip_hit'
     Gesture=Gesture'HPBase.FlipPattern'
     Speed=600
     DrawType=DT_None
     Style=STY_Translucent
}
