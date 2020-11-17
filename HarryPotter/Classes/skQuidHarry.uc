//===============================================================================
//  [skquidharry] 
//===============================================================================

class skquidharry extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skquidharryMesh MODELFILE=models\skquidharry.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skquidharryMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skquidharryAnims ANIMFILE=models\skquidharry.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skquidharryMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skquidharryMesh ANIM=skquidharryAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skquidharryAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skquidharryTex0  FILE=TEXTURES\HARRYQ_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skquidharryTex1  FILE=TEXTURES\HARRYQ_SKIN01.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skquidharryTex2  FILE=TEXTURES\HARRYQ_SKIN05.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skquidharryTex4  FILE=TEXTURES\QUID_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidharryMesh NUM=0 TEXTURE=skquidharryTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidharryMesh NUM=1 TEXTURE=skquidharryTex1
//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidharryMesh NUM=2 TEXTURE=skquidharryTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidharryMesh NUM=3 TEXTURE=skharryTex2
//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidharryMesh NUM=4 TEXTURE=skquidharryTex4

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: HARRYQ_SKIN00.bmp  Path: C:\potter_art\Characters\Harry Quidditch 
// Original material [1] is [SKIN01.TWOSIDED] SkinIndex: 1 Bitmap: HARRYQ_SKIN01.bmp  Path: C:\potter_art\Characters\Harry Quidditch 
// Original material [2] is [SKIN02] SkinIndex: 2 Bitmap: HARRYQ_SKIN05.bmp  Path: C:\potter_art\Characters\Harry Quidditch 
// Original material [3] is [SKIN03.MASKED] SkinIndex: 3 Bitmap: HARRY_SKIN03.bmp  Path: C:\potter_art\Characters\Harry Quidditch 
// Original material [4] is [SKIN04] SkinIndex: 4 Bitmap: QUID_SKIN01.bmp  Path: C:\potter_art\Characters\Harry Quidditch

defaultproperties
{
}
