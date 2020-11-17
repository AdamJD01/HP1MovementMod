//===============================================================================
//  [skwizardcrackerpurple] 
//===============================================================================

class skwizardcrackerpurple extends actor;
#exec MESH  MODELIMPORT MESH=skwizardcrackerpurpleMesh MODELFILE=models\skwizardcrackerpurpleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skwizardcrackerpurpleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skwizardcrackerpurpleAnims ANIMFILE=models\skwizardcrackerpurpleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skwizardcrackerpurpleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skwizardcrackerpurpleMesh ANIM=skwizardcrackerpurpleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skwizardcrackerpurpleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skwizardcrackerpurpleTex0  FILE=TEXTURES\skwizardcrackerpurpleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skwizardcrackerpurpleMesh NUM=0 TEXTURE=skwizardcrackerpurpleTex0

// Original material [0] is [CRACKER_SKIN00] SkinIndex: 0 Bitmap: wzrdckpl_128.bmp  Path: C:\Nathan

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skwizardcrackerpurpleMesh'
}
