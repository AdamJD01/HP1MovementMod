//===============================================================================
//  [GryfBench] 
//===============================================================================

class GryfBench extends HProps;
#exec MESH  MODELIMPORT MESH=GryfBenchMesh MODELFILE=models\GryfBenchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfBenchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfBenchAnims ANIMFILE=models\GryfBenchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfBenchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfBenchMesh ANIM=GryfBenchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfBenchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfBenchTex0  FILE=TEXTURES\GryfBenchTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfBenchMesh NUM=0 TEXTURE=GryfBenchTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: grybench_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfBenchMesh'
}
