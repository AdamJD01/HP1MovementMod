//===============================================================================
//  [skBroomHoop] 
//===============================================================================

class skBroomHoop extends HProps;
#exec MESH  MODELIMPORT MESH=BroomHoopMesh MODELFILE=models\BroomHoopMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BroomHoopMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BroomHoopAnims ANIMFILE=models\BroomHoopAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BroomHoopMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BroomHoopMesh ANIM=BroomHoopAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BroomHoopAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BroomHoopTex0  FILE=TEXTURES\BroomHoopTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BroomHoopMesh NUM=0 TEXTURE=BroomHoopTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: line.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Qudditch

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.BroomHoopMesh'
}
