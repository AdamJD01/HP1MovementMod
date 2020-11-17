//===============================================================================
//  [skneville] 
//===============================================================================

class skneville extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=sknevilleMesh MODELFILE=models\skneville.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=sknevilleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=sknevilleAnims ANIMFILE=models\skneville.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=sknevilleMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=sknevilleMesh ANIM=sknevilleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=sknevilleAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=sknevilleTex0  FILE=TEXTURES\NEVILLE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=sknevilleTex1  FILE=TEXTURES\NEVILLE_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=sknevilleMesh NUM=0 TEXTURE=sknevilleTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=sknevilleMesh NUM=1 TEXTURE=sknevilleTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: NEVILLE_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Neville 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: NEVILLE_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Neville

defaultproperties
{
}
