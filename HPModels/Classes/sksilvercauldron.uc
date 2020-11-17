//===============================================================================
//  [sksilvercauldron] 
//===============================================================================

class sksilvercauldron extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=sksilvercauldronMesh MODELFILE=models\sksilvercauldronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=sksilvercauldronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=sksilvercauldronAnims ANIMFILE=models\sksilvercauldronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=sksilvercauldronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=sksilvercauldronMesh ANIM=sksilvercauldronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=sksilvercauldronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=sksilvercauldronTex0  FILE=TEXTURES\sksilvercauldronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=sksilvercauldronMesh NUM=0 TEXTURE=sksilvercauldronTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: flipcouldronslv_128.bmp  Path: C:\potter\ART\Objects\FLIPENDO\Flipendo Cauldrons

defaultproperties
{
}
