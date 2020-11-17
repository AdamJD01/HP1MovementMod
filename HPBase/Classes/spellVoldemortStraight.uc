//===============================================================================

class spellVoldemortStraight extends baseSpell;

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

function Touch(Actor Other)
{
Log("************* Touch:"$Other);
	//if( !Other.bBlockActors ) //for non blocking actors, Projectile::Touch wont call ProcessTouch
	//	ProcessTouch(Other, Location);
	//else
		super.Touch(Other);

	if( baseHarry(Other) != none )
		baseHarry(Other).TakeDamage( Damage, none, Vect(0,0,0), Vect(0,0,0), '');
}

//*****************************************************************************
//Then, I also have to do my own ProcessTouch here, cause the spell will be destroyed otherwise.
//function ProcessTouch (Actor Other, vector HitLocation)
//{
//	local bool  bSpawnHitEffects;
//local baseHarry playerHarry;
//foreach allactors(class'baseHarry', playerHarry)
//	break;
//
//playerHarry.ClientMessage("**** VoldSpell hit "$Other);
//
//	if( baseChar(Other) != None )
//	{
//		if(baseChar(Other).TakeSpellEffect(self))
//			bSpawnHitEffects = true;
//	}
//
//	if( bSpawnHitEffects )
//	{
//		playerHarry.ClientMessage("**** "$Other$" took VoldSpell");
//		SpawnHitEffects( Other, HitLocation );
//	}
//} 






//*****************************************************************************
// If you change the speed value, make sure you update the function ShootStraightSpellAtHarry() in BaseBossQuirrel.
//  I dont know how to dig the default property out of an actor that doesn't exist.

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.alohoSpellIcon'
     spellName="Alohomora"
     CastSound=Sound'HPSounds.magic_sfx.Spells.s_spell_throw5'
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.SpellVoldStraightFX'
     hitParticleEffectClass=Class'HPParticle.SmokeExplo_01'
     Gesture=Gesture'HPBase.AlohoPattern'
     Speed=575
     Damage=10
     ImpactSound=None
     DrawType=DT_None
     Style=STY_Translucent
     Mesh=None
     CollisionRadius=15
     bBounce=True
}
