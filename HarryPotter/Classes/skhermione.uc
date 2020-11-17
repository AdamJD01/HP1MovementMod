//===============================================================================
//  [skhermione] 
//===============================================================================

class skhermione extends actor;
//#EXEC MESH  MODELIMPORT MESH=skhermioneMesh MODELFILE=models\skhermione.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skhermioneMesh X=0 Y=0 Z=42 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skhermioneAnims ANIMFILE=models\skhermione.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skhermioneMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skhermioneMesh ANIM=skhermioneAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skhermioneAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skhermioneTex0  FILE=TEXTURES\HERMIONE_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhermioneTex1  FILE=TEXTURES\HERMIONE_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skhermioneTex2  FILE=TEXTURES\HERMIONE_SKIN02.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneMesh NUM=0 TEXTURE=skhermioneTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneMesh NUM=1 TEXTURE=skhermioneTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skhermioneMesh NUM=2 TEXTURE=skhermioneTex2

//#EXEC ANIM NOTIFY   ANIM=skhermioneAnims SEQ=run TIME=0.99 FUNCTION=PlayFootStep
//#EXEC ANIM NOTIFY   ANIM=skhermioneAnims SEQ=run TIME=0.5 FUNCTION=PlayFootStep

// Original material [0] is [HERMIONE_SKIN00] SkinIndex: 0 Bitmap: HERMIONE_SKIN00.bmp  Path: H:\Art\Design\Character Development\Hermione\Hermione New 
// Original material [1] is [HERMIONE_SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HERMIONE_SKIN01.bmp  Path: H:\Art\Design\Character Development\Hermione\Hermione New 
// Original material [2] is [HERMIONE_SKIN02] SkinIndex: 2 Bitmap: HERMIONE_SKIN02.bmp  Path: H:\Art\Design\Character Development\Hermione\Hermione New

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhermioneMesh'
}
