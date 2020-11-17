//===============================================================================
//  [skgoldchest] 
//===============================================================================

class skgoldchest extends actor;
#exec MESH  MODELIMPORT MESH=skgoldchestMesh MODELFILE=models\skgoldchestMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skgoldchestMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skgoldchestAnims ANIMFILE=models\skgoldchestAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skgoldchestMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skgoldchestMesh ANIM=skgoldchestAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skgoldchestAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skgoldchestTex0  FILE=TEXTURES\skgoldchestTex0.BMP  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skgoldchestMesh NUM=0 TEXTURE=skgoldchestTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: gldtrunk_128.BMP  Path: C:\Nathan

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skgoldchestMesh'
}
