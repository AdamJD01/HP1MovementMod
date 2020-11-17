//===============================================================================
//  [skronclass] 
//===============================================================================

class skronclass extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skronclassMesh MODELFILE=models\skronclass.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skronclassMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skronclassAnims ANIMFILE=models\skronclass.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skronclassMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skronclassMesh ANIM=skronclassAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skronclassAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skronclassTex0  FILE=TEXTURES\RON_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skronclassTex1  FILE=TEXTURES\RON_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skronclassTex2  FILE=TEXTURES\RON_SKIN02.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skronclassTex3  FILE=TEXTURES\StudentDesk2_128.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skronclassTex4  FILE=TEXTURES\WrteQuil_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skronclassMesh NUM=0 TEXTURE=skronclassTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skronclassMesh NUM=1 TEXTURE=skronclassTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skronclassMesh NUM=2 TEXTURE=skronclassTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skronclassMesh NUM=3 TEXTURE=skronclassTex3
//#EXEC MESHMAP SETTEXTURE MESHMAP=skronclassMesh NUM=4 TEXTURE=skronclassTex4

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: RON_SKIN00.bmp  Path: H:\Art\Design\Character Development\Ron\RonNew 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: RON_SKIN01.bmp  Path: H:\Art\Design\Character Development\Ron\RonNew 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: RON_SKIN02.bmp  Path: H:\Art\Design\Character Development\Ron\RonNew 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: StudentDesk2_128.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Hogwarts Props\Transfigurations Class\Student Desk 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: WrteQuil_128.bmp  Path: \\Baker\HPotterPC\Art\Design\Character Development\Hermione\Hermione New

defaultproperties
{
}
