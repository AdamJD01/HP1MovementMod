//===============================================================================
//  [SPELLLEV] 
//===============================================================================

class SPELLPostLEV extends BASESPELL;
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
var rotator rot;

function tick(float deltatime)
{
		rot=rotator(location-target.location);
	//	setrotation(rot);
		super.tick(deltatime);
	



}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.levSpellIcon'
     spellName="Levitate"
     CastSound=None
     hitEffect=Class'HPBase.levHitEffect'
     flyParticleEffectClass=Class'HPParticle.Levitate_hold'
     Gesture=Gesture'HPBase.LevPattern'
     Speed=900
     MaxSpeed=10000
     ImpactSound=None
     Style=STY_Translucent
     Mesh=None
     RotationRate=(Pitch=100000,Yaw=800000,Roll=100000)
}
