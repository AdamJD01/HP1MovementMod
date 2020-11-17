//===============================================================================
//  [GreenHouseWheelBroken] 
//===============================================================================

class GreenHouseWheelBroken extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseWheelBrokenMesh MODELFILE=models\GreenHouseWheelBrokenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseWheelBrokenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseWheelBrokenAnims ANIMFILE=models\GreenHouseWheelBrokenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseWheelBrokenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseWheelBrokenMesh ANIM=GreenHouseWheelBrokenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseWheelBrokenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseWheelBrokenTex0  FILE=TEXTURES\GreenHouseWheelBrokenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseWheelBrokenMesh NUM=0 TEXTURE=GreenHouseWheelBrokenTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: grhwheel_128.bmp  Path: D:\Harry Potter\Art\Objects\Greenhouse\wheel spigot

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseWheelBrokenMesh'
}
