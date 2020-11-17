//===============================================================================
//  [BirchTree] 
//===============================================================================

class BirchTree extends HProps;
#exec MESH  MODELIMPORT MESH=BirchTreeMesh MODELFILE=models\BirchTreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BirchTreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BirchTreeAnims ANIMFILE=models\BirchTreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BirchTreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BirchTreeMesh ANIM=BirchTreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BirchTreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BirchTreeTex0  FILE=TEXTURES\BirchTreeTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=BirchTreeTex1  FILE=TEXTURES\BirchTreeTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BirchTreeMesh NUM=0 TEXTURE=BirchTreeTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=BirchTreeMesh NUM=1 TEXTURE=BirchTreeTex1

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: BirchBark2.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.TWOSIDED] SkinIndex: 1 Bitmap: BirchTreeBranches.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BirchTreeMesh'
}
