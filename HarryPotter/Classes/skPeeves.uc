//===============================================================================
//  [skpeeves] 
//===============================================================================

class skpeeves extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skpeevesMesh MODELFILE=models\skpeeves.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skpeevesMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skpeevesAnims ANIMFILE=models\skpeeves.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skpeevesMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skpeevesMesh ANIM=skpeevesAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skpeevesAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skpeevesTex0  FILE=TEXTURES\PEEVES_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skpeevesTex1  FILE=TEXTURES\PEEVES_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skpeevesTex2  FILE=TEXTURES\PEEVES_SKIN02.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skpeevesMesh NUM=0 TEXTURE=skpeevesTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skpeevesMesh NUM=1 TEXTURE=skpeevesTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skpeevesMesh NUM=2 TEXTURE=skpeevesTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: PEEVES_SKIN00.bmp  Path: C:\POTTER\Art\Characters\Peeves 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: PEEVES_SKIN01.bmp  Path: C:\POTTER\Art\Characters\Peeves
// Original material [2] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: PEEVES_SKIN02.bmp  Path: C:\POTTER\Art\Characters\Peeves

defaultproperties
{
}
