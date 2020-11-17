//===============================================================================
//  [skhagrid] 
//===============================================================================

class skhagrid extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skhagridMesh MODELFILE=models\skhagrid.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skhagridMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skhagridAnims ANIMFILE=models\skhagrid.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skhagridMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skhagridMesh ANIM=skhagridAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skhagridAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skhagridTex0  FILE=TEXTURES\HAGRID_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhagridTex1  FILE=TEXTURES\HAGRID_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skhagridMesh NUM=0 TEXTURE=skhagridTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhagridMesh NUM=1 TEXTURE=skhagridTex1

//#EXEC ANIM NOTIFY   ANIM=skhagridAnims SEQ=walk TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skhagridAnims SEQ=walk TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HAGRID_SKIN00.bmp  Path: C:\POTTER\HarryPotter\Textures 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HAGRID_SKIN01.bmp  Path: C:\POTTER\HarryPotter\Textures

defaultproperties
{
}
