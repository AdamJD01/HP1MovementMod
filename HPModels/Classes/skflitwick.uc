//===============================================================================
//  [skflitwick] 
//===============================================================================

class skflitwick extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skflitwickMesh MODELFILE=models\skflitwickMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skflitwickMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skflitwickAnims ANIMFILE=models\skflitwickAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skflitwickMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skflitwickMesh ANIM=skflitwickAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skflitwickAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skflitwickTex0  FILE=TEXTURES\skflitwickTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skflitwickTex1  FILE=TEXTURES\skflitwickTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skflitwickMesh NUM=0 TEXTURE=skflitwickTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skflitwickMesh NUM=1 TEXTURE=skflitwickTex1

#exec ANIM NOTIFY   ANIM=skflitwickAnims SEQ=walk TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skflitwickAnims SEQ=walk TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: FLITW_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Flitwick 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: FLITW_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Flitwick

defaultproperties
{
}
