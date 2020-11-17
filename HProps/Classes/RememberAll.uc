//===============================================================================
//  [RememberAll] 
//===============================================================================

class RememberAll extends HProps;
#exec MESH  MODELIMPORT MESH=RememberAllMesh MODELFILE=models\RememberAllMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=RememberAllMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=RememberAllAnims ANIMFILE=models\RememberAllAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=RememberAllMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=RememberAllMesh ANIM=RememberAllAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=RememberAllAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=RememberAllTex0  FILE=TEXTURES\RememberAllTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=RememberAllTex1  FILE=TEXTURES\RememberAllTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=RememberAllMesh NUM=0 TEXTURE=RememberAllTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=RememberAllMesh NUM=1 TEXTURE=RememberAllTex1

// Original material [0] is [rememberall_skin00.TRANSLUCENT] SkinIndex: 0 Bitmap: RememberAll.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [rememberallskin01.TWOSIDED] SkinIndex: 1 Bitmap: RememberAll.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.RememberAllMesh'
}
