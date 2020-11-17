//===============================================================================
//  [PlainCandle] 
//===============================================================================

class PlainCandle extends HProps;
#exec MESH  MODELIMPORT MESH=PlainCandleMesh MODELFILE=models\PlainCandleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PlainCandleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PlainCandleAnims ANIMFILE=models\PlainCandleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PlainCandleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PlainCandleMesh ANIM=PlainCandleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PlainCandleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PlainCandleTex0  FILE=TEXTURES\PlainCandleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PlainCandleMesh NUM=0 TEXTURE=PlainCandleTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: plncndle_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PlainCandleMesh'
}
