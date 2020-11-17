//===============================================================================
//  [WallCandleSingle] 
//===============================================================================

class WallCandleSingle extends HProps;
#exec MESH  MODELIMPORT MESH=WallCandleSingleMesh MODELFILE=models\WallCandleSingleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WallCandleSingleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WallCandleSingleAnims ANIMFILE=models\WallCandleSingleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WallCandleSingleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WallCandleSingleMesh ANIM=WallCandleSingleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WallCandleSingleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WallCandleSingleTex0  FILE=TEXTURES\WallCandleSingleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WallCandleSingleMesh NUM=0 TEXTURE=WallCandleSingleTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: wallcndl_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\candle sticks

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WallCandleSingleMesh'
}
