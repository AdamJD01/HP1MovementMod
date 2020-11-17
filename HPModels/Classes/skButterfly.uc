//===============================================================================
//  [skButterfly] 
//===============================================================================

class skButterfly extends Actor;
#exec MESH  MODELIMPORT MESH=skButterflyMesh MODELFILE=models\skButterflyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skButterflyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skButterflyAnims ANIMFILE=models\skButterflyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skButterflyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skButterflyMesh ANIM=skButterflyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skButterflyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skButterflyTex0  FILE=TEXTURES\skButterflyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skButterflyMesh NUM=0 TEXTURE=skButterflyTex0

// Original material [0] is [skin00.TWOSIDED] SkinIndex: 0 Bitmap: Butterfly.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures\GeneralObjects

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skButterflyMesh'
}
