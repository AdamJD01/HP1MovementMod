//===============================================================================
//  [WizCrackerConfetti] 
//===============================================================================

class WizCrackerConfetti2 extends actor;

#exec MESH  MODELIMPORT MESH=WizCrackerConfettiMesh MODELFILE=models\WizCrackerConfettiMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WizCrackerConfettiMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WizCrackerConfettiAnims ANIMFILE=models\WizCrackerConfettiAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WizCrackerConfettiMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WizCrackerConfettiMesh ANIM=WizCrackerConfettiAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WizCrackerConfettiAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WizCrackerConfettiTex0  FILE=TEXTURES\WizCrackerConfettiTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WizCrackerConfettiMesh NUM=0 TEXTURE=WizCrackerConfettiTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: confetti_8.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Wizard Cracker

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.WizCrackerConfettiMesh'
}
