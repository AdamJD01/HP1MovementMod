//===============================================================================
//  [skcanary] 
//===============================================================================

class skcanary extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skcanaryMesh MODELFILE=models\skcanary.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skcanaryMesh X=0 Y=0 Z=2 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skcanaryAnims ANIMFILE=models\skcanary.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skcanaryMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skcanaryMesh ANIM=skcanaryAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skcanaryAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skcanaryTex0  FILE=TEXTURES\canary.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skcanaryMesh NUM=0 TEXTURE=skcanaryTex0

// Original material [0] is [Material #7] SkinIndex: 0 Bitmap: canary.bmp  Path: H:\Art\Design\Creatures\Canary

defaultproperties
{
}
