//===============================================================================
//  [skdevilharry] 
//===============================================================================

class skdevilharry extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skdevilharryMesh MODELFILE=models\skdevilharryMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skdevilharryMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skdevilharryAnims ANIMFILE=models\skdevilharryAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skdevilharryMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skdevilharryMesh ANIM=skdevilharryAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skdevilharryAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skdevilharryTex0  FILE=TEXTURES\skdevilharryTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilharryTex1  FILE=TEXTURES\skdevilharryTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilharryTex2  FILE=TEXTURES\skdevilharryTex2.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilharryTex3  FILE=TEXTURES\skdevilharryTex3.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skdevilharryTex4  FILE=TEXTURES\skdevilharryTex4.bmp  GROUP=Skins

#exec MESH WEAPONATTACH MESH=skDevilHarryMesh BONE="RightHand"
#exec MESH WEAPONPOSITION MESH=skDevilHarryMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0

#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilharryMesh NUM=0 TEXTURE=skdevilharryTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilharryMesh NUM=1 TEXTURE=skdevilharryTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilharryMesh NUM=2 TEXTURE=skdevilharryTex2
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilharryMesh NUM=3 TEXTURE=skdevilharryTex3
#EXEC MESHMAP SETTEXTURE MESHMAP=skdevilharryMesh NUM=4 TEXTURE=skdevilharryTex4

#exec ANIM NOTIFY   ANIM=skDevilHarryAnims SEQ=Cast TIME=0.1 FUNCTION=Cast

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HARRY_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Harry 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HARRY_SKIN01.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\Devil's Snare 
// Original material [2] is [SKIN02.MASKED] SkinIndex: 2 Bitmap: HARRY_SKIN03.bmp  Path: H:\Art\Design\Character Development\Harry\Textures 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: HARRY_SKIN05.bmp  Path: H:\Art\Design\Creatures\Devil's Snare 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: DEVILPLANT_SKIN02.bmp  Path: H:\Art\Design\Creatures\Devil's Snare

defaultproperties
{
}
