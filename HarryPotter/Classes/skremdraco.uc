//===============================================================================
//  [skremdraco] 
//===============================================================================

class skremdraco extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skremdracoMesh MODELFILE=models\skremdraco.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skremdracoMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skremdracoAnims ANIMFILE=models\skremdraco.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skremdracoMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skremdracoMesh ANIM=skremdracoAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skremdracoAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skremdracoTex0  FILE=TEXTURES\DRACOR_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skremdracoTex1  FILE=TEXTURES\DRACOR_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skremdracoTex2  FILE=TEXTURES\QUID_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skremdracoMesh NUM=0 TEXTURE=skremdracoTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skremdracoMesh NUM=1 TEXTURE=skremdracoTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skremdracoMesh NUM=2 TEXTURE=skremdracoTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: DRACOR_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Draco Rememberall 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: DRACOR_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Draco Rememberall 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: QUID_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Draco Rememberall

defaultproperties
{
}
