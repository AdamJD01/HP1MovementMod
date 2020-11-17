//===============================================================================
//  [skpetunia] 
//===============================================================================

class skpetunia extends petunia;
//#EXEC MESH  MODELIMPORT MESH=skpetuniaMesh MODELFILE=models\skpetunia.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skpetuniaMesh X=0 Y=0 Z=50 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skpetuniaAnims ANIMFILE=models\skpetunia.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skpetuniaMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skpetuniaMesh ANIM=skpetuniaAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skpetuniaAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skpetuniaTex0  FILE=TEXTURES\PETUNIA_Skin00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skpetuniaTex1  FILE=TEXTURES\PETUNIA_Skin01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skpetuniaTex2  FILE=TEXTURES\PETUNIA_Skin02.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skpetuniaTex3  FILE=TEXTURES\pdsponge_32.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skpetuniaMesh NUM=0 TEXTURE=skpetuniaTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skpetuniaMesh NUM=1 TEXTURE=skpetuniaTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skpetuniaMesh NUM=2 TEXTURE=skpetuniaTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skpetuniaMesh NUM=3 TEXTURE=skpetuniaTex3

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: PETUNIA_Skin00.bmp  Path: H:\Art\Design\Character Development\Petunia\PetuniaModel 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: PETUNIA_Skin01.bmp  Path: H:\Art\Design\Character Development\Petunia\PetuniaModel  
// Original material [2] is [SKIN02.TWOSIDED] SkinIndex: 2 Bitmap: PETUNIA_Skin02.bmp  Path: H:\Art\Design\Character Development\Petunia\PetuniaModel 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: pdsponge_32.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Dursley Props\Sponge

defaultproperties
{
}
