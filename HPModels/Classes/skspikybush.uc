//===============================================================================
//  [skspikybush] 
//===============================================================================

class skspikybush extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skspikybushMesh MODELFILE=models\skspikybushMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skspikybushMesh X=0 Y=0 Z=20 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skspikybushAnims ANIMFILE=models\skspikybushAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skspikybushMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skspikybushMesh ANIM=skspikybushAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skspikybushAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skspikybushTex0  FILE=TEXTURES\skspikybushTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skspikybushMesh NUM=0 TEXTURE=skspikybushTex0

// Original material [0] is [SPIKYBUSH_SKIN00] SkinIndex: 0 Bitmap: SPIKYBUSH_SKIN00.bmp  Path: H:\Art\Design\Creatures\Spiky Bush

defaultproperties
{
}
