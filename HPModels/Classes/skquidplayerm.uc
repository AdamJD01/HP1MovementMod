//===============================================================================
//  [skquidplayerm] 
//===============================================================================

class skquidplayerm extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skquidplayermMesh MODELFILE=models\skquidplayermMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skquidplayermMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skquidplayermAnims ANIMFILE=models\skquidplayermAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skquidplayermMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skquidplayermMesh ANIM=skquidplayermAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skquidplayermAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skquidplayerm_1Tex0  FILE=TEXTURES\skquidplayerm_1Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerm_1Tex1  FILE=TEXTURES\skquidplayerm_1Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skquidplayerm_2Tex0  FILE=TEXTURES\skquidplayerm_2Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerm_2Tex1  FILE=TEXTURES\skquidplayerm_2Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skquidplayerm_3Tex0  FILE=TEXTURES\skquidplayerm_3Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerm_3Tex1  FILE=TEXTURES\skquidplayerm_3Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skquidplayerm_4Tex0  FILE=TEXTURES\skquidplayerm_4Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerm_4Tex1  FILE=TEXTURES\skquidplayerm_4Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skquidplayermMesh NUM=0 TEXTURE=skquidplayerm_1Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skquidplayermMesh NUM=1 TEXTURE=skquidplayerm_1Tex1

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: MQUID1_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\MQuidditch 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: QUID_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\MQuidditch

defaultproperties
{
}
