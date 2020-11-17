//===============================================================================
//  [GryfPillow2] 
//===============================================================================

class GryfPillow2 extends HProps;
#exec MESH  MODELIMPORT MESH=GryfPillow2Mesh MODELFILE=models\GryfPillow2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfPillow2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfPillow2Anims ANIMFILE=models\GryfPillow2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfPillow2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfPillow2Mesh ANIM=GryfPillow2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfPillow2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfPillow2Tex0  FILE=TEXTURES\GryfPillow2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfPillow2Mesh NUM=0 TEXTURE=GryfPillow2Tex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: gpillow2_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfPillow2Mesh'
}
