//===============================================================================
//  [skserpentstatue] 
//===============================================================================

class skserpentstatue extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skserpentstatueMesh MODELFILE=models\skserpentstatue.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skserpentstatueMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skserpentstatueAnims ANIMFILE=models\skserpentstatue.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skserpentstatueMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skserpentstatueMesh ANIM=skserpentstatueAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skserpentstatueAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skserpentstatueTex0  FILE=TEXTURES\serpents_256.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skserpentstatueMesh NUM=0 TEXTURE=skserpentstatueTex0

// Original material [0] is [SERPENT_SKIN00] SkinIndex: 0 Bitmap: serpents_256.bmp  Path: H:\Art\Design\Creatures\Serpents

defaultproperties
{
}
