//===============================================================================
//  [HagridWallCandles] 
//===============================================================================

class HagridWallCandles extends HProps;
#exec MESH  MODELIMPORT MESH=HagridWallCandlesMesh MODELFILE=models\HagridWallCandlesMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridWallCandlesMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridWallCandlesAnims ANIMFILE=models\HagridWallCandlesAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridWallCandlesMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridWallCandlesMesh ANIM=HagridWallCandlesAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridWallCandlesAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridWallCandlesTex0  FILE=TEXTURES\HagridWallCandlesTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridWallCandlesMesh NUM=0 TEXTURE=HagridWallCandlesTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: hagcandl_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\wall candle

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridWallCandlesMesh'
}
