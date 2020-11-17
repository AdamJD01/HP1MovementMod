//===============================================================================
//  [skgoldcauldron] 
//===============================================================================

class skgoldcauldron extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skgoldcauldronMesh MODELFILE=models\skgoldcauldronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skgoldcauldronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skgoldcauldronAnims ANIMFILE=models\skgoldcauldronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skgoldcauldronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skgoldcauldronMesh ANIM=skgoldcauldronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skgoldcauldronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skgoldcauldronTex0  FILE=TEXTURES\skgoldcauldronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skgoldcauldronMesh NUM=0 TEXTURE=skgoldcauldronTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: flipcouldrongld_128.bmp  Path: C:\potter\ART\Objects\FLIPENDO\Flipendo Cauldrons

defaultproperties
{
}
