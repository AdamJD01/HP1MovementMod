//===============================================================================
//  [HogBigBook] 
//===============================================================================

class HogBigBook extends HProps;
#exec MESH  MODELIMPORT MESH=HogBigBookMesh MODELFILE=models\HogBigBookMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogBigBookMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogBigBookAnims ANIMFILE=models\HogBigBookAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogBigBookMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogBigBookMesh ANIM=HogBigBookAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogBigBookAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogBigBookTex0  FILE=TEXTURES\HogBigBookTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogBigBookMesh NUM=0 TEXTURE=HogBigBookTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: bigflitb_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogBigBookMesh'
}
