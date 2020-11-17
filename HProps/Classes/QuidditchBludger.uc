//===============================================================================
//  [QuidditchBludger] 
//===============================================================================

class QuidditchBludger extends HProps;
#exec MESH  MODELIMPORT MESH=QuidditchBludgerMesh MODELFILE=models\QuidditchBludgerMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=QuidditchBludgerMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=QuidditchBludgerAnims ANIMFILE=models\QuidditchBludgerAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=QuidditchBludgerMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=QuidditchBludgerMesh ANIM=QuidditchBludgerAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=QuidditchBludgerAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=QuidditchBludgerTex0  FILE=TEXTURES\QuidditchBludgerTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=QuidditchBludgerMesh NUM=0 TEXTURE=QuidditchBludgerTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: qbludger_128.bmp  Path: D:\Harry Potter\Art\Objects\Qudditch

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.QuidditchBludgerMesh'
}
