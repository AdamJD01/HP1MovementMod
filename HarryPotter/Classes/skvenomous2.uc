//===============================================================================
//  [skvenomous2] 
//===============================================================================

class skvenomous2 extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skvenomous2Mesh MODELFILE=models\skvenomous2.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skvenomous2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skvenomous2Anims ANIMFILE=models\skvenomous2.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skvenomous2Mesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skvenomous2Mesh ANIM=skvenomous2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skvenomous2Anims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skvenomous2Tex0  FILE=TEXTURES\VEN_SKIN02.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomous2Mesh NUM=0 TEXTURE=skvenomous2Tex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VEN_SKIN02.bmp  Path: H:\Art\Design\Creatures\VenomousTentacular

defaultproperties
{
}
