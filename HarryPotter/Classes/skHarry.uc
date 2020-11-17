//===============================================================================
//  [skharry] 
//===============================================================================

class skharry extends harry;
//#EXEC MESH  MODELIMPORT MESH=skharryMesh MODELFILE=models\skharry.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skharryMesh X=0 Y=0 Z=40 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skharryAnims ANIMFILE=models\skharry.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skharryMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skharryMesh ANIM=skharryAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skharryAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skharryTex0  FILE=TEXTURES\HARRY_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skharryTex1  FILE=TEXTURES\HARRY_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skharryTex2  FILE=TEXTURES\HARRY_SKIN03.bmp  GROUP=Skins LODSet=0
//#EXEC TEXTURE IMPORT NAME=skharryTex3  FILE=TEXTURES\HARRY_SKIN05.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skharryMesh NUM=0 TEXTURE=skharryTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharryMesh NUM=1 TEXTURE=skharryTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharryMesh NUM=2 TEXTURE=skharryTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skharryMesh NUM=3 TEXTURE=skharryTex3

//#EXEC MESH WEAPONATTACH MESH=skHarryMesh BONE="RightHand"
//#EXEC MESH WEAPONPOSITION MESH=skHarryMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0

//#EXEC ANIM NOTIFY   ANIM=skHarryAnims SEQ=Cast TIME=0.1 FUNCTION=Cast
//#EXEC ANIM NOTIFY   ANIM=skHarryAnims SEQ=Run TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skHarryAnims SEQ=Run TIME=0.5 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skHarryAnims SEQ=runback TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skHarryAnims SEQ=runback TIME=0.5 FUNCTION=PlayFootStep


// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HARRY_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Harry 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HARRY_SKIN01.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [2] is [SKIN02.MASKED] SkinIndex: 2 Bitmap: HARRY_SKIN03.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: HARRY_SKIN05.bmp  Path: H:\Art\Design\Character Development\Harry

defaultproperties
{
}
