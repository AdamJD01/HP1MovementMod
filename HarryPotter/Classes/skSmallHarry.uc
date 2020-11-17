//===============================================================================
//  [skSmallHarry] 
//===============================================================================

class skSmallHarry extends harry;
//#EXEC MESH  MODELIMPORT MESH=skSmallharryMesh MODELFILE=models\skharry.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skSmallharryMesh X=0 Y=0 Z=150 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skSmallharryAnims ANIMFILE=models\skharry.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skSmallharryMesh X=0.3 Y=0.3 Z=0.3
//#EXEC MESH  DEFAULTANIM MESH=skSmallharryMesh ANIM=skSmallharryAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skSmallharryAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skSmallharryTex0  FILE=TEXTURES\HARRY_SKIN00t.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skSmallharryTex1  FILE=TEXTURES\HARRY_SKIN01t.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skSmallharryMesh NUM=0 TEXTURE=skSmallharryTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skSmallharryMesh NUM=1 TEXTURE=skSmallharryTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skSmallharryMesh NUM=2 TEXTURE=skharryTex2

//#EXEC MESH WEAPONATTACH MESH=skSmallharryMesh BONE="RightHand"
//#EXEC MESH WEAPONPOSITION MESH=skSmallharryMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0

//#EXEC ANIM NOTIFY   ANIM=skSmallharryAnims SEQ=Cast TIME=0.1 FUNCTION=Cast
//#EXEC ANIM NOTIFY   ANIM=skSmallharryAnims SEQ=Run TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skSmallharryAnims SEQ=Run TIME=0.5 FUNCTION=PlayFootStep



// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HARRY_SKIN00t.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Harry\Nathan'sTest 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HARRY_SKIN01t.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [2] is [SKIN02.MASKED] SkinIndex: 2 Bitmap: HARRY_SKIN03.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Harry\Nathan'sTest

defaultproperties
{
}
