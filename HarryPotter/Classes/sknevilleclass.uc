//===============================================================================
//  [sknevilleclass] 
//===============================================================================

class sknevilleclass extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=sknevilleclassMesh MODELFILE=models\sknevilleclass.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=sknevilleclassMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=sknevilleclassAnims ANIMFILE=models\sknevilleclass.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=sknevilleclassMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=sknevilleclassMesh ANIM=sknevilleclassAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=sknevilleclassAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=sknevilleclassTex0  FILE=TEXTURES\NEVILLE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=sknevilleclassTex1  FILE=TEXTURES\NEVILLE_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=sknevilleclassTex2  FILE=TEXTURES\StudentDesk3_128.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=sknevilleclassTex3  FILE=TEXTURES\WrteQuil_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=sknevilleclassMesh NUM=0 TEXTURE=sknevilleclassTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=sknevilleclassMesh NUM=1 TEXTURE=sknevilleclassTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=sknevilleclassMesh NUM=2 TEXTURE=sknevilleclassTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=sknevilleclassMesh NUM=3 TEXTURE=sknevilleclassTex3

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: NEVILLE_SKIN00.bmp  Path: H:\Art\Design\Character Development\Neville Longbottom 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: NEVILLE_SKIN01.bmp  Path: H:\Art\Design\Character Development\Neville Longbottom 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: StudentDesk3_128.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Hogwarts Props\Transfigurations Class\Student Desk 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: WrteQuil_128.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Hermione\Hermione New

defaultproperties
{
}
