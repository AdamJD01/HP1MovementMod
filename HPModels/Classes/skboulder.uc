//===============================================================================
//  [skboulder] 
//===============================================================================

class skboulder extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skboulderMesh MODELFILE=models\skboulderMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skboulderMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skboulderAnims ANIMFILE=models\skboulderAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skboulderMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skboulderMesh ANIM=skboulderAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skboulderAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skboulderTex0  FILE=TEXTURES\skboulderTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skboulderMesh NUM=0 TEXTURE=skboulderTex0

// Original material [0] is [BOULDER_SKIN00] SkinIndex: 0 Bitmap: grayrock_128.bmp  Path: C:\Nathan

defaultproperties
{
}
