//===============================================================================
//  [tree_01] 
//===============================================================================

class tree_01 extends HProps;
#exec MESH  MODELIMPORT MESH=tree_01Mesh MODELFILE=models\tree_01Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=tree_01Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=tree_01Anims ANIMFILE=models\tree_01Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=tree_01Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=tree_01Mesh ANIM=tree_01Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=tree_01Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=tree_01Tex0  FILE=TEXTURES\tree_01Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=tree_01Tex1  FILE=TEXTURES\tree_01Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=tree_01Mesh NUM=0 TEXTURE=tree_01Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=tree_01Mesh NUM=1 TEXTURE=tree_01Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: TreeBark01_256.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: Branches01_256.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.tree_01Mesh'
}
