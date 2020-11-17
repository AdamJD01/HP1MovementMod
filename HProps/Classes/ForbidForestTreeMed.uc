//===============================================================================
//  [ForbidForestTreeMed] 
//===============================================================================

class ForbidForestTreeMed extends HProps;
#exec MESH  MODELIMPORT MESH=ForbidForestTreeMedMesh MODELFILE=models\ForbidForestTreeMedMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ForbidForestTreeMedMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ForbidForestTreeMedAnims ANIMFILE=models\ForbidForestTreeMedAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ForbidForestTreeMedMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ForbidForestTreeMedMesh ANIM=ForbidForestTreeMedAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ForbidForestTreeMedAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ForbidForestTreeMedTex0  FILE=TEXTURES\ForbidForestTreeMedTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=ForbidForestTreeMedTex1  FILE=TEXTURES\ForbidForestTreeMedTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidForestTreeMedMesh NUM=0 TEXTURE=ForbidForestTreeMedTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidForestTreeMedMesh NUM=1 TEXTURE=ForbidForestTreeMedTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: FirtreeBark.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.MASKED] SkinIndex: 1 Bitmap: FirtreeBows.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ForbidForestTreeMedMesh'
}
