//===============================================================================
//  [skghost] 
//===============================================================================

class skghost extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skghostMesh MODELFILE=models\skghost.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skghostMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skghostAnims ANIMFILE=models\skghost.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skghostMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skghostMesh ANIM=skghostAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skghostAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skghostTex0  FILE=TEXTURES\GHOST_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skghostTex1  FILE=TEXTURES\GHOST_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skghostMesh NUM=0 TEXTURE=skghostTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skghostMesh NUM=1 TEXTURE=skghostTex1

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: GHOST_SKIN00.bmp  Path: H:\Art\Design\Character Development\Ghost 
// Original material [1] is [SKIN01.TWOSIDED.MASKED] SkinIndex: 1 Bitmap: GHOST_SKIN01.bmp  Path: H:\Art\Design\Character Development\Ghost

defaultproperties
{
}
