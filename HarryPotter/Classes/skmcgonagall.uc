//===============================================================================
//  [skmcgonagall] 
//===============================================================================

class skmcgonagall extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skmcgonagallMesh MODELFILE=models\skmcgonagall.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skmcgonagallMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skmcgonagallAnims ANIMFILE=models\skmcgonagall.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skmcgonagallMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skmcgonagallMesh ANIM=skmcgonagallAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skmcgonagallAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skmcgonagallTex0  FILE=TEXTURES\McGONAGALL3_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skmcgonagallTex1  FILE=TEXTURES\McGONAGALL_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skmcgonagallTex2  FILE=TEXTURES\McGONAGALL_SKIN02.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skmcgonagallMesh NUM=0 TEXTURE=skmcgonagallTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skmcgonagallMesh NUM=1 TEXTURE=skmcgonagallTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skmcgonagallMesh NUM=2 TEXTURE=skmcgonagallTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: McGONAGALL3_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Mcgonagall 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: McGONAGALL_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Mcgonagall 
// Original material [2] is [SKIN02.MASKED] SkinIndex: 2 Bitmap: McGONAGALL_SKIN02.bmp  Path: C:\~Work\Harry Potter\Characters\Mcgonagall

defaultproperties
{
}
