//===============================================================================
//  [skvenomousb3] 
//===============================================================================

class skvenomousb3 extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skvenomousb3Mesh MODELFILE=models\skvenomousb3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skvenomousb3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skvenomousb3Anims ANIMFILE=models\skvenomousb3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skvenomousb3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skvenomousb3Mesh ANIM=skvenomousb3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skvenomousb3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=skvenomousb3Tex0  FILE=TEXTURES\skvenomousb3Tex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvenomousb3Tex1  FILE=TEXTURES\skvenomousb3Tex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomousb3Mesh NUM=0 TEXTURE=skvenomousb3Tex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomousb3Mesh NUM=1 TEXTURE=skvenomousb3Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VENBLUE_SKIN00.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\VenomousTentacular 
// Original material [1] is [SKIN01.MASKED.TWOSIDED] SkinIndex: 1 Bitmap: VENBLUE_SKIN01.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\VenomousTentacular

defaultproperties
{
}
