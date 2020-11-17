//===============================================================================
//  [skgeorge] 
//===============================================================================

class skgeorge extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skgeorgeMesh MODELFILE=models\skgeorge.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skgeorgeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skgeorgeAnims ANIMFILE=models\skgeorge.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skgeorgeMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skgeorgeMesh ANIM=skgeorgeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skgeorgeAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skgeorgeTex0  FILE=TEXTURES\GEORGE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skgeorgeTex1  FILE=TEXTURES\GEORGE_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skgeorgeMesh NUM=0 TEXTURE=skgeorgeTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skgeorgeMesh NUM=1 TEXTURE=skgeorgeTex1

//#EXEC ANIM NOTIFY   ANIM=skgeorgeAnims SEQ=trot TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skgeorgeAnims SEQ=trot TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: GEORGE_SKIN00.bmp  Path: C:\POTTER\Art\Characters\George Weasley 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: GEORGE_SKIN01.bmp  Path: C:\POTTER\Art\Characters\George Weasley

defaultproperties
{
}
