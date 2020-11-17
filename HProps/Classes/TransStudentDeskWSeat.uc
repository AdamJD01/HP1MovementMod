//===============================================================================
//  [TransStudentDeskWSeat] 
//===============================================================================

class TransStudentDeskWSeat extends HProps;
#exec MESH  MODELIMPORT MESH=TransStudentDeskWSeatMesh MODELFILE=models\TransStudentDeskWSeatMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TransStudentDeskWSeatMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TransStudentDeskWSeatAnims ANIMFILE=models\TransStudentDeskWSeatAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TransStudentDeskWSeatMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TransStudentDeskWSeatMesh ANIM=TransStudentDeskWSeatAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TransStudentDeskWSeatAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TransStudentDeskWSeatTex0  FILE=TEXTURES\TransStudentDeskWSeatTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TransStudentDeskWSeatMesh NUM=0 TEXTURE=TransStudentDeskWSeatTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: StudentDesk_128.bmp  Path: P:\Art\Models\Objects\Hogwarts Props\Transfigurations Class\Student Desk

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TransStudentDeskWSeatMesh'
}
