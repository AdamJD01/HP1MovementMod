//===============================================================================
//  [ChristmasTree] 
//===============================================================================

class ChristmasTree extends HProps;
#exec MESH  MODELIMPORT MESH=ChristmasTreeMesh MODELFILE=models\ChristmasTreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ChristmasTreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ChristmasTreeAnims ANIMFILE=models\ChristmasTreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ChristmasTreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ChristmasTreeMesh ANIM=ChristmasTreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ChristmasTreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ChristmasTreeTex0  FILE=TEXTURES\ChristmasTreeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ChristmasTreeMesh NUM=0 TEXTURE=ChristmasTreeTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: christree_256.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Christmas Tree

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ChristmasTreeMesh'
}
