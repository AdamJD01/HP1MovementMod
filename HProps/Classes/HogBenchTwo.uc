//===============================================================================
//  [HogBenchTwo] 
//===============================================================================

class HogBenchTwo extends HProps;
#exec MESH  MODELIMPORT MESH=HogBenchTwoMesh MODELFILE=models\HogBenchTwoMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogBenchTwoMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogBenchTwoAnims ANIMFILE=models\HogBenchTwoAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogBenchTwoMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogBenchTwoMesh ANIM=HogBenchTwoAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogBenchTwoAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogBenchTwoTex0  FILE=TEXTURES\HogBenchTwoTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogBenchTwoMesh NUM=0 TEXTURE=HogBenchTwoTex0

// Original material [0] is [Material #7] SkinIndex: 0 Bitmap: HWbenchT_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogBenchTwoMesh'
}
