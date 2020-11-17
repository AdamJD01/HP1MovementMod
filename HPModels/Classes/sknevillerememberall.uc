//===============================================================================
//  [sknevillerememberall] 
//===============================================================================

class sknevillerememberall extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=sknevillerememberallMesh MODELFILE=models\sknevillerememberallMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=sknevillerememberallMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=sknevillerememberallAnims ANIMFILE=models\sknevillerememberallAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=sknevillerememberallMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=sknevillerememberallMesh ANIM=sknevillerememberallAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=sknevillerememberallAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=sknevillerememberallTex0  FILE=TEXTURES\sknevillerememberallTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=sknevillerememberallTex1  FILE=TEXTURES\sknevillerememberallTex1.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=sknevillerememberallTex2  FILE=TEXTURES\sknevillerememberallTex2.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=sknevillerememberallMesh NUM=0 TEXTURE=sknevillerememberallTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=sknevillerememberallMesh NUM=1 TEXTURE=sknevillerememberallTex1
#EXEC MESHMAP SETTEXTURE MESHMAP=sknevillerememberallMesh NUM=2 TEXTURE=sknevillerememberallTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: NEVILLE_SKIN00.bmp  Path: C:\POTTER\HarryPotter\Textures 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: NEVILLE_SKIN01.bmp  Path: C:\POTTER\HarryPotter\Textures 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: RememberAll.bmp  Path: C:\~Work\Harry Potter\Characters\Neville

defaultproperties
{
}
