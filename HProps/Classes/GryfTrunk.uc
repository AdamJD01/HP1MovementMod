//===============================================================================
//  [GryfTrunk] 
//===============================================================================

class GryfTrunk extends HProps;
#exec MESH  MODELIMPORT MESH=GryfTrunkMesh MODELFILE=models\GryfTrunkMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfTrunkMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfTrunkAnims ANIMFILE=models\GryfTrunkAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfTrunkMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfTrunkMesh ANIM=GryfTrunkAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfTrunkAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfTrunkTex0  FILE=TEXTURES\GryfTrunkTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfTrunkMesh NUM=0 TEXTURE=GryfTrunkTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: hogtrunk_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfTrunkMesh'
}
