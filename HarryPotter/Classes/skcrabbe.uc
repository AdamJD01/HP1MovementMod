//===============================================================================
//  [skcrabbe] 
//===============================================================================

class skcrabbe extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skcrabbeMesh MODELFILE=models\skcrabbe.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skcrabbeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skcrabbeAnims ANIMFILE=models\skcrabbe.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skcrabbeMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skcrabbeMesh ANIM=skcrabbeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skcrabbeAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skcrabbeTex0  FILE=TEXTURES\CRABBE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skcrabbeTex1  FILE=TEXTURES\CRABBE_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skcrabbeMesh NUM=0 TEXTURE=skcrabbeTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skcrabbeMesh NUM=1 TEXTURE=skcrabbeTex1

//#EXEC ANIM NOTIFY   ANIM=skcrabbeAnims SEQ=trot TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skcrabbeAnims SEQ=trot TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: CRABBE_SKIN00.bmp  Path: C:\potter_art\Characters\Crabbe 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: CRABBE_SKIN01.bmp  Path: C:\potter_art\Characters\Crabbe

defaultproperties
{
}
