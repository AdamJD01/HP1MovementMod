//===============================================================================
//  [skbeater] 
//===============================================================================

class skbeater extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skbeaterMesh MODELFILE=models\skbeaterMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skbeaterMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skbeaterAnims ANIMFILE=models\skbeaterAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skbeaterMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skbeaterMesh ANIM=skbeaterAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skbeaterAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skbeater_1Tex0  FILE=TEXTURES\skbeater_1Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_1Tex1  FILE=TEXTURES\skbeater_1Tex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_1Tex2  FILE=TEXTURES\skbeater_1Tex2.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skbeater_2Tex0  FILE=TEXTURES\skbeater_2Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_2Tex1  FILE=TEXTURES\skbeater_2Tex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_2Tex2  FILE=TEXTURES\skbeater_2Tex2.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skbeater_3Tex0  FILE=TEXTURES\skbeater_3Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_3Tex1  FILE=TEXTURES\skbeater_3Tex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_3Tex2  FILE=TEXTURES\skbeater_3Tex2.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skbeater_4Tex0  FILE=TEXTURES\skbeater_4Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_4Tex1  FILE=TEXTURES\skbeater_4Tex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbeater_4Tex2  FILE=TEXTURES\skbeater_4Tex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skbeaterMesh NUM=0 TEXTURE=skbeater_1Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skbeaterMesh NUM=1 TEXTURE=skbeater_1Tex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skbeaterMesh NUM=2 TEXTURE=skbeater_1Tex2

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: MBEATER1_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\MBeater 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: QUID_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\MBeater 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: MBEATER_SKIN02.bmp  Path: C:\~Work\Harry Potter\Characters\MBeater

defaultproperties
{
}
