//===============================================================================
//  [skvoldemort_al] 
//===============================================================================

class skvoldemort_al extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skvoldemort_alMesh MODELFILE=models\skvoldemort_alMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skvoldemort_alMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skvoldemort_alAnims ANIMFILE=models\skvoldemort_alAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skvoldemort_alMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skvoldemort_alMesh ANIM=skvoldemort_alAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skvoldemort_alAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skvoldemort_alTex0  FILE=TEXTURES\skvoldemort_alTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvoldemort_alTex1  FILE=TEXTURES\skvoldemort_alTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvoldemort_alTex2  FILE=TEXTURES\skvoldemort_alTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skvoldemort_alMesh NUM=0 TEXTURE=skvoldemort_alTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skvoldemort_alMesh NUM=1 TEXTURE=skvoldemort_alTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skvoldemort_alMesh NUM=2 TEXTURE=skvoldemort_alTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VOLD_SKIN00.bmp  Path: H:\vss\users\aeufrasi 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: VOLD_SKIN01.bmp  Path: H:\vss\users\aeufrasi 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: VOLD_SKIN02.bmp  Path: \\Baker\HPotterPC\vss\users\aeufrasi

defaultproperties
{
}
