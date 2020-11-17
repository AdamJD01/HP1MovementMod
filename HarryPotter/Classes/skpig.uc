//===============================================================================
//  [skpig] 
//===============================================================================

class skpig extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skpigMesh MODELFILE=models\skpig.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skpigMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skpigAnims ANIMFILE=models\skpig.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skpigMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skpigMesh ANIM=skpigAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skpigAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skpigTex0  FILE=TEXTURES\PIG_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skpigMesh NUM=0 TEXTURE=skpigTex0

// Original material [0] is [PIG_SKIN00] SkinIndex: 0 Bitmap: PIG_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\Pig

defaultproperties
{
}
