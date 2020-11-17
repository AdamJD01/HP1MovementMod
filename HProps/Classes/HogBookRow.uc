//===============================================================================
//  [HogBookRow] 
//===============================================================================

class HogBookRow extends HProps;
#exec MESH  MODELIMPORT MESH=HogBookRowMesh MODELFILE=models\HogBookRowMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogBookRowMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogBookRowAnims ANIMFILE=models\HogBookRowAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogBookRowMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogBookRowMesh ANIM=HogBookRowAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogBookRowAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogBookRowTex0  FILE=TEXTURES\HogBookRowTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogBookRowMesh NUM=0 TEXTURE=HogBookRowTex0

// Original material [0] is [Material #7] SkinIndex: 0 Bitmap: BookStck2_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogBookRowMesh'
}
