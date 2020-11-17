//===============================================================================
//  [HogBookStack2] 
//===============================================================================

class HogBookStack2 extends HProps;
#exec MESH  MODELIMPORT MESH=HogBookStack2Mesh MODELFILE=models\HogBookStack2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogBookStack2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogBookStack2Anims ANIMFILE=models\HogBookStack2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogBookStack2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogBookStack2Mesh ANIM=HogBookStack2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogBookStack2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogBookStack2Tex0  FILE=TEXTURES\HogBookStack2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogBookStack2Mesh NUM=0 TEXTURE=HogBookStack2Tex0

// Original material [0] is [Material #8] SkinIndex: 0 Bitmap: BookRow2_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogBookStack2Mesh'
}
