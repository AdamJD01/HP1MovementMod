//===============================================================================
//  [ForbidForestTreeSM] 
//===============================================================================

class ForbidForestTreeSM extends HProps;
#exec MESH  MODELIMPORT MESH=ForbidForestTreeSMMesh MODELFILE=models\ForbidForestTreeSMMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ForbidForestTreeSMMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ForbidForestTreeSMAnims ANIMFILE=models\ForbidForestTreeSMAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ForbidForestTreeSMMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ForbidForestTreeSMMesh ANIM=ForbidForestTreeSMAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ForbidForestTreeSMAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ForbidForestTreeSMTex0  FILE=TEXTURES\ForbidForestTreeSMTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=ForbidForestTreeSMTex1  FILE=TEXTURES\ForbidForestTreeSMTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidForestTreeSMMesh NUM=0 TEXTURE=ForbidForestTreeSMTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidForestTreeSMMesh NUM=1 TEXTURE=ForbidForestTreeSMTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: BirchBark.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.TWOSIDED] SkinIndex: 1 Bitmap: BirchtreeBows.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ForbidForestTreeSMMesh'
}
