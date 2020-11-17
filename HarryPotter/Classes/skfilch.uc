//===============================================================================
//  [skfilch] 
//===============================================================================

class skfilch extends actor;
//#EXEC MESH  MODELIMPORT MESH=skfilchMesh MODELFILE=models\skfilch.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skfilchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skfilchAnims ANIMFILE=models\skfilch.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skfilchMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skfilchMesh ANIM=skfilchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skfilchAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skfilchTex0  FILE=TEXTURES\FILCH_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skfilchTex1  FILE=TEXTURES\FILCH_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skfilchTex2  FILE=TEXTURES\FILCH_SKIN02.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skfilchTex3  FILE=TEXTURES\Filtchbr_128.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchMesh NUM=0 TEXTURE=skfilchTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchMesh NUM=1 TEXTURE=skfilchTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchMesh NUM=2 TEXTURE=skfilchTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skfilchMesh NUM=3 TEXTURE=skfilchTex3

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: FILCH_SKIN00.bmp  Path: C:\potter_art\Characters\Filch 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: FILCH_SKIN01.bmp  Path: C:\potter_art\Characters\Filch 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: FILCH_SKIN02.bmp  Path: C:\potter_art\Characters\Filch 
// Original material [3] is [SKIN03] SkinIndex: 3 Bitmap: Filtchbr_128.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Hogwarts Props\Brooms\Flitchs Broom

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skfilchMesh'
}
