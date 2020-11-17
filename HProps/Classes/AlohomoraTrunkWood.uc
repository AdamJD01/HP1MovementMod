//===============================================================================
//  [AlohomoraTrunkWood] 
//===============================================================================

class AlohomoraTrunkWood extends HProps;
#exec MESH  MODELIMPORT MESH=AlohomoraTrunkWoodMesh MODELFILE=models\AlohomoraTrunkWoodMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=AlohomoraTrunkWoodMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=AlohomoraTrunkWoodAnims ANIMFILE=models\AlohomoraTrunkWoodAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=AlohomoraTrunkWoodMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=AlohomoraTrunkWoodMesh ANIM=AlohomoraTrunkWoodAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=AlohomoraTrunkWoodAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=AlohomoraTrunkWoodTex0  FILE=TEXTURES\AlohomoraTrunkWoodTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=AlohomoraTrunkWoodMesh NUM=0 TEXTURE=AlohomoraTrunkWoodTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: wodtrunk_128.bmp  Path: D:\Harry Potter\Art\Objects\Alohomora

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.AlohomoraTrunkWoodMesh'
}
