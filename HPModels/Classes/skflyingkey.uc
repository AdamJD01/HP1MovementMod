//===============================================================================
//  [skflyingkey] 
//===============================================================================

class skflyingkey extends HPMesh abstract;
#exec MESH  MODELIMPORT MESH=skflyingkeyMesh MODELFILE=models\skflyingkeyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skflyingkeyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skflyingkeyAnims ANIMFILE=models\skflyingkeyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skflyingkeyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skflyingkeyMesh ANIM=skflyingkeyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skflyingkeyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skflyingkeyTex0  FILE=TEXTURES\skflyingkeyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skflyingkeyMesh NUM=0 TEXTURE=skflyingkeyTex0

// Original material [0] is [FLYINGKEY_SKIN00] SkinIndex: 0 Bitmap: FLYINGKEY_SKIN00.bmp  Path: H:\Art\Design\Creatures\FlyingKey

defaultproperties
{
}
