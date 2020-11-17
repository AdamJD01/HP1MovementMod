//===============================================================================
//  [sknorbert] 
//===============================================================================

class sknorbert extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=sknorbertMesh MODELFILE=models\sknorbertMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=sknorbertMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=sknorbertAnims ANIMFILE=models\sknorbertAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=sknorbertMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=sknorbertMesh ANIM=sknorbertAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=sknorbertAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=sknorbertTex0  FILE=TEXTURES\sknorbertTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=sknorbertTex1  FILE=TEXTURES\sknorbertTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=sknorbertMesh NUM=0 TEXTURE=sknorbertTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=sknorbertMesh NUM=1 TEXTURE=sknorbertTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: NORBERT_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Norbert 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: NORBERT_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Norbert

defaultproperties
{
}
