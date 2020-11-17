//===============================================================================
//  [GryfChair2] 
//===============================================================================

class GryfChair2 extends HProps;
#exec MESH  MODELIMPORT MESH=GryfChair2Mesh MODELFILE=models\GryfChair2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfChair2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfChair2Anims ANIMFILE=models\GryfChair2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfChair2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfChair2Mesh ANIM=GryfChair2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfChair2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfChair2Tex0  FILE=TEXTURES\GryfChair2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfChair2Mesh NUM=0 TEXTURE=GryfChair2Tex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: grychair_128.bmp  Path: D:\Harry Potter\Art\Objects\Seventh Floor\Chairs

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfChair2Mesh'
}
