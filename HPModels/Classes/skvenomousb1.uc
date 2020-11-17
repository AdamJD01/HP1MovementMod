//===============================================================================
//  [skvenomousb1] 
//===============================================================================

class skvenomousb1 extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skvenomousb1Mesh MODELFILE=models\skvenomousb1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skvenomousb1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skvenomousb1Anims ANIMFILE=models\skvenomousb1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skvenomousb1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skvenomousb1Mesh ANIM=skvenomousb1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skvenomousb1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=skvenomousb1Tex0  FILE=TEXTURES\skvenomousb1Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvenomousb1Tex1  FILE=TEXTURES\skvenomousb1Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomousb1Mesh NUM=0 TEXTURE=skvenomousb1Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomousb1Mesh NUM=1 TEXTURE=skvenomousb1Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VENBLUE_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\VenomousTentacular 
// Original material [1] is [SKIN01.MASKED.TWOSIDED] SkinIndex: 1 Bitmap: VENBLUE_SKIN01.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\VenomousTentacular

defaultproperties
{
}
