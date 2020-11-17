//===============================================================================
//  [MapleTree] 
//===============================================================================

class MapleTree extends HProps;
#exec MESH  MODELIMPORT MESH=MapleTreeMesh MODELFILE=models\MapleTreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=MapleTreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=MapleTreeAnims ANIMFILE=models\MapleTreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=MapleTreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=MapleTreeMesh ANIM=MapleTreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=MapleTreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=MapleTreeTex0  FILE=TEXTURES\MapleTreeTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=MapleTreeTex1  FILE=TEXTURES\MapleTreeTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=MapleTreeTex2  FILE=TEXTURES\MapleTreeTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=MapleTreeMesh NUM=0 TEXTURE=MapleTreeTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=MapleTreeMesh NUM=1 TEXTURE=MapleTreeTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=MapleTreeMesh NUM=2 TEXTURE=MapleTreeTex2

// Original material [0] is [skin00] SkinIndex: 0 Bitmap: MapletreeBark.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [skin01.TWOSIDED] SkinIndex: 1 Bitmap: MapleTreeBranches.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [2] is [skin02.TWOSIDED] SkinIndex: 2 Bitmap: MapleTreeCanopy.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.MapleTreeMesh'
}
