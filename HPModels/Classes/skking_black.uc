//===============================================================================
//  [skking_black] 
//===============================================================================

class skking_black extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skking_blackMesh MODELFILE=models\skking_blackMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skking_blackMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skking_blackAnims ANIMFILE=models\skking_blackAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skking_blackMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skking_blackMesh ANIM=skking_blackAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skking_blackAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skking_blackTex0  FILE=TEXTURES\skking_blackTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skking_blackTex1  FILE=TEXTURES\skking_blackTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skking_blackTex2  FILE=TEXTURES\skking_blackTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skking_blackMesh NUM=0 TEXTURE=skking_blackTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skking_blackMesh NUM=1 TEXTURE=skking_blackTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skking_blackMesh NUM=2 TEXTURE=skking_blackTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: blkchessking_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: blkchessking_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: blkchessking_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
