//===============================================================================
//  [ThreeArmFloorCandleStick] 
//===============================================================================

class ThreeArmFloorCandleStick extends HProps;
#exec MESH  MODELIMPORT MESH=ThreeArmFloorCandleStickMesh MODELFILE=models\ThreeArmFloorCandleStickMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ThreeArmFloorCandleStickMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ThreeArmFloorCandleStickAnims ANIMFILE=models\ThreeArmFloorCandleStickAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ThreeArmFloorCandleStickMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ThreeArmFloorCandleStickMesh ANIM=ThreeArmFloorCandleStickAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ThreeArmFloorCandleStickAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ThreeArmFloorCandleStickTex0  FILE=TEXTURES\ThreeArmFloorCandleStickTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ThreeArmFloorCandleStickMesh NUM=0 TEXTURE=ThreeArmFloorCandleStickTex0

// Original material [0] is [Material #3] SkinIndex: 0 Bitmap: FlorCndl_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ThreeArmFloorCandleStickMesh'
}
