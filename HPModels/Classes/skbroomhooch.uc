//===============================================================================
//  [skbroomhooch] 
//===============================================================================

class skbroomhooch extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skbroomhoochMesh MODELFILE=models\skbroomhoochMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skbroomhoochMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skbroomhoochAnims ANIMFILE=models\skbroomhoochAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skbroomhoochMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skbroomhoochMesh ANIM=skbroomhoochAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skbroomhoochAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skbroomhoochTex0  FILE=TEXTURES\skbroomhoochTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbroomhoochTex1  FILE=TEXTURES\skbroomhoochTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skbroomhoochTex2  FILE=TEXTURES\skbroomhoochTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skbroomhoochMesh NUM=0 TEXTURE=skbroomhoochTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skbroomhoochMesh NUM=1 TEXTURE=skbroomhoochTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skbroomhoochMesh NUM=2 TEXTURE=skbroomhoochTex2

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: HOOCH_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Hooch 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HOOCH_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Hooch 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: HOOCH_SKIN02.bmp  Path: C:\~Work\Harry Potter\Characters\Hooch

defaultproperties
{
}
