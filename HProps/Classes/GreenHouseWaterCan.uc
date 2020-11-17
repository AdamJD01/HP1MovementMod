//===============================================================================
//  [GreenHouseWaterCan] 
//===============================================================================

class GreenHouseWaterCan extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseWaterCanMesh MODELFILE=models\GreenHouseWaterCanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseWaterCanMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseWaterCanAnims ANIMFILE=models\GreenHouseWaterCanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseWaterCanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseWaterCanMesh ANIM=GreenHouseWaterCanAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseWaterCanAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseWaterCanTex0  FILE=TEXTURES\GreenHouseWaterCanTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseWaterCanMesh NUM=0 TEXTURE=GreenHouseWaterCanTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: GreenHouseWaterCan.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseWaterCanMesh'
}
