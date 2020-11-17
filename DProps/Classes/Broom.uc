//===============================================================================
//  [Broom] 
//===============================================================================

class Broom extends DProps;
#exec MESH  MODELIMPORT MESH=BroomMesh MODELFILE=models\Broom.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=BroomMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=BroomAnims ANIMFILE=models\Broom.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=BroomMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=BroomMesh ANIM=BroomAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=BroomAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=BroomTex0  FILE=TEXTURES\BroomTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=BroomMesh NUM=0 TEXTURE=BroomTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: mopbroom_128.bmp  Path: H:\Art\Models\Objects\Dursley Props

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'DProps.BroomMesh'
}
