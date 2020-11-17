//===============================================================================
//  [skrook_black] 
//===============================================================================

class skrook_black extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skrook_blackMesh MODELFILE=models\skrook_blackMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skrook_blackMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skrook_blackAnims ANIMFILE=models\skrook_blackAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skrook_blackMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skrook_blackMesh ANIM=skrook_blackAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skrook_blackAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skrook_blackTex0  FILE=TEXTURES\skrook_blackTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skrook_blackTex1  FILE=TEXTURES\skrook_blackTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skrook_blackTex2  FILE=TEXTURES\skrook_blackTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skrook_blackMesh NUM=0 TEXTURE=skrook_blackTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skrook_blackMesh NUM=1 TEXTURE=skrook_blackTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skrook_blackMesh NUM=2 TEXTURE=skrook_blackTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: blackcastle_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: blackcastle_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: blackcastle_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
