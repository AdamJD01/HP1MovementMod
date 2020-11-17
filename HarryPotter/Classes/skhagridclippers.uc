//===============================================================================
//  [skhagridclippers] 
//===============================================================================

class skhagridclippers extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skhagridclippersMesh MODELFILE=models\skhagridclippers.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skhagridclippersMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skhagridclippersAnims ANIMFILE=models\skhagridclippers.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skhagridclippersMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skhagridclippersMesh ANIM=skhagridclippersAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skhagridclippersAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skhagridclippersTex0  FILE=TEXTURES\HAGRID_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhagridclippersTex1  FILE=TEXTURES\HAGRID_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhagridclippersTex2  FILE=TEXTURES\Clippers.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skhagridclippersMesh NUM=0 TEXTURE=skhagridclippersTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhagridclippersMesh NUM=1 TEXTURE=skhagridclippersTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhagridclippersMesh NUM=2 TEXTURE=skhagridclippersTex2

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HAGRID_SKIN00.bmp  Path: C:\POTTER\Art\Characters\Hagrid Clippers 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HAGRID_SKIN01.bmp  Path: C:\POTTER\Art\Characters\Hagrid Clippers 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: Clippers.bmp  Path: C:\POTTER\Art\Characters\Hagrid Clippers

defaultproperties
{
}
