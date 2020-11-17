//===============================================================================
//  [SingleCandleStick] 
//===============================================================================

class SingleCandleStick extends HProps;
#exec MESH  MODELIMPORT MESH=SingleCandleStickMesh MODELFILE=models\SingleCandleStickMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SingleCandleStickMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SingleCandleStickAnims ANIMFILE=models\SingleCandleStickAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SingleCandleStickMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SingleCandleStickMesh ANIM=SingleCandleStickAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SingleCandleStickAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SingleCandleStickTex0  FILE=TEXTURES\SingleCandleStickTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SingleCandleStickMesh NUM=0 TEXTURE=SingleCandleStickTex0

// Original material [0] is [Material #8] SkinIndex: 0 Bitmap: HogSnglCanStick_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.SingleCandleStickMesh'
}
