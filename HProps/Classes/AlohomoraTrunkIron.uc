//===============================================================================
//  [AlohomoraTrunkIron] 
//===============================================================================

class AlohomoraTrunkIron extends HProps;
#exec MESH  MODELIMPORT MESH=AlohomoraTrunkIronMesh MODELFILE=models\AlohomoraTrunkIronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=AlohomoraTrunkIronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=AlohomoraTrunkIronAnims ANIMFILE=models\AlohomoraTrunkIronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=AlohomoraTrunkIronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=AlohomoraTrunkIronMesh ANIM=AlohomoraTrunkIronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=AlohomoraTrunkIronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=AlohomoraTrunkIronTex0  FILE=TEXTURES\AlohomoraTrunkIronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=AlohomoraTrunkIronMesh NUM=0 TEXTURE=AlohomoraTrunkIronTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: irntrunk_128.bmp  Path: D:\Harry Potter\Art\Objects\Alohomora

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.AlohomoraTrunkIronMesh'
}
