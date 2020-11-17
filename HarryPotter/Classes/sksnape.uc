//===============================================================================
//  [sksnape] 
//===============================================================================

class sksnape extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=sksnapeMesh MODELFILE=models\sksnape.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=sksnapeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=sksnapeAnims ANIMFILE=models\sksnape.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=sksnapeMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=sksnapeMesh ANIM=sksnapeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=sksnapeAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=sksnapeTex0  FILE=TEXTURES\SNAPE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=sksnapeTex1  FILE=TEXTURES\SNAPE_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=sksnapeTex2  FILE=TEXTURES\SNAPE_SKIN02.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=sksnapeMesh NUM=0 TEXTURE=sksnapeTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=sksnapeMesh NUM=1 TEXTURE=sksnapeTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=sksnapeMesh NUM=2 TEXTURE=sksnapeTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: SNAPE_SKIN00.bmp  Path: C:\potter_art\Characters\Prof Snape 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: SNAPE_SKIN01.bmp  Path: C:\potter_art\Characters\Prof Snape 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: SNAPE_SKIN02.bmp  Path: C:\potter_art\Characters\Prof Snape

defaultproperties
{
}
