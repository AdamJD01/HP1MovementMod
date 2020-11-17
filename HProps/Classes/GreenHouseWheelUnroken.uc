//===============================================================================
//  [GreenHouseWheelUnroken] 
//===============================================================================

class GreenHouseWheelUnroken extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseWheelUnrokenMesh MODELFILE=models\GreenHouseWheelUnrokenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseWheelUnrokenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseWheelUnrokenAnims ANIMFILE=models\GreenHouseWheelUnrokenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseWheelUnrokenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseWheelUnrokenMesh ANIM=GreenHouseWheelUnrokenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseWheelUnrokenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseWheelUnrokenTex0  FILE=TEXTURES\GreenHouseWheelUnrokenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseWheelUnrokenMesh NUM=0 TEXTURE=GreenHouseWheelUnrokenTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: grhwheel_128.bmp  Path: D:\Harry Potter\Art\Objects\Greenhouse\wheel spigot

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseWheelUnrokenMesh'
}
