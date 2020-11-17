//===============================================================================
//  [skgen_fem_1] 
//===============================================================================

class skgen_fem_1 extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skgen_fem_1Mesh MODELFILE=models\skgen_fem_1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skgen_fem_1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skgen_fem_1Anims ANIMFILE=models\skgen_fem_1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skgen_fem_1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skgen_fem_1Mesh ANIM=skgen_fem_1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skgen_fem_1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=skgen_fem_0Tex0  FILE=TEXTURES\skgen_fem_0Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_0Tex1  FILE=TEXTURES\skgen_fem_0Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skgen_fem_1Tex0  FILE=TEXTURES\skgen_fem_1Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_1Tex1  FILE=TEXTURES\skgen_fem_1Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skgen_fem_2Tex0  FILE=TEXTURES\skgen_fem_2Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_2Tex1  FILE=TEXTURES\skgen_fem_2Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skgen_fem_3Tex0  FILE=TEXTURES\skgen_fem_3Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_3Tex1  FILE=TEXTURES\skgen_fem_3Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skgen_fem_4Tex0  FILE=TEXTURES\skgen_fem_4Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_4Tex1  FILE=TEXTURES\skgen_fem_4Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skgen_fem_5Tex0  FILE=TEXTURES\skgen_fem_5Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_5Tex1  FILE=TEXTURES\skgen_fem_5Tex1.bmp  GROUP=Skins

#EXEC TEXTURE IMPORT NAME=skgen_fem_6Tex0  FILE=TEXTURES\skgen_fem_6Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skgen_fem_6Tex1  FILE=TEXTURES\skgen_fem_6Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skgen_fem_1Mesh NUM=0 TEXTURE=skgen_fem_1Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skgen_fem_1Mesh NUM=1 TEXTURE=skgen_fem_1Tex1

#exec ANIM NOTIFY   ANIM=skgen_fem_1Anims SEQ=walk TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skgen_fem_1Anims SEQ=walk TIME=0.5 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skgen_fem_1Anims SEQ=run TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skgen_fem_1Anims SEQ=run TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: GENFEM1_SKIN00.bmp  Path: C:\potter\HPModels\TEXTURES
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: GENFEM1_SKIN01.bmp  Path: C:\potter\HPModels\TEXTURES

defaultproperties
{
}
