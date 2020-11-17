//===============================================================================
//  [GryfChair] 
//===============================================================================

class GryfChair extends HProps;
#exec MESH  MODELIMPORT MESH=GryfChairMesh MODELFILE=models\GryfChairMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfChairMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfChairAnims ANIMFILE=models\GryfChairAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfChairMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfChairMesh ANIM=GryfChairAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfChairAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfChairTex0  FILE=TEXTURES\GryfChairTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfChairMesh NUM=0 TEXTURE=GryfChairTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: gryfsofa_128.bmp  Path: H:\Art\Models\Objects\Working\Lorian\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfChairMesh'
}
