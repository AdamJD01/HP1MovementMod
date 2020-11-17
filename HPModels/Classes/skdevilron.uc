//===============================================================================
//  [skdevilron] 
//===============================================================================

class skdevilron extends HPMeshActor;
#exec MESH  MODELIMPORT MESH=skdevilronMesh MODELFILE=models\skdevilronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skdevilronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skdevilronAnims ANIMFILE=models\skdevilronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skdevilronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skdevilronMesh ANIM=skdevilronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skdevilronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skdevilronTex0  FILE=TEXTURES\skdevilronTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilronTex1  FILE=TEXTURES\skdevilronTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilronTex2  FILE=TEXTURES\skdevilronTex2.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilronTex3  FILE=TEXTURES\skdevilronTex3.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilronTex4  FILE=TEXTURES\skdevilronTex4.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilronMesh NUM=0 TEXTURE=skdevilronTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilronMesh NUM=1 TEXTURE=skdevilronTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilronMesh NUM=2 TEXTURE=skdevilronTex2
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilronMesh NUM=3 TEXTURE=skdevilronTex3
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilronMesh NUM=4 TEXTURE=skdevilronTex4

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: RON_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Ron\RonNew 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: RON_SKIN01.bmp  Path: D:\Harry Potter\Art\Characters\Ron Weasley 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: RON_SKIN02.bmp  Path: D:\Harry Potter\Art\Characters\Ron Weasley 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: DEVILPLANT_SKIN00.bmp  Path: H:\Art\Design\Creatures\Devil's Snare 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: DEVILPLANT_SKIN01.bmp  Path: H:\Art\Design\Creatures\Devil's Snare

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdevilronMesh'
}
