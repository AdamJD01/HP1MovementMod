//===============================================================================
//  [skharrypotion] 
//===============================================================================

class skharrypotion extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skharrypotionMesh MODELFILE=models\skharrypotion.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skharrypotionMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skharrypotionAnims ANIMFILE=models\skharrypotion.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skharrypotionMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skharrypotionMesh ANIM=skharrypotionAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skharrypotionAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skharrypotionTex0  FILE=TEXTURES\HARRY_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skharrypotionTex1  FILE=TEXTURES\HARRY_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skharrypotionTex3  FILE=TEXTURES\HARRY_SKIN05.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skharrypotionTex4  FILE=TEXTURES\bluebotl_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skharrypotionMesh NUM=0 TEXTURE=skharrypotionTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharrypotionMesh NUM=1 TEXTURE=skharrypotionTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharrypotionMesh NUM=2 TEXTURE=skharryTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharrypotionMesh NUM=3 TEXTURE=skharrypotionTex3
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharrypotionMesh NUM=4 TEXTURE=skharrypotionTex4

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HARRY_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Harry 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HARRY_SKIN01.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [2] is [SKIN02.MASKED] SkinIndex: 2 Bitmap: HARRY_SKIN03.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: HARRY_SKIN05.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: bluebotl_128.bmp  Path: H:\Art\Design\Character Development\Harry

defaultproperties
{
}
