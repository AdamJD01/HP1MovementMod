//===============================================================================
//  [skquidplayerf1] 
//===============================================================================

class skquidplayerf1 extends HPMesh abstract;
//#EXEC MESH  MODELIMPORT MESH=skquidplayerf1Mesh MODELFILE=models\skquidplayerf1.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=skquidplayerf1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=skquidplayerf1Anims ANIMFILE=models\skquidplayerf1.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=skquidplayerf1Mesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=skquidplayerf1Mesh ANIM=skquidplayerf1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=skquidplayerf1Anims VERBOSE

//#EXEC TEXTURE IMPORT NAME=skquidplayerf1Tex0  FILE=TEXTURES\FQUID1_SKIN00.bmp  GROUP=Skins
//#EXEC TEXTURE IMPORT NAME=skquidplayerf1Tex1  FILE=TEXTURES\FQUID1_SKIN01.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidplayerf1Mesh NUM=0 TEXTURE=skquidplayerf1Tex0
//#EXEC MESHMAP SETTEXTURE MESHMAP=skquidplayerf1Mesh NUM=1 TEXTURE=skquidplayerf1Tex1

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: FQUID1_SKIN00.bmp  Path: C:\~Work\Harry Potter\Characters\FQuidditch1 
// Original material [1] is [SKIN01] SkinIndex: 1 Bitmap: FQUID1_SKIN01.bmp  Path: C:\~Work\Harry Potter\Characters\FQuidditch1

defaultproperties
{
}
