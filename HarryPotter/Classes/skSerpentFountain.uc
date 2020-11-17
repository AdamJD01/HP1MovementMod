//===============================================================================
//  [skserpentfountain] 
//===============================================================================

class skserpentfountain extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skserpentfountainMesh MODELFILE=models\skserpentfountain.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skserpentfountainMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skserpentfountainAnims ANIMFILE=models\skserpentfountain.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skserpentfountainMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skserpentfountainMesh ANIM=skserpentfountainAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skserpentfountainAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skserpentfountainTex0  FILE=TEXTURES\serpents_256.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skserpentfountainMesh NUM=0 TEXTURE=skserpentfountainTex0

// Original material [0] is [SERPENT_SKIN00] SkinIndex: 0 Bitmap: serpents_256.bmp  Path: H:\Art\Design\Creatures\Serpents

defaultproperties
{
}
