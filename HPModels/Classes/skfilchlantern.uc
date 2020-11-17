//===============================================================================
//  [skfilchlantern] 
//===============================================================================

class skfilchlantern extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skfilchlanternMesh MODELFILE=models\skfilchlanternMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skfilchlanternMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skfilchlanternAnims ANIMFILE=models\skfilchlanternAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skfilchlanternMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skfilchlanternMesh ANIM=skfilchlanternAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skfilchlanternAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skfilchlanternTex0  FILE=TEXTURES\skfilchlanternTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skfilchlanternTex1  FILE=TEXTURES\skfilchlanternTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skfilchlanternTex2  FILE=TEXTURES\skfilchlanternTex2.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skfilchlanternTex3  FILE=TEXTURES\skfilchlanternTex3.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skfilchlanternTex4  FILE=TEXTURES\skfilchlanternTex4.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchlanternMesh NUM=0 TEXTURE=skfilchlanternTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchlanternMesh NUM=1 TEXTURE=skfilchlanternTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchlanternMesh NUM=2 TEXTURE=skfilchlanternTex2
#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchlanternMesh NUM=3 TEXTURE=skfilchlanternTex3
#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchlanternMesh NUM=4 TEXTURE=skfilchlanternTex4

#exec ANIM NOTIFY   ANIM=skfilchlanternAnims SEQ=Walk TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skfilchlanternAnims SEQ=Walk TIME=0.5 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skfilchlanternAnims SEQ=Run TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skfilchlanternAnims SEQ=Run TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: FILCH_SKIN00.bmp  Path: H:\Art\Design\Character Development\Filch 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: FILCH_SKIN01.bmp  Path: H:\Art\Design\Character Development\Filch 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: FILCH_SKIN02.bmp  Path: H:\Art\Design\Character Development\Filch 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: FILCH_SKIN03.bmp  Path: H:\Art\Design\Character Development\Filch 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: FILCH_SKIN04.bmp  Path: H:\Art\Design\Character Development\Filch

defaultproperties
{
}
