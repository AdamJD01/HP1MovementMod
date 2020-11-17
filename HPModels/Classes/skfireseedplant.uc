//===============================================================================
//  [skfireseedplant] 
//===============================================================================

class skfireseedplant extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skfireseedplantMesh MODELFILE=models\skfireseedplantMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skfireseedplantMesh X=0 Y=0 Z=32 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skfireseedplantAnims ANIMFILE=models\skfireseedplantAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skfireseedplantMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skfireseedplantMesh ANIM=skfireseedplantAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skfireseedplantAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skfireseedplantTex0  FILE=TEXTURES\skfireseedplantTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skfireseedplantTex1  FILE=TEXTURES\skfireseedplantTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skfireseedplantMesh NUM=0 TEXTURE=skfireseedplantTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skfireseedplantMesh NUM=1 TEXTURE=skfireseedplantTex1

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: FIRESEED_SKIN00.bmp  Path: H:\Art\Design\Creatures\FireSeedPlant 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: FIRESEED_SKIN00.bmp  Path: H:\Art\Design\Creatures\FireSeedPlant

defaultproperties
{
}
