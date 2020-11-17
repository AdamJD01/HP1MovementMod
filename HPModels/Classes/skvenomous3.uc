//===============================================================================
//  [skvenomous3] 
//===============================================================================

class skvenomous3 extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skvenomous3Mesh MODELFILE=models\skvenomous3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skvenomous3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skvenomous3Anims ANIMFILE=models\skvenomous3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skvenomous3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skvenomous3Mesh ANIM=skvenomous3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skvenomous3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=skvenomous3Tex0  FILE=TEXTURES\skvenomous3Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvenomous3Tex1  FILE=TEXTURES\skvenomous3Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomous3Mesh NUM=0 TEXTURE=skvenomous3Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomous3Mesh NUM=1 TEXTURE=skvenomous3Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VEN_SKIN00.bmp  Path: H:\Art\Design\Creatures\VenomousTentacular 
// Original material [1] is [SKIN01.MASKED.TWOSIDED] SkinIndex: 1 Bitmap: VEN_SKIN01.bmp  Path: H:\Art\Design\Creatures\VenomousTentacular

defaultproperties
{
}
