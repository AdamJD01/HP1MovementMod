//===============================================================================
//  [skrabbit] 
//===============================================================================

class skrabbit extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skrabbitMesh MODELFILE=models\skrabbit.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skrabbitMesh X=0 Y=0 Z=3 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skrabbitAnims ANIMFILE=models\skrabbit.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skrabbitMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skrabbitMesh ANIM=skrabbitAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skrabbitAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skrabbitTex0  FILE=TEXTURES\rabbit.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skrabbitMesh NUM=0 TEXTURE=skrabbitTex0

// Original material [0] is [RABBIT_SKIN00] SkinIndex: 0 Bitmap: rabbit.bmp  Path: H:\Art\Design\Creatures\Rabbit

defaultproperties
{
}
