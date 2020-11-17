//===============================================================================
//  [skhermioneclass] 
//===============================================================================

class skhermioneclass extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skhermioneclassMesh MODELFILE=models\skhermioneclass.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skhermioneclassMesh X=0 Y=0 Z=30 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skhermioneclassAnims ANIMFILE=models\skhermioneclass.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skhermioneclassMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skhermioneclassMesh ANIM=skhermioneclassAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skhermioneclassAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skhermioneclassTex0  FILE=TEXTURES\HERMIONE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhermioneclassTex1  FILE=TEXTURES\HERMIONE_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhermioneclassTex2  FILE=TEXTURES\HERMIONE_SKIN02.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhermioneclassTex3  FILE=TEXTURES\StudentDesk2_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneclassMesh NUM=0 TEXTURE=skhermioneclassTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneclassMesh NUM=1 TEXTURE=skhermioneclassTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneclassMesh NUM=2 TEXTURE=skhermioneclassTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneclassMesh NUM=3 TEXTURE=skhermioneclassTex3

// Original material [0] is [HERMIONE_SKIN00] SkinIndex: 0 Bitmap: HERMIONE_SKIN00.bmp  Path: H:\Art\Design\Character Development\Hermione\Hermione New 
// Original material [1] is [HERMIONE_SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HERMIONE_SKIN01.bmp  Path: H:\Art\Design\Character Development\Hermione\Hermione New 
// Original material [2] is [HERMIONE_SKIN02.MASKED] SkinIndex: 2 Bitmap: HERMIONE_SKIN02.bmp  Path: H:\Art\Design\Character Development\Hermione\Hermione New 
// Original material [3] is [HERMIONE_SKIN03] SkinIndex: 3 Bitmap: StudentDesk2_128.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Hogwarts Props\Transfigurations Class\Student Desk

defaultproperties
{
}
