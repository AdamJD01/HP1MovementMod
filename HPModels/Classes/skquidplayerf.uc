//===============================================================================
//  [skquidplayerf] 
//===============================================================================

class skquidplayerf extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skquidplayerfMesh MODELFILE=models\skquidplayerfMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skquidplayerfMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skquidplayerfAnims ANIMFILE=models\skquidplayerfAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skquidplayerfMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skquidplayerfMesh ANIM=skquidplayerfAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skquidplayerfAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skquidplayerf_1Tex0  FILE=TEXTURES\skquidplayerf_1Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerf_1Tex1  FILE=TEXTURES\skquidplayerf_1Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skquidplayerf_2Tex0  FILE=TEXTURES\skquidplayerf_2Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerf_2Tex1  FILE=TEXTURES\skquidplayerf_2Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skquidplayerf_3Tex0  FILE=TEXTURES\skquidplayerf_3Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerf_3Tex1  FILE=TEXTURES\skquidplayerf_3Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skquidplayerf_4Tex0  FILE=TEXTURES\skquidplayerf_4Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquidplayerf_4Tex1  FILE=TEXTURES\skquidplayerf_4Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skquidplayerfMesh NUM=0 TEXTURE=skquidplayerf_1Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skquidplayerfMesh NUM=1 TEXTURE=skquidplayerf_1Tex1

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: FQUID1_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\FQuidditch 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: QUID_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\FQuidditch

defaultproperties
{
}
