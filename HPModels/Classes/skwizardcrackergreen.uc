//===============================================================================
//  [skwizardcrackergreen] 
//===============================================================================

class skwizardcrackergreen extends actor;
#exec MESH  MODELIMPORT MESH=skwizardcrackergreenMesh MODELFILE=models\skwizardcrackergreenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skwizardcrackergreenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skwizardcrackergreenAnims ANIMFILE=models\skwizardcrackergreenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skwizardcrackergreenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skwizardcrackergreenMesh ANIM=skwizardcrackergreenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skwizardcrackergreenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skwizardcrackergreenTex0  FILE=TEXTURES\skwizardcrackergreenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skwizardcrackergreenMesh NUM=0 TEXTURE=skwizardcrackergreenTex0

// Original material [0] is [CRACKER_SKIN00] SkinIndex: 0 Bitmap: wzrdckgr_128.bmp  Path: C:\Nathan

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skwizardcrackergreenMesh'
}
