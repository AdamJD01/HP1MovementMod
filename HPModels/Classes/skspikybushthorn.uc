//===============================================================================
//  [skspikybushthorn] 
//===============================================================================

class skspikybushthorn extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skspikybushthornMesh MODELFILE=models\skspikybushthornMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skspikybushthornMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skspikybushthornAnims ANIMFILE=models\skspikybushthornAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skspikybushthornMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skspikybushthornMesh ANIM=skspikybushthornAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skspikybushthornAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skspikybushthornTex0  FILE=TEXTURES\skspikybushthornTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skspikybushthornMesh NUM=0 TEXTURE=skspikybushthornTex0

// Original material [0] is [SPIKYBUSH_SKIN00] SkinIndex: 0 Bitmap: SPIKYBUSHSPIKE.bmp  Path: H:\Art\Design\Creatures\Spiky Bush

defaultproperties
{
}
