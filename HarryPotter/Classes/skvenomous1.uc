//===============================================================================
//  [skvenomous1] 
//===============================================================================

class skvenomous1 extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skvenomous1Mesh MODELFILE=models\skvenomous1.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skvenomous1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skvenomous1Anims ANIMFILE=models\skvenomous1.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skvenomous1Mesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skvenomous1Mesh ANIM=skvenomous1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skvenomous1Anims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skvenomous1Tex0  FILE=TEXTURES\VEN_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skvenomous1Tex1  FILE=TEXTURES\VEN_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomous1Mesh NUM=0 TEXTURE=skvenomous1Tex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomous1Mesh NUM=1 TEXTURE=skvenomous1Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VEN_SKIN00.bmp  Path: H:\Art\Design\Creatures\VenomousTentacular 
// Original material [1] is [SKIN01.MASKED.TWOSIDED] SkinIndex: 1 Bitmap: VEN_SKIN01.bmp  Path: H:\Art\Design\Creatures\VenomousTentacular

defaultproperties
{
}
