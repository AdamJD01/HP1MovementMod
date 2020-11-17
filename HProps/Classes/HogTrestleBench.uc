//===============================================================================
//  [HogTrestleBench] 
//===============================================================================

class HogTrestleBench extends HProps;
#exec MESH  MODELIMPORT MESH=HogTrestleBenchMesh MODELFILE=models\HogTrestleBenchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogTrestleBenchMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogTrestleBenchAnims ANIMFILE=models\HogTrestleBenchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogTrestleBenchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogTrestleBenchMesh ANIM=HogTrestleBenchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogTrestleBenchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogTrestleBenchTex0  FILE=TEXTURES\HogTrestleBenchTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogTrestleBenchMesh NUM=0 TEXTURE=HogTrestleBenchTex0

// Original material [0] is [Material #3] SkinIndex: 0 Bitmap: hogbench_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogTrestleBenchMesh'
}
