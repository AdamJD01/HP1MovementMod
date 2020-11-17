//===============================================================================
//  [skHagridNorbert] 
//===============================================================================

class skHagridNorbert extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skHagridNorbertMesh MODELFILE=models\skHagridNorbertMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skHagridNorbertMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skHagridNorbertAnims ANIMFILE=models\skHagridNorbertAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skHagridNorbertMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skHagridNorbertMesh ANIM=skHagridNorbertAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skHagridNorbertAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skHagridNorbertTex0  FILE=TEXTURES\skHagridNorbertTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skHagridNorbertTex1  FILE=TEXTURES\skHagridNorbertTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skHagridNorbertTex2  FILE=TEXTURES\skHagridNorbertTex2.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skHagridNorbertTex3  FILE=TEXTURES\skHagridNorbertTex3.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skHagridNorbertMesh NUM=0 TEXTURE=skHagridNorbertTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skHagridNorbertMesh NUM=1 TEXTURE=skHagridNorbertTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skHagridNorbertMesh NUM=2 TEXTURE=skHagridNorbertTex2
#EXEC MESHMAP SETTEXTURE MESHMAP=skHagridNorbertMesh NUM=3 TEXTURE=skHagridNorbertTex3

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HAGRID_SKIN00.bmp  Path: C:\POTTER\HarryPotter\Textures 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HAGRID_SKIN01.bmp  Path: C:\POTTER\HarryPotter\Textures 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: NORBERT_SKIN00.bmp  Path: C:\POTTER\HPModels\TEXTURES 
// Original material [3] is [SKIN03.TWOSIDED] SkinIndex: 3 Bitmap: NORBERT_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Hagrid_Norb

defaultproperties
{
}
