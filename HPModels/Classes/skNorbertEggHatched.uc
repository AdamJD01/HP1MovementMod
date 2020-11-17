//===============================================================================
//  [skNorbertEggHatched] 
//===============================================================================

class skNorbertEggHatched extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skNorbertEggHatchedMesh MODELFILE=models\skNorbertEggHatchedMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skNorbertEggHatchedMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skNorbertEggHatchedAnims ANIMFILE=models\skNorbertEggHatchedAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skNorbertEggHatchedMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skNorbertEggHatchedMesh ANIM=skNorbertEggHatchedAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skNorbertEggHatchedAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skNorbertEggHatchedTex0  FILE=TEXTURES\skNorbertEggHatchedTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skNorbertEggHatchedTex1  FILE=TEXTURES\skNorbertEggHatchedTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggHatchedMesh NUM=0 TEXTURE=skNorbertEggHatchedTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggHatchedMesh NUM=1 TEXTURE=skNorbertEggHatchedTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: HagridCoalsFiredUp.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.TWOSIDED] SkinIndex: 1 Bitmap: NorbertEggCracked.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
}
