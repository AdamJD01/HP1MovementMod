//===============================================================================
//  [ForbidForestTree] 
//===============================================================================

class ForbidForestTree extends HProps;
#exec MESH  MODELIMPORT MESH=ForbidForestTreeMesh MODELFILE=models\ForbidForestTreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ForbidForestTreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ForbidForestTreeAnims ANIMFILE=models\ForbidForestTreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ForbidForestTreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ForbidForestTreeMesh ANIM=ForbidForestTreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ForbidForestTreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ForbidForestTreeTex0  FILE=TEXTURES\ForbidForestTreeTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=ForbidForestTreeTex1  FILE=TEXTURES\ForbidForestTreeTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidForestTreeMesh NUM=0 TEXTURE=ForbidForestTreeTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidForestTreeMesh NUM=1 TEXTURE=ForbidForestTreeTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: FirtreeBark.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.MASKED] SkinIndex: 1 Bitmap: FirtreeBows.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ForbidForestTreeMesh'
}
