//===============================================================================
//  [skpawn_white] 
//===============================================================================

class skpawn_white extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skpawn_whiteMesh MODELFILE=models\skpawn_whiteMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skpawn_whiteMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skpawn_whiteAnims ANIMFILE=models\skpawn_whiteAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skpawn_whiteMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skpawn_whiteMesh ANIM=skpawn_whiteAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skpawn_whiteAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skpawn_whiteTex0  FILE=TEXTURES\skpawn_whiteTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skpawn_whiteTex1  FILE=TEXTURES\skpawn_whiteTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skpawn_whiteTex2  FILE=TEXTURES\skpawn_whiteTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skpawn_whiteMesh NUM=0 TEXTURE=skpawn_whiteTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skpawn_whiteMesh NUM=1 TEXTURE=skpawn_whiteTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skpawn_whiteMesh NUM=2 TEXTURE=skpawn_whiteTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: whitepawn_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: whitepawn_SKIN01.bmp  Path: C:\potter_art\Characters\Chess_pieces 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: whitepawn_SKIN00.bmp  Path: C:\potter_art\Characters\Chess_pieces

defaultproperties
{
}
