//===============================================================================
//  [skking_white] 
//===============================================================================

class skking_white extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skking_whiteMesh MODELFILE=models\skking_whiteMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skking_whiteMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skking_whiteAnims ANIMFILE=models\skking_whiteAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skking_whiteMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skking_whiteMesh ANIM=skking_whiteAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skking_whiteAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skking_whiteTex0  FILE=TEXTURES\skking_whiteTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skking_whiteTex1  FILE=TEXTURES\skking_whiteTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skking_whiteTex2  FILE=TEXTURES\skking_whiteTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skking_whiteMesh NUM=0 TEXTURE=skking_whiteTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skking_whiteMesh NUM=1 TEXTURE=skking_whiteTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skking_whiteMesh NUM=2 TEXTURE=skking_whiteTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: chessking_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: chessking_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: chessking_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
