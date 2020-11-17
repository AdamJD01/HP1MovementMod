//===============================================================================
//  [skremharry] 
//===============================================================================

class skremharry extends actor;
//#EXEC MESH  MODELIMPORT MESH=skremharryMesh MODELFILE=models\skremharry.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skremharryMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skremharryAnims ANIMFILE=models\skquidharry.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skremharryMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skremharryMesh ANIM=skremharryAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skremharryAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skremharryTex0  FILE=TEXTURES\HARRYR_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skremharryTex1  FILE=TEXTURES\HARRYR_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skremharryTex2  FILE=TEXTURES\HARRYR_SKIN05.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skremharryTex4  FILE=TEXTURES\QUID_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skremharryMesh NUM=0 TEXTURE=skremharryTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skremharryMesh NUM=1 TEXTURE=skremharryTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skremharryMesh NUM=2 TEXTURE=skremharryTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skremharryMesh NUM=3 TEXTURE=skharryTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skremharryMesh NUM=4 TEXTURE=skremharryTex4

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HARRYR_SKIN00.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HARRYR_SKIN01.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: HARRYR_SKIN05.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [3] is [SKIN03.MASKED] SkinIndex: 3 Bitmap: HARRY_SKIN03.bmp  Path: H:\Art\Design\Character Development\Harry 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: QUID_SKIN01.bmp  Path: H:\Art\Design\Character Development\Harry 

auto state foo	//cmp 10-17 fix for log spam
{
}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skremharryMesh'
}
