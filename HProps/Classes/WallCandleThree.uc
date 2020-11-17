//===============================================================================
//  [WallCandleThree] 
//===============================================================================

class WallCandleThree extends HProps;
#exec MESH  MODELIMPORT MESH=WallCandleThreeMesh MODELFILE=models\WallCandleThreeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WallCandleThreeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WallCandleThreeAnims ANIMFILE=models\WallCandleThreeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WallCandleThreeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WallCandleThreeMesh ANIM=WallCandleThreeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WallCandleThreeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WallCandleThreeTex0  FILE=TEXTURES\WallCandleThreeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WallCandleThreeMesh NUM=0 TEXTURE=WallCandleThreeTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: wallcndl_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\candle sticks

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WallCandleThreeMesh'
}
