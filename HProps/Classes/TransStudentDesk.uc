//===============================================================================
//  [TransStudentDesk] 
//===============================================================================

class TransStudentDesk extends HProps;
#exec MESH  MODELIMPORT MESH=TransStudentDeskMesh MODELFILE=models\TransStudentDeskMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TransStudentDeskMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TransStudentDeskAnims ANIMFILE=models\TransStudentDeskAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TransStudentDeskMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TransStudentDeskMesh ANIM=TransStudentDeskAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TransStudentDeskAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TransStudentDeskTex0  FILE=TEXTURES\TransStudentDeskTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TransStudentDeskMesh NUM=0 TEXTURE=TransStudentDeskTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: StudentDesk_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TransStudentDeskMesh'
}
