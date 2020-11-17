//===============================================================================
//  [skron] 
//===============================================================================

class skron extends actor;
//#EXEC MESH  MODELIMPORT MESH=skronMesh MODELFILE=models\skron.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skronMesh X=0 Y=0 Z=42 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skronAnims ANIMFILE=models\skron.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skronMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skronMesh ANIM=skronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skronAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skronTex0  FILE=TEXTURES\RON_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skronTex1  FILE=TEXTURES\RON_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skronTex2  FILE=TEXTURES\RON_SKIN02.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skronMesh NUM=0 TEXTURE=skronTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skronMesh NUM=1 TEXTURE=skronTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skronMesh NUM=2 TEXTURE=skronTex2

//#EXEC MESH WEAPONATTACH MESH=skRonMesh BONE="RightHand"
//#EXEC MESH WEAPONPOSITION MESH=skRonMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0

//#EXEC ANIM NOTIFY   ANIM=skronAnims SEQ=run TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skronAnims SEQ=run TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: RON_SKIN00.bmp  Path: H:\Art\Design\Character Development\Ron\RonNew 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: RON_SKIN01.bmp  Path: H:\Art\Design\Character Development\Ron\RonNew 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: RON_SKIN02.bmp  Path: H:\Art\Design\Character Development\Ron\RonNew

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skronMesh'
}
