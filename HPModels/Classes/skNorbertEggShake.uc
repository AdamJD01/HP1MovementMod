//===============================================================================
//  [skNorbertEggShake] 
//===============================================================================

class skNorbertEggShake extends HPMeshActor;
#exec MESH  MODELIMPORT MESH=skNorbertEggShakeMesh MODELFILE=models\skNorbertEggShakeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skNorbertEggShakeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skNorbertEggShakeAnims ANIMFILE=models\skNorbertEggShakeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skNorbertEggShakeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skNorbertEggShakeMesh ANIM=skNorbertEggShakeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skNorbertEggShakeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skNorbertEggShakeTex0  FILE=TEXTURES\skNorbertEggShakeTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skNorbertEggShakeTex1  FILE=TEXTURES\skNorbertEggShakeTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggShakeMesh NUM=0 TEXTURE=skNorbertEggShakeTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skNorbertEggShakeMesh NUM=1 TEXTURE=skNorbertEggShakeTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: NorbertEggHot.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01] SkinIndex: 1 Bitmap: HagridCoalsFiredUp.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skNorbertEggShakeMesh'
}
