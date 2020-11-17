//===============================================================================
//  [skbat] 
//===============================================================================

class skbat extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skbatMesh MODELFILE=models\skbat.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skbatMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skbatAnims ANIMFILE=models\skbat.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skbatMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skbatMesh ANIM=skbatAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skbatAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skbatTex0  FILE=TEXTURES\Bat_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skbatMesh NUM=0 TEXTURE=skbatTex0

// Original material [0] is [Bat_SKIN00] SkinIndex: 0 Bitmap: Bat_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\Bat

defaultproperties
{
}
