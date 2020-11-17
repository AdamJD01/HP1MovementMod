//===============================================================================
//  [skNorbertEggShakeCracked] 
//===============================================================================

class skNorbertEggShakeCracked extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skNorbertEggShakeCrackedMesh MODELFILE=models\skNorbertEggShakeCrackedMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skNorbertEggShakeCrackedMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skNorbertEggShakeCrackedAnims ANIMFILE=models\skNorbertEggShakeCrackedAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skNorbertEggShakeCrackedMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skNorbertEggShakeCrackedMesh ANIM=skNorbertEggShakeCrackedAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skNorbertEggShakeCrackedAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skNorbertEggShakeCrackedTex0  FILE=TEXTURES\skNorbertEggShakeCrackedTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skNorbertEggShakeCrackedTex1  FILE=TEXTURES\skNorbertEggShakeCrackedTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggShakeCrackedMesh NUM=0 TEXTURE=skNorbertEggShakeCrackedTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggShakeCrackedMesh NUM=1 TEXTURE=skNorbertEggShakeCrackedTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: HagridCoalsFiredUp.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01] SkinIndex: 1 Bitmap: NorbertEggCracked.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
}
