//===============================================================================
//  [WizardHat] 
//===============================================================================

class WizardHat extends HProps;
#exec MESH  MODELIMPORT MESH=WizardHatMesh MODELFILE=models\WizardHatMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WizardHatMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WizardHatAnims ANIMFILE=models\WizardHatAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WizardHatMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WizardHatMesh ANIM=WizardHatAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WizardHatAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WizardHatTex0  FILE=TEXTURES\WizardHatTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WizardHatMesh NUM=0 TEXTURE=WizardHatTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: wizardhat_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WizardHatMesh'
}
