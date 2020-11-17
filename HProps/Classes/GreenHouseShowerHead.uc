//===============================================================================
//  [GreenHouseShowerHead] 
//===============================================================================

class GreenHouseShowerHead extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseShowerHeadMesh MODELFILE=models\GreenHouseShowerHeadMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseShowerHeadMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseShowerHeadAnims ANIMFILE=models\GreenHouseShowerHeadAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseShowerHeadMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseShowerHeadMesh ANIM=GreenHouseShowerHeadAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseShowerHeadAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseShowerHeadTex0  FILE=TEXTURES\GreenHouseShowerHeadTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseShowerHeadMesh NUM=0 TEXTURE=GreenHouseShowerHeadTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: GreenHouseShowerhead.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseShowerHeadMesh'
}
