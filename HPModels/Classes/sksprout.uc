//===============================================================================
//  [sksprout] 
//===============================================================================

class sksprout extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=sksproutMesh MODELFILE=models\sksproutMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=sksproutMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=sksproutAnims ANIMFILE=models\sksproutAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=sksproutMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=sksproutMesh ANIM=sksproutAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=sksproutAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=sksproutTex0  FILE=TEXTURES\sksproutTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=sksproutTex1  FILE=TEXTURES\sksproutTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=sksproutTex2  FILE=TEXTURES\sksproutTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=sksproutMesh NUM=0 TEXTURE=sksproutTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=sksproutMesh NUM=1 TEXTURE=sksproutTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=sksproutMesh NUM=2 TEXTURE=sksproutTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: SPROUT_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Sprout 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: SPROUT_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Sprout 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: SPROUT_SKIN02.bmp  Path: C:\~Work\Harry Potter\Characters\Sprout

defaultproperties
{
}
