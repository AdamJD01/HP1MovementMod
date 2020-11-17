//===============================================================================
//  [skwizardcracker] 
//===============================================================================

class skwizardcracker extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skwizardcrackerMesh MODELFILE=models\skwizardcrackerMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skwizardcrackerMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skwizardcrackerAnims ANIMFILE=models\skwizardcrackerAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skwizardcrackerMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skwizardcrackerMesh ANIM=skwizardcrackerAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skwizardcrackerAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skwizardcrackerTex0  FILE=TEXTURES\skwizardcrackerTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skwizardcrackerMesh NUM=0 TEXTURE=skwizardcrackerTex0

// Original material [0] is [CRACKER_SKIN00] SkinIndex: 0 Bitmap: wzrdcrkr_128.bmp  Path: C:\Nathan

defaultproperties
{
}
