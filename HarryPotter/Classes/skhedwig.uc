//===============================================================================
//  [skhedwig] 
//===============================================================================

class skhedwig extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skhedwigMesh MODELFILE=models\skhedwig.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skhedwigMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skhedwigAnims ANIMFILE=models\skhedwig.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skhedwigMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skhedwigMesh ANIM=skhedwigAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skhedwigAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skhedwigTex0  FILE=TEXTURES\Hedwig_skin00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skhedwigMesh NUM=0 TEXTURE=skhedwigTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: Hedwig_skin00.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\Hedwig

defaultproperties
{
}
