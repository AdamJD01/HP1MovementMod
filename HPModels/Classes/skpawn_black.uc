//===============================================================================
//  [skpawn_black] 
//===============================================================================

class skpawn_black extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skpawn_blackMesh MODELFILE=models\skpawn_blackMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skpawn_blackMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skpawn_blackAnims ANIMFILE=models\skpawn_blackAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skpawn_blackMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skpawn_blackMesh ANIM=skpawn_blackAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skpawn_blackAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skpawn_blackTex0  FILE=TEXTURES\skpawn_blackTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skpawn_blackTex1  FILE=TEXTURES\skpawn_blackTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skpawn_blackTex2  FILE=TEXTURES\skpawn_blackTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skpawn_blackMesh NUM=0 TEXTURE=skpawn_blackTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skpawn_blackMesh NUM=1 TEXTURE=skpawn_blackTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skpawn_blackMesh NUM=2 TEXTURE=skpawn_blackTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: blackpawn_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: blackpawn_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: blackpawn_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
