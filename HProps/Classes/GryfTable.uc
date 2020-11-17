//===============================================================================
//  [GryfTable] 
//===============================================================================

class GryfTable extends HProps;
#exec MESH  MODELIMPORT MESH=GryfTableMesh MODELFILE=models\GryfTableMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfTableMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfTableAnims ANIMFILE=models\GryfTableAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfTableMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfTableMesh ANIM=GryfTableAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfTableAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfTableTex0  FILE=TEXTURES\GryfTableTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfTableMesh NUM=0 TEXTURE=GryfTableTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: grytable_128.bmp  Path: H:\Art\Models\Objects\Working\Lorian\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfTableMesh'
}
