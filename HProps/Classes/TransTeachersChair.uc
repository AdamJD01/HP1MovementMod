//===============================================================================
//  [TransTeachersChair] 
//===============================================================================

class TransTeachersChair extends HProps;
#exec MESH  MODELIMPORT MESH=TransTeachersChairMesh MODELFILE=models\TransTeachersChairMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TransTeachersChairMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TransTeachersChairAnims ANIMFILE=models\TransTeachersChairAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TransTeachersChairMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TransTeachersChairMesh ANIM=TransTeachersChairAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TransTeachersChairAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TransTeachersChairTex0  FILE=TEXTURES\TransTeachersChairTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TransTeachersChairMesh NUM=0 TEXTURE=TransTeachersChairTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: TeacherChair_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TransTeachersChairMesh'
}
