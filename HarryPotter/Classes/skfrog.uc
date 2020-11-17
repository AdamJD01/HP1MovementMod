//===============================================================================
//  [skfrog] 
//===============================================================================

class skfrog extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skfrogMesh MODELFILE=models\skfrog.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skfrogMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skfrogAnims ANIMFILE=models\skfrog.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skfrogMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skfrogMesh ANIM=skfrogAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skfrogAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skfrogTex0  FILE=TEXTURES\FROG_SKIN00.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skfrogMesh NUM=0 TEXTURE=skfrogTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: FROG_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\Frog

defaultproperties
{
}
