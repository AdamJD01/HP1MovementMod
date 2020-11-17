//===============================================================================
//  [QudditchBroom] 
//===============================================================================

class QudditchBroom extends HProps;
#exec MESH  MODELIMPORT MESH=QudditchBroomMesh MODELFILE=models\QudditchBroomMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=QudditchBroomMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=QudditchBroomAnims ANIMFILE=models\QudditchBroomAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=QudditchBroomMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=QudditchBroomMesh ANIM=QudditchBroomAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=QudditchBroomAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=QudditchBroomTex0  FILE=TEXTURES\QudditchBroomTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=QudditchBroomMesh NUM=0 TEXTURE=QudditchBroomTex0

// Original material [0] is [SKIN04] SkinIndex: 4 Bitmap: QUID_SKIN01.bmp  Path: D:\Harry Potter\Art\Characters\Harry Rememberall

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.QudditchBroomMesh'
}
