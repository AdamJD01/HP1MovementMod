//===============================================================================
//  [skrat] 
//===============================================================================

class skrat extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skratMesh MODELFILE=models\skrat.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skratMesh X=0 Y=0 Z=6 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skratAnims ANIMFILE=models\skrat.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skratMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skratMesh ANIM=skratAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skratAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skratTex0  FILE=TEXTURES\RAT_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skratMesh NUM=0 TEXTURE=skratTex0

// Original material [0] is [RAT_SKIN00] SkinIndex: 0 Bitmap: RAT_SKIN00.bmp  Path: H:\Art\Design\Creatures\Rat

defaultproperties
{
}
