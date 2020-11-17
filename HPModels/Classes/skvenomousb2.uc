//===============================================================================
//  [skvenomousb2] 
//===============================================================================

class skvenomousb2 extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skvenomousb2Mesh MODELFILE=models\skvenomousb2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skvenomousb2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skvenomousb2Anims ANIMFILE=models\skvenomousb2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skvenomousb2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skvenomousb2Mesh ANIM=skvenomousb2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skvenomousb2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=skvenomousb2Tex0  FILE=TEXTURES\skvenomousb2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skvenomousb2Mesh NUM=0 TEXTURE=skvenomousb2Tex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VENBLUE_SKIN02.bmp  Path: \\Baker\HPotterPC\Art\Design\Creatures\VenomousTentacular

defaultproperties
{
}
