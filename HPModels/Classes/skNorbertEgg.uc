//===============================================================================
//  [skNorbertEgg] 
//===============================================================================

class skNorbertEgg extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skNorbertEggMesh MODELFILE=models\skNorbertEggMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skNorbertEggMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skNorbertEggAnims ANIMFILE=models\skNorbertEggAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skNorbertEggMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skNorbertEggMesh ANIM=skNorbertEggAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skNorbertEggAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skNorbertEggTex0  FILE=TEXTURES\skNorbertEggTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skNorbertEggTex1  FILE=TEXTURES\skNorbertEggTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggMesh NUM=0 TEXTURE=skNorbertEggTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggMesh NUM=1 TEXTURE=skNorbertEggTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: HagridCoals.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01] SkinIndex: 1 Bitmap: NorbertEggWarm.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
}
