//===============================================================================
//  [skflowerpot] 
//===============================================================================

class skflowerpot extends actor;
#exec MESH  MODELIMPORT MESH=skflowerpotMesh MODELFILE=models\skflowerpotMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skflowerpotMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skflowerpotAnims ANIMFILE=models\skflowerpotAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skflowerpotMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skflowerpotMesh ANIM=skflowerpotAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skflowerpotAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skflowerpotTex0  FILE=TEXTURES\skflowerpotTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skflowerpotMesh NUM=0 TEXTURE=skflowerpotTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: FlowerGrow.bmp  Path: C:\potter\HarryPotter

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skflowerpotMesh'
}
