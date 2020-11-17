//===============================================================================
//  [StorageChair] 
//===============================================================================

class StorageChair extends HProps;
#exec MESH  MODELIMPORT MESH=StorageChairMesh MODELFILE=models\StorageChairMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=StorageChairMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=StorageChairAnims ANIMFILE=models\StorageChairAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=StorageChairMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=StorageChairMesh ANIM=StorageChairAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=StorageChairAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=StorageChairTex0  FILE=TEXTURES\StorageChairTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=StorageChairMesh NUM=0 TEXTURE=StorageChairTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: chairsheet_128.bmp  Path: D:\Harry Potter\Art\Objects\Forbidden Corridor\draped chair

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.StorageChairMesh'
}
