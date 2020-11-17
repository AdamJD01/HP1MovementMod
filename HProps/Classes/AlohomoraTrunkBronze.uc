//===============================================================================
//  [AlohomoraTrunkBronze] 
//===============================================================================

class AlohomoraTrunkBronze extends HProps;
#exec MESH  MODELIMPORT MESH=AlohomoraTrunkBronzeMesh MODELFILE=models\AlohomoraTrunkBronzeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=AlohomoraTrunkBronzeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=AlohomoraTrunkBronzeAnims ANIMFILE=models\AlohomoraTrunkBronzeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=AlohomoraTrunkBronzeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=AlohomoraTrunkBronzeMesh ANIM=AlohomoraTrunkBronzeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=AlohomoraTrunkBronzeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=AlohomoraTrunkBronzeTex0  FILE=TEXTURES\AlohomoraTrunkBronzeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=AlohomoraTrunkBronzeMesh NUM=0 TEXTURE=AlohomoraTrunkBronzeTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: brztrunk_128.bmp  Path: D:\Harry Potter\Art\Objects\Alohomora

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.AlohomoraTrunkBronzeMesh'
}
