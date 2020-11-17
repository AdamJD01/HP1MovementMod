//===============================================================================
//  [skwizardcrackeryellow] 
//===============================================================================

class skwizardcrackeryellow extends actor;
#exec MESH  MODELIMPORT MESH=skwizardcrackeryellowMesh MODELFILE=models\skwizardcrackeryellowMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skwizardcrackeryellowMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skwizardcrackeryellowAnims ANIMFILE=models\skwizardcrackeryellowAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skwizardcrackeryellowMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skwizardcrackeryellowMesh ANIM=skwizardcrackeryellowAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skwizardcrackeryellowAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skwizardcrackeryellowTex0  FILE=TEXTURES\skwizardcrackeryellowTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skwizardcrackeryellowMesh NUM=0 TEXTURE=skwizardcrackeryellowTex0

// Original material [0] is [CRACKER_SKIN00] SkinIndex: 0 Bitmap: wzrdckyl_128.bmp  Path: C:\Nathan

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skwizardcrackeryellowMesh'
}
