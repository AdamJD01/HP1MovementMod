//===============================================================================
//  [skvoldemort] 
//===============================================================================

class skvoldemort extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skvoldemortMesh MODELFILE=models\skvoldemortMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skvoldemortMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skvoldemortAnims ANIMFILE=models\skvoldemortAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skvoldemortMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skvoldemortMesh ANIM=skvoldemortAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skvoldemortAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skvoldemortTex0  FILE=TEXTURES\skvoldemortTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvoldemortTex1  FILE=TEXTURES\skvoldemortTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skvoldemortTex2  FILE=TEXTURES\skvoldemortTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skvoldemortMesh NUM=0 TEXTURE=skvoldemortTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skvoldemortMesh NUM=1 TEXTURE=skvoldemortTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=skvoldemortMesh NUM=2 TEXTURE=skvoldemortTex2

#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=walk TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=walk TIME=0.5 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=walk_b TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=walk_b TIME=0.5 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=strafe_r TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=strafe_r TIME=0.5 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=strafe_l TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skVoldemortAnims SEQ=strafe_l TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VOLD_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Voldemort 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: VOLD_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Voldemort 
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: VOLD_SKIN02.bmp  Path: C:\~Work\Harry Potter\Characters\Voldemort

defaultproperties
{
}
