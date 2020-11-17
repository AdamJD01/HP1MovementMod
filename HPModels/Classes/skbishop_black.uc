//===============================================================================
//  [skbishop_black] 
//===============================================================================

class skbishop_black extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skbishop_blackMesh MODELFILE=models\skbishop_blackMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skbishop_blackMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skbishop_blackAnims ANIMFILE=models\skbishop_blackAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skbishop_blackMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skbishop_blackMesh ANIM=skbishop_blackAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skbishop_blackAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skbishop_blackTex0  FILE=TEXTURES\skbishop_blackTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbishop_blackTex1  FILE=TEXTURES\skbishop_blackTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbishop_blackTex2  FILE=TEXTURES\skbishop_blackTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skbishop_blackMesh NUM=0 TEXTURE=skbishop_blackTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skbishop_blackMesh NUM=1 TEXTURE=skbishop_blackTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skbishop_blackMesh NUM=2 TEXTURE=skbishop_blackTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: blackbishop_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: blackbishop_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: blackbishop_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
