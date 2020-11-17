//===============================================================================
//  [TransBlackboard] 
//===============================================================================

class TransBlackboard extends HProps;
#exec MESH  MODELIMPORT MESH=TransBlackboardMesh MODELFILE=models\TransBlackboardMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TransBlackboardMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TransBlackboardAnims ANIMFILE=models\TransBlackboardAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TransBlackboardMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TransBlackboardMesh ANIM=TransBlackboardAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TransBlackboardAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TransBlackboardTex0  FILE=TEXTURES\TransBlackboardTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TransBlackboardMesh NUM=0 TEXTURE=TransBlackboardTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: Blackboard_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TransBlackboardMesh'
}
