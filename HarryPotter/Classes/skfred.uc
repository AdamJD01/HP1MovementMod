//===============================================================================
//  [skfred] 
//===============================================================================

class skfred extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skfredMesh MODELFILE=models\skfred.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skfredMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skfredAnims ANIMFILE=models\skfred.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skfredMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skfredMesh ANIM=skfredAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skfredAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skfredTex0  FILE=TEXTURES\FRED_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skfredTex1  FILE=TEXTURES\FRED_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skfredMesh NUM=0 TEXTURE=skfredTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skfredMesh NUM=1 TEXTURE=skfredTex1

//#EXEC ANIM NOTIFY   ANIM=skfredAnims SEQ=trot TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skfredAnims SEQ=trot TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: FRED_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Fred and George 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: FRED_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Fred and George

defaultproperties
{
}
