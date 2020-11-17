//===============================================================================
//  [skdraco] 
//===============================================================================

class skdraco extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skdracoMesh MODELFILE=models\skdraco.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skdracoMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skdracoAnims ANIMFILE=models\skdraco.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skdracoMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skdracoMesh ANIM=skdracoAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skdracoAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skdracoTex0  FILE=TEXTURES\DRACO_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skdracoTex1  FILE=TEXTURES\DRACO_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skdracoMesh NUM=0 TEXTURE=skdracoTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skdracoMesh NUM=1 TEXTURE=skdracoTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: DRACO_SKIN00.bmp  Path: C:\potter_art\Characters\Draco 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: DRACO_SKIN01.bmp  Path: C:\potter_art\Characters\Draco

defaultproperties
{
}
