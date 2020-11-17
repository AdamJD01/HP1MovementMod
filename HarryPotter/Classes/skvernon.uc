//===============================================================================
//  [skvernon] 
//===============================================================================

class skvernon extends vernon;
//#EXEC MESH  MODELIMPORT MESH=skvernonMesh MODELFILE=models\skvernon.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skvernonMesh X=0 Y=0 Z=50 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skvernonAnims ANIMFILE=models\skvernon.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skvernonMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skvernonMesh ANIM=skvernonAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skvernonAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skvernonTex0  FILE=TEXTURES\VERNON_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skvernonTex1  FILE=TEXTURES\VERNON_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skvernonMesh NUM=0 TEXTURE=skvernonTex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skvernonMesh NUM=1 TEXTURE=skvernonTex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: VERNON_SKIN00.bmp  Path: H:\Art\Design\Character Development\Vernon 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: VERNON_SKIN01.bmp  Path: H:\Art\Design\Character Development\Vernon

defaultproperties
{
}
