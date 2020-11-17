//===============================================================================
//  [TransTeachersDesk] 
//===============================================================================

class TransTeachersDesk extends baseProps;
//#EXEC MESH  MODELIMPORT MESH=TransTeachersDeskMesh MODELFILE=models\TransTeachersDesk.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=TransTeachersDeskMesh X=0 Y=0 Z=40 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=TransTeachersDeskAnims ANIMFILE=models\TransTeachersDesk.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=TransTeachersDeskMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=TransTeachersDeskMesh ANIM=TransTeachersDeskAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=TransTeachersDeskAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=TransTeachersDeskTex0  FILE=TEXTURES\TeacherDesk_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=TransTeachersDeskMesh NUM=0 TEXTURE=TransTeachersDeskTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: TeacherDesk_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class 


auto state defaultState
{

	begin:
	setPhysics(phys_walking);

}

defaultproperties
{
     bCanTransform=True
     transformInto=Class'HarryPotter.pig'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.TransTeachersDeskMesh'
}
