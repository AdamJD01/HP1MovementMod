//===============================================================================
//  [GryfPillow1] 
//===============================================================================

class GryfPillow1 extends HProps;
#exec MESH  MODELIMPORT MESH=GryfPillow1Mesh MODELFILE=models\GryfPillow1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfPillow1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfPillow1Anims ANIMFILE=models\GryfPillow1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfPillow1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfPillow1Mesh ANIM=GryfPillow1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfPillow1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfPillow1Tex0  FILE=TEXTURES\GryfPillow1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfPillow1Mesh NUM=0 TEXTURE=GryfPillow1Tex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: gpillow1_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfPillow1Mesh'
}
