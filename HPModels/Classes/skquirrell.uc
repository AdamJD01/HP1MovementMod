//===============================================================================
//  [skquirrell] 
//===============================================================================

class skquirrell extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skquirrellMesh MODELFILE=models\skquirrellMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skquirrellMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skquirrellAnims ANIMFILE=models\skquirrellAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skquirrellMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skquirrellMesh ANIM=skquirrellAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skquirrellAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skquirrellTex0  FILE=TEXTURES\skquirrellTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquirrellTex1  FILE=TEXTURES\skquirrellTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skquirrellTex2  FILE=TEXTURES\skquirrellTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skquirrellMesh NUM=0 TEXTURE=skquirrellTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skquirrellMesh NUM=1 TEXTURE=skquirrellTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skquirrellMesh NUM=2 TEXTURE=skquirrellTex2

#exec ANIM NOTIFY   ANIM=skquirrellAnims SEQ=Walk TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skquirrellAnims SEQ=Walk TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: QUIR_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Quirrel 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: QUIR_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Quirrel 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: QUIR_SKIN02.bmp  Path: C:\~Work\Harry Potter\Characters\Quirrel

defaultproperties
{
}
