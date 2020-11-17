//===============================================================================
//  [skironchest] 
//===============================================================================

class skironchest extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skironchestMesh MODELFILE=models\skironchestMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skironchestMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skironchestAnims ANIMFILE=models\skironchestAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skironchestMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skironchestMesh ANIM=skironchestAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skironchestAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skironchestTex0  FILE=TEXTURES\skironchestTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skironchestMesh NUM=0 TEXTURE=skironchestTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: irntrunk_128.bmp  Path: C:\Nathan

defaultproperties
{
}
