//===============================================================================
//  [skbishop_white] 
//===============================================================================

class skbishop_white extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skbishop_whiteMesh MODELFILE=models\skbishop_whiteMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skbishop_whiteMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skbishop_whiteAnims ANIMFILE=models\skbishop_whiteAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skbishop_whiteMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skbishop_whiteMesh ANIM=skbishop_whiteAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skbishop_whiteAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skbishop_whiteTex0  FILE=TEXTURES\skbishop_whiteTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbishop_whiteTex1  FILE=TEXTURES\skbishop_whiteTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbishop_whiteTex2  FILE=TEXTURES\skbishop_whiteTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skbishop_whiteMesh NUM=0 TEXTURE=skbishop_whiteTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skbishop_whiteMesh NUM=1 TEXTURE=skbishop_whiteTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skbishop_whiteMesh NUM=2 TEXTURE=skbishop_whiteTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: whitebishop_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: whitebishop_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: whitebishop_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
