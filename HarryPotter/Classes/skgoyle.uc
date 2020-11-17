//===============================================================================
//  [skgoyle] 
//===============================================================================

class skgoyle extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skgoyleMesh MODELFILE=models\skgoyle.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skgoyleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skgoyleAnims ANIMFILE=models\skgoyle.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skgoyleMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skgoyleMesh ANIM=skgoyleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skgoyleAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skgoyleTex0  FILE=TEXTURES\GOYLE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skgoyleTex1  FILE=TEXTURES\GOYLE_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skgoyleMesh NUM=0 TEXTURE=skgoyleTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skgoyleMesh NUM=1 TEXTURE=skgoyleTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: GOYLE_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Goyle 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: GOYLE_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Goyle

defaultproperties
{
}
