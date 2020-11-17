//===============================================================================
//  [skpercy] 
//===============================================================================

class skpercy extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skpercyMesh MODELFILE=models\skpercyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skpercyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skpercyAnims ANIMFILE=models\skpercyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skpercyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skpercyMesh ANIM=skpercyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skpercyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skpercyTex0  FILE=TEXTURES\skpercyTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=skpercyTex1  FILE=TEXTURES\skpercyTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skpercyMesh NUM=0 TEXTURE=skpercyTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=skpercyMesh NUM=1 TEXTURE=skpercyTex1

#exec ANIM NOTIFY   ANIM=skpercyAnims SEQ=Walk TIME=0.99 FUNCTION=PlayFootStep
#exec ANIM NOTIFY   ANIM=skpercyAnims SEQ=Walk TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: PERCY_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Percy 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: PERCY_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\Percy

defaultproperties
{
}
